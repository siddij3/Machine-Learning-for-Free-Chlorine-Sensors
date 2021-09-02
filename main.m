
%% Initialization
clear ; close all; clc

%% ==================== Part 0: Loading Data ====================
fprintf('Loading Data ... \n\n');

csv_files = dir('Data/*.csv');
num_files = length(csv_files);

%tmp = csvread('Data\2021-07-30-Glycine - 0V B - Batch A.csv');

 
% csvdata = zeros(x,y,z) - 3D array
x_val = 0;
y_val = 0;

for i = 1:num_files
  all_data{i} = csvread([csv_files(i).folder, '\', csv_files(i).name]);
end

%% ==================== Part 1: Parsing Data ====================

for num_iterations = 1:1
  

  fprintf('Manipulating Data ...\n\n')
  t = all_data{num_iterations}(2:end, 1);
  %t(t==0) = [];
  data = all_data{num_iterations}(:, 2:end)'; %first row is the free chlorine concentration
  %data(data==0) = []; 
  % if the thing has lots of zeroes, then best to remove them somehow
  fcl_conc = data(:, 1);
  chrono_data = data(:, 2:end);
  m = size(chrono_data)(1); % number of training examples

  fcl_conc = [ones(m, 1), fcl_conc];

  %% ==== Part 2: Regularized Linear Regression Cost and Gradient ===================




  %% =========== Part 3: Train Linear Regression =============

  lambda = 0;
  theta = [zeros(2, length(chrono_data))];

  for i = 1:length(chrono_data)
    [theta(:, i)] = trainLinearReg(fcl_conc, chrono_data(:, i), lambda);
  end
  %  Plot fit over the data
  plotFit_reduced(fcl_conc, chrono_data, theta, m, csv_files(num_iterations).name);
  hold off;

  fprintf(['Gradient at theta = [%f; %f]:  [%f; %f]\n'], theta(1), theta(2), grad(1), grad(2));
  fprintf('Program paused. Press enter to continue.\n\n');
  pause;
  
  
end







 
 

