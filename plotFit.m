function plotFit(x, y, theta, m)

  plot(x(:, 2), y, 'rx', 'MarkerSize', 10, 'LineWidth', 1.5);
  xlabel('Free Chlorine Concentration (ppm) (x)');
  ylabel('Current (µA) (y)');
  hold on;
  plot(x(:, 2), x*theta, '--', 'LineWidth', 2)
  hold off;
  % ============================================================

end
