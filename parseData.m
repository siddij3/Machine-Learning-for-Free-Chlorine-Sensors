function [fcl_conc, chrono_data, params, t, m] = parseData(all_data)

  %First row lists all the parameters for the test
  params = all_data(1, 1:end);

  % Remaining data is the time, free chlorine concetration and current values
  all_data = all_data(3:end, :);

  %time
  t = all_data(2:end, 1);
  chrono_data = all_data(:, 2:end);

  % if the thing has lots of zeroes, then best to remove them somehow

  %first row is the free chlorine concentration.
  %rest of the rows are free chlorine data
  fcl_conc = chrono_data(1, :);
  chrono_data = chrono_data(2:end, :);

  m = size(chrono_data)(2); % number of training examples
end
