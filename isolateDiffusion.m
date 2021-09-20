function D = isolateDiffusion(t, I, c, A, F)

  
  D = (I .* sqrt(pi*t)) ./ (A*F).^2 ;



end
