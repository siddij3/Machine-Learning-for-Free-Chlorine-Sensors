
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
  % y = A*exp(-t/RC)
  y_log = log(-chrono_data);
  plotDataOs(t, y_log, 'Time (t) (x)','ln(Current) (ln(µA)) (y)', ...
  'Natural log of chronoamperometry data', 'northwest');

  % This is the 1/RC value; negative is to remove the negative slope
  RC_inverse = -findDerivative(t, y_log);
  RC = 1./RC_inverse;

  plotData(t(2:end), RC_inverse, 'Time (t) (x)','RC values (1 / ΩF) (y)', ...
  'Changing 1/RC values with changing time', 'north');

  plotData(t(2:end), RC, 'Time (t) (x)','RC values (ΩF) (y)', ...
  'Changing RC values with changing time', 'northeast');

  %plot the changing RC with the free chlorine concetration
  plotData(fcl_conc, RC, 'Free Chlorine concetration (ppm) (x)',...
  '1/RC values (ΩF) (y)', 'Changing RC with change in free chlorine', 'southeast');

  LnA = findLnA(t, y_log, 1./RC);

  plotData(fcl_conc, LnA, 'Free Chlorine concetration (ppm) (x)',...
  'ln(A) values (ln(I)) (y)', 'Changing A params with change in free chlorine', 'south');

  plotData(t(2:end), LnA, 'Time (s) (x)',...
  'ln(A) values (ln(I)) (y)', 'Changing A params with change in time', 'southwest');


  pause;

  %%=============== Part 3: Linear Regression Analysis on logorithmic data
#{

  lambda = 0; %Review what this lambda is for (For high variance. Not needed atm)
  theta_chrono = zeros(size(X_scaled)(2), length(y));

  for i = 1:length(y)
    [theta_chrono(:, i)] = trainLinearReg(X_scaled, y_log, lambda);
  end
  %plot(t(30:end), reshape(log(log(-y*10)), [51, 10])(30:end, :), 'x', 'MarkerSize', 3, 'LineWidth', 0.75)

  pause;
  plot(t, chrono_data, 'o', 'MarkerSize', 3, 'LineWidth', 0.75)
  xlabel('Time (t) (x)');
  ylabel('Current ()µA) (y)');

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
