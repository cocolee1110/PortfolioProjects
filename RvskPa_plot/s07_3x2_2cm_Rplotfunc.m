function [fitresult, gof] = s07_3x2_2cm_Rplotfunc(kPa_s07_3x2, R_s07_3x2)
%CREATEFIT(KPA_3X2,R_3X2)
%  Create a fit.
%
%  Data for '3x2' fit:
%      X Input: kPa_3x2
%      Y Output: R_3x2
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 21-Jul-2023 23:26:16


%% Fit: '3x2'.
[xData, yData] = prepareCurveData( kPa_s07_3x2, R_s07_3x2 );

% Set up fittype and options.
ft = fittype( 'exp1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [6.39762466614926 0.122324269698104];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
% figure( 'Name', '3x2' );
h3x2 = plot( fitresult, xData, yData );
set(h3x2,'Color','#0000FF')
% legend( h3x2, 'R_3x2 vs. kPa_3x2', '3x2', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'kPa_3x2', 'Interpreter', 'none' );
ylabel( 'R_3x2', 'Interpreter', 'none' );
grid on


