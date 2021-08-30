
%% Initialization
clear ; close all; clc

%% ==================== Part 1: Parsing Data ====================
fprintf('Loading Data ... \n');

fprintf('Manipulating Data ...\n')
csvdata = csvread('Data\2021-07-30-Glycine - 0V - Batch A.csv');
t = csvdata(2:end, 1);
data = csvdata(:, 2:end)'; %first row is the free chlorine concentration
 
  
free_chlorine_conc = data(:, 1);
chrono_data = data(:, 2:end);
m = size(chrono_data)(1); % number of training examples

free_chlorine_conc = [ones(m, 1), free_chlorine_conc];

fprintf('Program paused. Press enter to continue.\n\n');
pause;

y_tmp = chrono_data(:, 41);

plotData(free_chlorine_conc(:, 2), y_tmp);


%% ==== Part 2: Regularized Linear Regression Cost and Gradient ===================

theta = [-10; 10]; 
[J, grad] = linearRegCostFunction(free_chlorine_conc, y_tmp, theta, 1);

fprintf(['Cost at theta = [-10; 10]: %f \n'], J);
fprintf(['Gradient at theta = [-10; 10]:  [%f; %f]\n'], grad(1), grad(2));
fprintf('Program paused. Press enter to continue.\n\n');
pause;


%% =========== Part 3: Train Linear Regression =============
 
lambda = 0;
[theta] = trainLinearReg(free_chlorine_conc, y_tmp, lambda);

%  Plot fit over the data
plotFit(free_chlorine_conc, y_tmp, theta, m);
hold off;

fprintf(['Gradient at theta = [%f; %f]:  [%f; %f]\n'], theta(1), theta(2), grad(1), grad(2));
fprintf('Program paused. Press enter to continue.\n\n');
pause;

%% =========== Part 5: Visualizing J(theta_0, theta_1) =============

Visualizing_J;















 
 

