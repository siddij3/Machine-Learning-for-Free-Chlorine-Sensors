function plotFit_reduced(x, y, theta, m, plot_title)

  y = y(:, 40:end);
  theta = theta(:, 40:end);


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
