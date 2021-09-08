function [X, y] = settingChronoParams(fcl_conc, chrono_data, t, params)

  fprintf('Making matrix of Parameters ...\n\n')

  y = chrono_data';

  m = size(y)(1);
  n = size(y)(2);
  % this should be made clearer aftewards.
  num_params =  0; %size(params)(2); Temporary because of constant fab params
  params = params(1:num_params);

  for i = 1:n
    % Create matrix of parameters with time, concentration, fab and testing parameters

    if (i == 1)
      X = [ones(m, 1), t, fcl_conc(i, 2)*ones(m,1), params.*ones(m, num_params)];
      continue;
    end

    tmp  = [ones(m, 1), t, fcl_conc(i, 2)*ones(m,1), params.*ones(m, num_params)];
    X = [X; tmp];



  end



end
