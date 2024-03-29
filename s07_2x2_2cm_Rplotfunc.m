function [fitresult, gof] = s07_2x2_2cm_Rplotfunc(kPa_s07_2x2, R_s07_2x2)
%CREATEFIT(KPA_S07_2X2,R_S07_2X2)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input: kPa_s07_2x2
%      Y Output: R_s07_2x2
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 24-Jul-2023 23:03:38


%% Fit: '2x2'.
[xData, yData] = prepareCurveData( kPa_s07_2x2, R_s07_2x2 );

% Set up fittype and options.
ft = fittype( 'exp1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0.0322139420823998 0.118711413479539];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% % Plot fit with data.
% figure( 'Name', 'untitled fit 1' );
h2x2 = plot( fitresult, xData, yData );
set(h2x2,'Color','#008000')
% legend( h, 'R_s07_2x2 vs. kPa_s07_2x2', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
% % Label axes
xlabel( 'kPa_s07_2x2', 'Interpreter', 'none' );
ylabel( 'R_s07_2x2', 'Interpreter', 'none' );
grid on


