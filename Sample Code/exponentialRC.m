% y = A*exp(-t/RC)
y_log = log(-chrono_data)(:, 2:end);
plotDataOs(t, y_log, 'Time (t) (x)','ln(Current) (ln(µA)) (y)', ...
'Natural log of chronoamperometry data', 'northwest');
% This is the 1/RC value; negative is to remove the negative slope
RC_inverse = -findDerivative(t, y_log);
RC_inverse2 = -findDerivative(t(2:end), RC_inverse);

smoothingType = 2;
smoothWidths = 3;
%RC_inverse = cleanNoise(RC_inverse, size(RC_inverse)(2) , smoothWidths, smoothingType);
%RC_inverse2 = cleanNoise(RC_inverse2, size(RC_inverse)(2) , smoothWidths, smoothingType);

RC = 1./RC_inverse;
LnA = findLnA(t, y_log, 1./RC);
fcl_conc = fcl_conc(:, 2:end);

%plotData(t(3:end), RC_inverse2, 'Time (t) (x)','RC values (1 / ΩF-1) (y)', ...
%'Changing double derivative 1/RC values with changing time', 'north');

%plotData(fcl_conc, RC_inverse, 'Free Chlorine concetration (ppm) (x)', ...
%'RC values (1 / ΩF) (y)', 'Changing 1/RC values with changing free chlorine', 'northeast');

%plotData(t(2:end), RC, 'Time (t) (x)','RC values (ΩF) (y)', ...
%'Changing RC values with changing time', 'east');

%plot the changing RC with the free chlorine concetration
%plotData(fcl_conc, RC(1:end-10, :), 'Free Chlorine concetration (ppm) (x)',...
%'RC values (ΩF) (y)', 'Changing RC with change in free chlorine', 'southeast');


%plotData(fcl_conc, LnA, 'Free Chlorine concetration (ppm) (x)',...
%'ln(A) values (ln(I)) (y)', 'Changing A params with change in free chlorine', 'south');

%plotData(t(2:end), LnA, 'Time (s) (x)',...
%'ln(A) values (ln(I)) (y)', 'Changing A params with change in time', 'southwest');
