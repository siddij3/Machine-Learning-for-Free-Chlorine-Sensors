function [LnA] = findLnA(t, y_log, RC_inverse)
  LnA = y_log(2:end, :) + t(2:end).*RC_inverse;
end
