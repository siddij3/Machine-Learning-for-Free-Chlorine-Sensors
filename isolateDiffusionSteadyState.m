function Dss = isolateDiffusionSteadyState(t, I, n, F, c, r)

  Dss = I./ (4*n*F*c*r);

end
