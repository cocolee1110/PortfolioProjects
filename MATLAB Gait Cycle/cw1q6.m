
%%Right thigh 
%Patella
R_Pat = D{:,["R.PatellaX","R.PatellaY","R.PatellaZ"]};
R_Pat = R_Pat';
%TS
R_TS = D{:,["R.Thigh.SuperiorX","R.Thigh.SuperiorY","R.Thigh.SuperiorZ"]};
R_TS = R_TS';
%TI
R_TI = D{:,["R.Thigh.InferiorX","R.Thigh.InferiorY","R.Thigh.InferiorZ"]};
R_TI = R_TI';
%KL
R_KL = D{:,["R.Knee.LateralX","R.Knee.LateralY","R.Knee.LateralZ"]};
R_KL = R_KL';
%KM
R_KM = D{:,["R.Knee.MedialX","R.Knee.MedialY","R.Knee.MedialZ"]};
R_KM = R_KM';
%TITS
R_TITS = R_TS - R_TI;
[UV_RTITS]=unitvector(R_TITS);
%KLKM
R_KLKM = R_KM - R_KL;
[UV_RKLKM] = unitvector(R_KLKM);
%x
UV_x_Rt = UV_RKLKM;
%z
[z_Rt] = crossprod(UV_RKLKM,UV_RTITS);
[UV_z_Rt] = unitvector(z_Rt);
%y
[UV_y_Rt] = crossprod(UV_z_Rt,UV_x_Rt);
%Transformation matrix (Right thigh wrt Lab)
[Lab_T_Rt] = transmat(UV_x_Rt,UV_y_Rt,UV_z_Rt,R_Pat);


%%Left thigh
L_Pat = D{:,["L.PatellaX","L.PatellaY","L.PatellaZ"]};
L_Pat = L_Pat';
%TS
L_TS = D{:,["L.Thigh.SuperiorX","L.Thigh.SuperiorY","L.Thigh.SuperiorZ"]};
L_TS = L_TS';
%TI
L_TI = D{:,["L.Thigh.InferiorX","L.Thigh.InferiorY","L.Thigh.InferiorZ"]};
L_TI = L_TI';
%KL
L_KL = D{:,["L.Knee.LateralX","L.Knee.LateralY","L.Knee.LateralZ"]};
L_KL = L_KL';
%KM
L_KM = D{:,["L.Knee.MedialX","L.Knee.MedialY","L.Knee.MedialZ"]};
L_KM = L_KM';
%TITS
L_TITS = L_TS - L_TI;
[UV_LTITS]=unitvector(L_TITS);
%KMKL 
L_KMKL = L_KL - L_KM;
[UV_LKMKL] = unitvector(L_KMKL);
%x %!!!!!!!!!!!!!! change directions for left (KMKL!!!!)
UV_x_Lt = UV_LKMKL;
%z
[z_Lt] = crossprod(UV_LKMKL,UV_LTITS);
[UV_z_Lt] = unitvector(z_Lt);
%y
[UV_y_Lt] = crossprod(UV_z_Lt,UV_x_Lt);
%Transformation matrix (Left thigh wrt Lab)
[Lab_T_Lt] = transmat(UV_x_Lt,UV_y_Lt,UV_z_Lt,L_Pat);


%%Right shank
%SS
R_SS = D{:,["R.Shank.SuperiorX","R.Shank.SuperiorY","R.Shank.SuperiorZ"]};
R_SS = R_SS';
%SI
R_SI = D{:,["R.Shank.InferiorX","R.Shank.InferiorY","R.Shank.InferiorZ"]};
R_SI = R_SI';
%AL
R_AL = D{:,["R.Ankle.LateralX","R.Ankle.LateralY","R.Ankle.LateralZ"]};
R_AL = R_AL';
%AM
R_AM = D{:,["RankleMedialX","RankleMedialY","RankleMedialZ"]};
R_AM = R_AM';
%SISS
R_SISS = R_SS - R_SI;
[UV_RSISS]=unitvector(R_SISS);
%ALAM
R_ALAM = R_AM - R_AL;
[UV_RALAM]=unitvector(R_ALAM);
%x
UV_x_Rs = UV_RALAM;
%z
[z_Rs] = crossprod(UV_RALAM,UV_RSISS);
[UV_z_Rs] = unitvector(z_Rs);
%y
[UV_y_Rs] = crossprod(UV_z_Rs,UV_x_Rs);
%Transformation matrix (Right shank wrt Lab)
[Lab_T_Rs] = transmat(UV_x_Rs,UV_y_Rs,UV_z_Rs,R_SI);

%%Left shank
%SS
L_SS = D{:,["L.Shank.SuperiorX","L.Shank.SuperiorY","L.Shank.SuperiorZ"]};
L_SS = L_SS';
%SI
L_SI = D{:,["L.Shank.InferiorX","L.Shank.InferiorY","L.Shank.InferiorZ"]};
L_SI = L_SI';
%AL
L_AL = D{:,["L.Ankle.LateralX","L.Ankle.LateralY","L.Ankle.LateralZ"]};
L_AL = L_AL';
%AM
L_AM = D{:,["L.Ankle.MedialX","L.Ankle.MedialY","L.Ankle.MedialZ"]};
L_AM = L_AM';
%SISS
L_SISS = L_SS - L_SI;
[UV_LSISS]=unitvector(L_SISS);
%AMAL
L_AMAL = L_AL - L_AM;
[UV_LAMAL]=unitvector(L_AMAL);
%x %!!!!!!!!!!!!!! change directions for left (AMAL!!!!)
UV_x_Ls = UV_LAMAL;
%z
[z_Ls] = crossprod(UV_LAMAL,UV_LSISS);
[UV_z_Ls] = unitvector(z_Ls);
%y
[UV_y_Ls] = crossprod(UV_z_Ls,UV_x_Ls);
%Transformation matrix (Right shank wrt Lab)
[Lab_T_Ls] = transmat(UV_x_Ls,UV_y_Ls,UV_z_Ls,L_SI);

%%Transformation matrix (Right shank wrt Right thigh)
Rt_T_Lab = pageinv(Lab_T_Rt);
Rt_T_Rs = pagemtimes(Rt_T_Lab,Lab_T_Rs);

%%Transformation matrix (Left shank wrt Left thigh)
Lt_T_Lab = pageinv(Lab_T_Lt);
Lt_T_Ls = pagemtimes(Lt_T_Lab,Lab_T_Ls);

%%Joint Angles Right
for i=1:147
    Rx=atan2(Rt_T_Rs(3,2,i),Rt_T_Rs(2,2,i));
    Ry=atan2(-Rt_T_Rs(1,2,i),sqrt((Rt_T_Rs(2,2,i)^2+Rt_T_Rs(3,2,i)^2)));
    Rz=atan2(Rt_T_Rs(1,3,i),Rt_T_Rs(1,1,i));
    R_ja(:,i)=[Rx,Ry,Rz];
end
R_ja=rad2deg(R_ja);

%%Joint Angles Left
for i=1:147
    Lx=atan2(Lt_T_Ls(3,2,i),Lt_T_Ls(2,2,i));
    Ly=atan2(-Lt_T_Ls(1,2,i),sqrt((Lt_T_Ls(2,2,i)^2+Lt_T_Ls(3,2,i)^2)));
    Lz=atan2(Lt_T_Ls(1,3,i),Lt_T_Ls(1,1,i));
    L_ja(:,i)=[Lx,Ly,Lz];
end
L_ja=rad2deg(L_ja);

%%plot
time = D{:,['Frame']};

figure(2)
plot(time,R_ja(1,:)) %flexion (+ve)
hold on
plot(time, -1 * R_ja(2,:)) %external rotation (-ve) -> positive
hold on
plot(time, -1 * R_ja(3,:)) %abduction (-ve) -> postiive
xlabel('Frame') 
ylabel('Joint angles (degrees)')
legend('Right x','Right y','Right z')
title('Joint angles of Right knees')

figure(3)
plot(time,L_ja(1,:)) %flexion (+ve)
hold on
plot(time, L_ja(2,:)) %external rotation (+ve)
hold on
plot(time,L_ja(3,:)) %abduction (+ve)
xlabel('Frame') 
ylabel('Joint angles (degrees)')
legend('Left x','Left y','Left z')
title('Joint angles of Left knees')