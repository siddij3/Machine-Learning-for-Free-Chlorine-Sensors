
%% Initialization
clear ; close all; clc

%% ==================== Part 0: Loading Data ====================
fprintf('Loading Data ... \n\n');

filepath = dir('Data/*.csv');
%tmp = csvread('Data\2021-07-30-Glycine - 0V B - Batch A.csv');

all_data = loadData(filepath, 'csv');

for num_iterations = 1:1

%% ==================== Part 1: Parsing Data ====================

  [fcl_conc, chrono_data,  params, t, m] = parseData(all_data{num_iterations}, num_iterations);


  [X, y] = settingChronoParams(fcl_conc, chrono_data, t, params);
  X_scaled = featureScaling(X);
  y = y(:);

  %% =========== Part 2: Train Linear Regression for all chrono_data =============
  lambda = 0; %Review what this lambda is for (For high variance. Not needed atm)



  theta_chrono = zeros(size(X_scaled)(2), length(y));
  y = takeNaturalLog(y);

  for i = 1:length(y)
    [theta_chrono(:, i)] = trainLinearReg(X_scaled, y, lambda);
  end

  tmp = reshape(y, [51, 10]);
  tmp2 = [t, tmp];

  %  Plot fit over the data
  figure;
  plot(t, y)
  plot(t, tmp, 'x', 'MarkerSize', 5, 'LineWidth', 0.75)
  xlabel('Time (t) (x)');
  ylabel('ln(Current) (ln(µA)) (y)');
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

end
