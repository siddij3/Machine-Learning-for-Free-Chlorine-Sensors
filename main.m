
%% Initialization
clear ; close all; clc

%% ==================== Part 0: Loading Data ====================
fprintf('Loading Data ... \n\n');

filepath = dir('Data/*.csv');
all_data = loadData(filepath, 'csv');

for num_iterations = 1:length(all_data)

  close all;
%% ==================== Part 1: Parsing Data ====================

  fprintf('Separating Data ...\n\n');
  [fcl_conc, chrono_data,  params, t, m] = parseData(all_data{num_iterations}, num_iterations);

  fprintf(filepath(num_iterations).name);
  fprintf('\n\n');

  fprintf('Making matrix of Parameters ...\n\n');
  X = settingChronoParams(fcl_conc, t, params);
  X_scaled = featureScaling(X);


  %% =========== Part 2: Obtain theortically meaningful information =============
  % chronoamperometry equation is I(t) = k*t^(-0.5)
  sensorArea = pi*3; % Diameter is 3 mm
  F = 96485.332; % C/mol

  k = isolateConstants(t, chrono_data);
  plotData(t(1:51), k(1:51, :), 'Time (t)','Cottrel Constant k (A*t^{1/2}', ...
  'Isolating the Cottrel Constant (k) w.r.t. I*t^{1/2}', 'north');



  % Plot Current / area  vs.  1/root(time) - Should give me a linear plot?
  %I_A = (chrono_data * sqrt(pi) ) / (sensorArea * F);
  I_A = (chrono_data) / sensorArea;

  D_a = isolateDiffusion(t, chrono_data);

  plotData(1./sqrt(t)(1:51), I_A(1:51, :), 'Time (t^{-1/2} (s^{-1/2})','Current per Area (A/mm^2)', ...
  'Finding the slope of Diffusion and other relevant parameters', 'northeast');
  pause;

  % Identify relationship between voltage and other Parameters
    %For this, see regular expressions



  %%======== Part 3: Linear Regression Analysis on logorithmic data=====
#{

  lambda = 0; %Review what this lambda is for (For high variance. Not needed atm)
  theta_chrono = zeros(size(X_scaled)(2), length(y));

  for i = 1:length(y)
    [theta_chrono(:, i)] = trainLinearReg(X_scaled, y_log, lambda);
  end
  %plot(t(30:end), reshape(log(log(-y*10)), [51, 10])(30:end, :), 'x', 'MarkerSize', 3, 'LineWidth', 0.75)


  plot(t, chrono_data, 'o', 'MarkerSize', 3, 'LineWidth', 0.75)
  xlabel('Time (t) (x)');
  ylabel('Current (µA) (y)');
  hold on;
  plot(X(:  , 2), X*theta_chrono, '--', 'LineWidth', 1)

  hold off;

  fprintf('Program paused. Press enter to continue.\n\n');
  pause;


  % =========== Part 3: Train Linear Regression with sensitivity =============
  lambda = 0; %Review what this lambda is for
  theta_sens = zeros(2, length(chrono_data));

  for i = 1:length(chrono_data)
    [theta_sens(:, i)] = trainLinearReg(fcl_conc, chrono_data(:, i), lambda);
  end
  %  Plot fit over the data
  plotFit_reduced(fcl_conc, chrono_data, theta_sens, m, filepath(num_iterations).name);
  hold off;

  fprintf('Program paused. Press enter to continue.\n\n');
  pause;
  #}
end
