function [X, y, t, m] = parseData(all_data, num_iterations)

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

  X = fcl_conc;
  y = chrono_data;



end
