function plotlogPlot(x, y, theta, x_label, y_label, title_label, position, isNewFig)

loglog(x, y);
xlabel(x_label);
ylabel(y_label);
title(title_label);
%xlim([1E-6 2E-4]);
%ylim([1E-8 2E-5]);
xlim([1E-5 2E-4]);
ylim([3E-8 2E-6]);
movegui(position);
hold on;
loglog(x(:, 2), x*theta, '--', 'LineWidth', 1)
hold off;
% ============================================================

end
