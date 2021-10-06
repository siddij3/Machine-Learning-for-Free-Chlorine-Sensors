
%% Initialization
clear ; close all; clc

%% ==================== Part 0: Loading Data ====================
fprintf('Loading Data ... \n\n');

filepath = dir('Data/*.csv');
all_data = loadData(filepath, 'csv');


% ARRAYS THAT CONTAIN EXPERIMENTAL PARAMETERS----------------------

% 3D Array. X: across fcl ; Y: Average, STD ; Z: Different data sets
Diffusion_avg_std = {};
total_fcl_conc = {};
total_chrono_data = {};

total_params = [];
voltageApplied = [];
% -----------------------------------------------------------------

% DECLARING CONSTANTS--------------------------------------------
SENSOR_RADIUS = 1.5E-3; %units are in m;
SENSOR_AREA = pi*(SENSOR_RADIUS)^2; % Area is in m^2. Diameter is 3E-3 m
FARADAYS_CONSTANT = 96485.332; % C/mol because they're standard units
START_TIME = 21;
MID_TIME = 31;
END_TIME = 51;
%--------------------------------------------------------------------

for num_iterations = 2:2 %:length(all_data)
  close all;
%% ==================== Part 1: Parsing Data ====================

  fprintf('Separating Data ...\n\n');
  [fcl_ppm, chrono_data,  params, t, m] = parseData(all_data{num_iterations}, num_iterations);

  total_params = [total_params; params];

  fprintf(filepath(num_iterations).name);
  fprintf('\n\n');

  fprintf('Making matrix of Parameters ...\n\n');
  X = settingChronoParams(fcl_ppm, t, params);
  X_scaled = featureScaling(X);

  %%================== Separating Parameters ==================================
  voltageApplied(num_iterations) = params(1); %Make this a function later


  %% ================== Part 2: Obtain  meaningful information =================

  % Plot Current / area
  I_A = (chrono_data) / SENSOR_AREA;
  fcl_conc = convertPPM(fcl_ppm); %in mol/L
  total_fcl_conc{num_iterations} = [ fcl_conc; fcl_ppm];

  total_chrono_data{num_iterations} = [chrono_data(MID_TIME:end, :)];

  % D_a: units in mm^2 / s
  % Units   :                       (s,         A,     mol/L,        m^2,            C/mol)
  Diffusion_const = isolateDiffusion(t, chrono_data, fcl_conc, SENSOR_AREA, FARADAYS_CONSTANT);

  Diffusion_avg_std{num_iterations} = ...
  [ mean(Diffusion_const(START_TIME:END_TIME, :)); ...
    std(Diffusion_const(START_TIME:END_TIME, :))];

  %plot(t(2:end), tmp);
  %% ================== Part 2b: Time Constants =================

  % Units:                   (s,           mm^2/s,           mm)

  %% ================== PLOTS ====================================




  plotData(t(1:END_TIME), Diffusion_const(1:END_TIME, :), ...
  'Time (s)', ...
  'Diffusion (Area/Second) (mm^2/s)', ...
  'Diffusion of Free chlorine over time', 'south');



  plotData(1./sqrt(t)(MID_TIME:END_TIME), -chrono_data(MID_TIME:END_TIME, :), ...
  'Time (t^{-1/2} (s^{-1/2})', ...
  'Current per Area (µA/mm^2)', ...
  'Finding the slope of Diffusion and other relevant parameters', 'northeast');

  plotData(fcl_conc, Diffusion_const(MID_TIME:END_TIME, :), ...
  'Free chlorine Concetration (mol/L)', ...
  'Diffusion (Area/Second) (mm^2/s)', ...
  'Diffusion rate of Free chlorine with varying concentrations', 'southeast');
  pause;

end

DIFF_AVG_INDEX = 1;
DIFF_STD_INDEX = 2;
LENGTH_DIFFUSION_SAMPLES = length(Diffusion_avg_std);

FCL_CONC_INDEX = 1;


theta_diffusion = zeros(2, LENGTH_DIFFUSION_SAMPLES);
lambda = 0;

% Organizing paramters

% HI FAISAL i NEED YOUR HELP HERE

% Identify relationship between voltage and other Parameters
  %For this, see regular expressions
  figure;
for i = 1:LENGTH_DIFFUSION_SAMPLES

  x = log10(total_fcl_conc{i}(FCL_CONC_INDEX,:));
  x(isinf(x)) = [];

  y = log10(Diffusion_avg_std{i}(DIFF_AVG_INDEX,:));
  y(isnan(y)) = [];

  m = size(x)(2);

  X = [ones(m, 1), x'];

  [theta_diffusion(:, i)] = trainLinearReg(X, y' , lambda);

  plotFit_reduced(X, y, theta_diffusion(:, i), ...
      'Log of Concentration of Free Chlorine (log(mol/L))',
      'Log of Diffusion of Free Chlorine (mm^2/s)' ,
      'Plot of Log relationship of Diffusion of Free Chlorine vs. Concentration',
      'north',
      2);
      hold on;
      grid on;


end
pause;
hold off;


plotDataOs(voltageApplied, theta_diffusion(2, :), ...
'Applied Voltage (V)', ...
'Slope of log(Diffusion) vs. log(Concentration) (log(mm^2/s)/log(mol/L))', ...
'Trend of Diffusion with concentrations vs Applied voltage', ...
'south');

pause;

  % =========== Part 3: Train Linear Regression with sensitivity =============
  theta_sens = {};
  for i = 1:LENGTH_DIFFUSION_SAMPLES

    x = total_fcl_conc{i}(FCL_CONC_INDEX,:);
    x(isinf(x)) = [];

    y = total_chrono_data{i}(i, :);
    y(isnan(y)) = [];

    m = size(x)(2);

    X = [ones(m, 1), x'];

    for j = 1:length(total_chrono_data{i})
      [theta_sens{i}(:, j)] = trainLinearReg(X, total_chrono_data{i}(j, :)' , lambda);
    end

    sens_tmp_intercept(i) = theta_sens{i}(1, 21);
    sens_tmp(i) = theta_sens{i}(2, 21);

    %figure;
    plotFit_reduced(X, y, theta_sens{i}(:, i), ...
        'Free chlorine concentration', ...
        'Current (µC)', ...
        'sensitivity', ...
        'north',
        false);
        hold on;
        grid on;
end


plotDataOs(voltageApplied, sens_tmp, ...
'Applied Voltage (V)', ...
'Sensitivity (µA/(mol/L))', ...
'Trend of Sensitivity with Applied voltage', ...
'south');
