function y = cleanNoise(y, numSize ,smoothwidths,type)

  for i = 1:numSize
    [y(:, i), tmp] = SegmentedSmooth(y(:, i), smoothwidths, type, 1);
  end

end
