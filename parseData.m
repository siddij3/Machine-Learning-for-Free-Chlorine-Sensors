function [fcl_conc, chrono_data, params, t, m] = parseData(all_data)

  %First row lists all the parameters for the test

  %  1          |          2       |       3              |       4
  % Operating V |	GO Conc. ( mol/L)|	Amine Conc. (mol/L) |	NaOH Conc. (mol/L)

  %        5       |        6        |         7          |         8         |
  % Rxn. Time (hr) |	Rxn. Temp (°C) | Mixing speed (rpm) |	Drying time (min) |

  %        9         |        10         |         11          |
  % Drying Temp (°C) |	Centrifuge (rpm) |	Centrifuge (min)

  params = all_data(1, 1:11);

  % Remaining data is the time, free chlorine concetration and current values
  all_data = all_data(3:end, :);

  %time
  t = all_data(2:end, 1);
  chrono_data = all_data(:, 2:end);

  % if the thing has lots of zeroes, then best to remove them somehow
  chrono_data( :, all(~chrono_data,1) ) = [];

  %first row is the free chlorine concentration.
  %rest of the rows are free chlorine data
  fcl_conc = chrono_data(1, :);
  chrono_data = chrono_data(2:end, :)*1E-6;

  m = size(chrono_data)(2); % number of training examples
end
