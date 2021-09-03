
%% Initialization
clear ; close all; clc

%% ==================== Part 0: Loading Data ====================
fprintf('Loading Data ... \n\n');

filepath = dir('Data/*.csv');
%tmp = csvread('Data\2021-07-30-Glycine - 0V B - Batch A.csv');

all_data = loadData(filepath, 'csv');

for num_iterations = 1:1

%% ==================== Part 1: Parsing Data ====================

  [fcl_conc, chrono_data, t, m] = parseData(all_data, num_iterations);

  %% =========== Part 2: Train Linear Regression =============


  lambda = 0; %Review what this lambda is for
  theta = [zeros(2, length(chrono_data))];

  for i = 1:length(chrono_data)
    [theta(:, i)] = trainLinearReg(fcl_conc, chrono_data(:, i), lambda);
  end

  %  Plot fit over the data
  plotFit_reduced(fcl_conc, chrono_data, theta, m, filepath(num_iterations).name);
  hold off;

  fprintf('Program paused. Press enter to continue.\n\n');
  pause;

end
