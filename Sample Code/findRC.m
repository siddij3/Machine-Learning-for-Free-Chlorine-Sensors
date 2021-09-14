function RC = findRC(x, y)
  dydx = findDerivative(x, y);

  RC = y(2:end, :) ./ dydx;

end
