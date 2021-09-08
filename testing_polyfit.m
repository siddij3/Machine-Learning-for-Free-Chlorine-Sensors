
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
  t = all_data{num_iterations}(4:end, 1);
  %t(t==0) = [];
  data = all_data{num_iterations}(3:end, 2:end)'; %first row is the free chlorine concentration
  %data(data==0) = [];
  % if the thing has lots of zeroes, then best to remove them somehow
  fcl_conc = data(:, 1);
  chrono_data = data(:, 2:end);
  m = size(chrono_data)(1); % number of training examples
  fcl_conc = [ones(m, 1), fcl_conc];

end

for j = 1:11

  y = chrono_data(1, :)';

  p = polyfit(t, y,j); %Finds the coeffients that match the data
  p
  y1{i} = polyval(p, t); %Calculates the y values using x values and the
                         % fitted equation


  plot(t, y, 'rx', 'MarkerSize', 2)
  xlabel('time (s) (x)');
  ylabel('Current (µA) (y)');
  hold on;
  plot(t, y1{i});
  hold off;
  pause;
end
