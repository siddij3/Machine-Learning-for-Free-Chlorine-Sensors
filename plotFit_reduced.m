function plotFit_reduced(x, y, theta,  x_label, y_label, title_label, position)


  plot(x(:, 2), y, 'o', 'LineWidth', 0.75);
  xlabel(x_label);
  ylabel(y_label);
  title(title_label);
  movegui(position);
  hold on;
  plot(x(:, 2), x*theta, '--', 'LineWidth', 1)
  %hold off;
  % ============================================================

end
