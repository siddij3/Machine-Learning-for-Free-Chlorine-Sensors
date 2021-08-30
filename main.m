
%% Initialization
clear ; close all; clc

%% ==================== Part 1: Parsing Data ====================
fprintf('Loading Data ... \n');

% csvdata = zeros(x,y,z) - 3D array
csvdata = csvread('Data\2021-07-30-Glycine - 0V B - Batch A.csv');


fprintf('Manipulating Data ...\n')
t = csvdata(2:end, 1);
t(t==0) = [];
data = csvdata(:, 2:end)'; %first row is the free chlorine concentration
data(data==0) = []; 
  
fcl_conc = data(:, 1);
chrono_data = data(:, 2:end);
m = size(chrono_data)(1); % number of training examples

fcl_conc = [ones(m, 1), fcl_conc];

fprintf('Program paused. Press enter to continue.\n\n');
pause;

%y_tmp = chrono_data(:, 41);

plotData(fcl_conc, chrono_data);


%% ==== Part 2: Regularized Linear Regression Cost and Gradient ===================

theta = [-10; 10]; 
[J, grad] = linearRegCostFunction(fcl_conc, chrono_data, theta, 1);

fprintf(['Cost at theta = [-10; 10]: %f \n'], J);
fprintf(['Gradient at theta = [-10; 10]:  [%f; %f]\n'], grad(1), grad(2));
fprintf('Program paused. Press enter to continue.\n\n');
pause;


%% =========== Part 3: Train Linear Regression =============
 
lambda = 0;
theta = [theta, zeros(2, length(chrono_data-1))];

for i = 1:length(chrono_data)
  [theta(:, i)] = trainLinearReg(fcl_conc, chrono_data(:, i), lambda);
end
%  Plot fit over the data
plotFit(fcl_conc, chrono_data, theta, m);
hold off;

fprintf(['Gradient at theta = [%f; %f]:  [%f; %f]\n'], theta(1), theta(2), grad(1), grad(2));
fprintf('Program paused. Press enter to continue.\n\n');
pause;

















 
 

