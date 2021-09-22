function plotFit_reduced(x, y, theta,  x_label, y_label, title_label, plot_title, position)

  figure;
  plot(x(:, 2), y, 'x', 'MarkerSize', 5, 'LineWidth', 0.75);
  xlabel(x_label);
  ylabel(y_label);
  title(plot_title);
  movegui(position);
  hold on;
  plot(x(:, 2), x*theta, '--', 'LineWidth', 1)
  hold off;
  % ============================================================

end
