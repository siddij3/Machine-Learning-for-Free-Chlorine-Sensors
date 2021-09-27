function D = isolateDiffusion(t, I, c, A, F)

  D = (I .* sqrt(pi*t)) ./ (A*F) ;
  D = (D./c).^2;

end
