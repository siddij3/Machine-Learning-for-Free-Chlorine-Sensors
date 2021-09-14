function [X, y] = settingChronoParams(fcl_conc, t, params)

  % Get the length and width of the chronoamperometry matrix using
  % the two values shown below.
  % With this, I can include time as a parameter and the free chlorine
  % concentration as a parameter, and use the current values associated as
  % an independant data point

  m = size(t)(1);
  n = size(fcl_conc)(2);
  % this should be made clearer aftewards.
  num_params =  0; %Temporary because of constant fab params
  params = params(1:num_params);

  for i = 1:n
    % Create matrix of parameters with time, concentration, fab + testing parameters
    if (i == 1)
      X = [ones(m, 1), t, fcl_conc(i)*ones(m,1), params.*ones(m, num_params)];
      continue;
    end

    tmp  = [ones(m, 1), t, fcl_conc(i)*ones(m,1), params.*ones(m, num_params)];
    X = [X; tmp];

  end

end
