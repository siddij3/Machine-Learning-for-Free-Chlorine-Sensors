function D = isolateDiffusion(t, I, c, A, F)

  D = ((I .* sqrt(pi*t)) ./ (c*A*F)).^2 ;

end
