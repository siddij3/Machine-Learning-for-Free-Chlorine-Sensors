
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

total_params = [];
voltageApplied = [];
% -----------------------------------------------------------------

% DECLARING CONSTANTS--------------------------------------------
SENSOR_AREA = pi*(1.5)^2; % Area is in mm^2. Diameter is 3 mm
FARADAYS_CONSTANT = 96485332; % µC/mol because the main units we're using are µC
START_TIME = 21;
MID_TIME = 31;
END_TIME = 51;
%--------------------------------------------------------------------

for num_iterations = 1:length(all_data)
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


  %% ================== Part 2: Obtain  meaningful information =================
  % chronoamperometry equation is I(t) = k*t^(-0.5)

  % Plot Current / area  vs.  1/root(time) - Should give me a linear plot?
  I_A = (chrono_data) / SENSOR_AREA;
  fcl_conc = convertPPM(fcl_ppm); %in mol/L
  total_fcl_conc{num_iterations} = [ fcl_conc; fcl_ppm];

  % D_a: units in mm^2 / s
  % Units   :                   (s,         µA,     mol/L,        mm^2,            µC/mol)
  Diffusion_const = isolateDiffusion(t, chrono_data, fcl_conc, SENSOR_AREA, FARADAYS_CONSTANT);

  Diffusion_avg_std{num_iterations} = ...
  [ mean(Diffusion_const(START_TIME:END_TIME, :)); ...
    std(Diffusion_const(START_TIME:END_TIME, :))];

  %Units: µA/s^1/2
  k = isolateConstants(t, chrono_data);


  % Relevant plots
  #{
  plotData(t(1:END_TIME), -k(1:END_TIME, :), ...
  'Time (t)', ...
  'Cottrel Constant k (A*s^{1/2})', ...
  'Isolating the Cottrel Constant (k) w.r.t. I*t^{1/2}', 'north');

  plotData(1./sqrt(t)(MID_TIME:END_TIME), -chrono_data(MID_TIME:END_TIME, :), ...
  'Time (t^{-1/2} (s^{-1/2})', ...
  'Current per Area (A/mm^2)', ...
  'Finding the slope of Diffusion and other relevant parameters', 'northeast');

  plotData(fcl_conc, Diffusion_const(MID_TIME:END_TIME, :), ...
  'Free chlorine Concetration (mol/L)', ...
  'Diffusion (Area/Second) (mm^2/s)', ...
  'Diffusion rate of Free chlorine with varying concentrations', 'southeast');

  plotData(t(1:END_TIME), Diffusion_const(1:END_TIME, :), ...
  'Time (s)', ...
  'Diffusion (Area/Second) (mm^2/s)', ...
  'Diffusion of Free chlorine over time', 'south');
  #}

  %pause;
  % Identify relationship between voltage and other Parameters
    %For this, see regular expressions
end

DIFF_AVG_INDEX = 1;
DIFF_STD_INDEX = 2;
LENGTH_DIFFUSION_SAMPLES = length(Diffusion_avg_std);

FCL_CONC_INDEX = 1;


theta_diffusion = zeros(2, LENGTH_DIFFUSION_SAMPLES);
lambda = 0;



% MAke the 1s and then the fcl columns
% X = [ones(m, 1), data(:,1)];

% Organizing paramters

% HI FAISAL i NEED YOUR HELP HERE

for i = 7

  x = total_fcl_conc{i}(FCL_CONC_INDEX,:);
  y = Diffusion_avg_std{i}(DIFF_AVG_INDEX,:);
  m = size(x)(2);

  X = [ones(m, 1), x'];

  [theta_diffusion(:, i)] = trainLinearReg(X, y' , lambda);

  plotlogPlot(X, y, theta_diffusion(:, i), ...
      'Concentration of Free Chlorine (mol/L)',
      'Diffusion of Free Chlorine (mm^2/s)' ,
      'Log Plot of Diffusion of Free Chlorine vs. Concentration',
      'north',
      false);

      grid on;
      hold on;
end
hold off;
pause;

% UNTIL HERE THANKS




% (This should go at the end of the for loop)
  % =========== Part 3: Train Linear Regression with sensitivity =============
#{
  lambda = 0;
  theta_sens = zeros(2, length(chrono_data));

  for i = 1:length(chrono_data)
    [theta_sens(:, i)] = trainLinearReg(fcl_ppm, chrono_data(:, i), lambda);
  end
  %  Plot fit over the data
  plotFit_reduced(fcl_ppm, chrono_data(:, MID_TIME:end), theta_sens(:, MID_TIME:end), ...
  'Free Chlorine Concentration (ppm) (x)', ...
  'Current (µA) (y)', filepath(num_iterations).name,
  'southeast');

  hold off;

  #}
