function plotFit(x, y, theta, m)

  plot(x(:, 2), y, 'o', 'MarkerSize', 5, 'LineWidth', 0.75);
  xlabel('Free Chlorine Concentration (ppm) (x)');
  ylabel('Current (µA) (y)');
  hold on;
  plot(x(:, 2), x*theta, '--', 'LineWidth', 2)
  hold off;
  % ============================================================

end
