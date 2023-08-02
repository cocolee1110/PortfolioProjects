figure('Name','Resistance vs Valve Pressure');
% s05_2x15_2cm_Rplotfunc(kPa_s05_2x15, R_s05_2x15)
% hold on
s07_2x15_2cm_Rplotfunc(kPa_s07_2x15, R_s07_2x15)
hold on
% s05_2x2_2cm_Rplotfunc(kPa_s05_2x2, R_s05_2x2)
% hold on
s07_2x2_2cm_Rplotfunc(kPa_s07_2x2, R_s07_2x2)
hold on
% s05_3x15_2cm_Rplotfunc(kPa_s05_3x15, R_s05_3x15)
% hold on
s07_3x15_2cm_Rplotfunc(kPa_s07_3x15, R_s07_3x15)
hold on
% s05_3x2_2cm_Rplotfunc(kPa_s05_3x2, R_s05_3x2)
% hold on
s07_3x2_2cm_Rplotfunc(kPa_s07_3x2, R_s07_3x2)




xlabel( 'Valve Pressure (mmHg)', 'Interpreter', 'none' );
ylabel( 'Resistance (mmHg/(ul/min)', 'Interpreter', 'none' );
xlim([-40 100])
ylim([0 50])
title('Resistance vs Valve Pressure')
legend('s05-2x1.5','s05-2x1.5','s05-2x2','s05-2x2','s05-3x1.5','s05-3x1.5','s05-3x2','s05-3x2')
% legend('s07-2x1.5','s07-2x1.5','s07-2x2','s07-2x2','s07-3x1.5','s07-3x1.5','s07-3x2','s07-3x2')
