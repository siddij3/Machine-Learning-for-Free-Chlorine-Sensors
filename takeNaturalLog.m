function [y] = takeNaturalLog(y)

  y = log(log10(-y*10));


end
