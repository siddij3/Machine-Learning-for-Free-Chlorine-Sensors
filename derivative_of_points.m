function [dydx] = derivative_of_points(x, y)
  %just finds the derivative of input xs and ys
  
  dydx = diff(y(:))./diff(x(:));
  
end