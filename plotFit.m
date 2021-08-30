function plotFit(x, y, theta, m, plot_title)
  
  figure;
  plot(x(:, 2), y, 'x', 'MarkerSize', 5, 'LineWidth', 0.75);
  xlabel('Free Chlorine Concentration (ppm) (x)');
  ylabel('Current (µA) (y)');
  title(plot_title);
  hold on;
  plot(x(:, 2), x*theta, '--', 'LineWidth', 1)
  hold off;
  % ============================================================

end
