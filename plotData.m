function plotData(x, y, x_label, y_label, title_label, position)
 

figure; % open a new figure window


plot(x, y);
xlabel(x_label);
ylabel(y_label);
title(title_label);
movegui(position);

% ============================================================

end
