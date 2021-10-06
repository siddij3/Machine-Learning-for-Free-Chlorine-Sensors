function f_tau = find_f_tau(tau)

  f_tau = zeros(size(tau));
  f_tau(1, :) = 0.7854;
  f_tau(2:end, :) = 0.7854 + 0.8863./sqrt(tau(2:end, :)) + 0.2146*exp(-0.7823./sqrt(tau(2:end, :)));
end
