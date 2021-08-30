fprintf('Visualizing J(theta_0, theta_1) ...\n\n')

% Grid over which we will calculate J
theta0_vals = linspace(-1, 1, 100);
theta1_vals = linspace(-1, 1, 100);

% initialize J_vals to a matrix of 0's
J_vals = zeros(length(theta0_vals), length(theta1_vals));
%fcl_conc = [ones(m, 1), fcl_conc]; % Add a column of ones to x

for i = 1:length(theta0_vals)
    for j = 1:length(theta1_vals)
	  t = [theta0_vals(i); theta1_vals(j)];
    
    J_vals(i,j) = 1/(2*m)*(sum((fcl_conc*t - chrono_data).^2));
    
    end
end


% Because of the way meshgrids work in the surf command, we need to
% transpose J_vals before calling surf, or else the axes will be flipped
J_vals = J_vals';
% Surface plot
figure;
surf(theta0_vals, theta1_vals, J_vals)
xlabel('\theta_0'); ylabel('\theta_1');
pause;
hold on;


