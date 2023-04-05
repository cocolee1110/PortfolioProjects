clear
D = readtable('Marker_data_2022.xlsx','PreserveVariableNames',true);
L_KM = D{22:87,["L.Knee.MedialX","L.Knee.MedialY","L.Knee.MedialZ"]};
%timeframe:78-(98-123)-143


%%linear interpolation
[F1,TF1]=fillmissing(L_KM,'linear');

%%Cubic spline filling
[F2,TF2]=fillmissing(L_KM,'spline');

%%Redundant marker filling
L_KM = L_KM';

%T_matrix for all frames 22:87 (78-143)
for x=1:size(D,1)
    [T_x]=lab_transmat_Lt(D,x);
    T(:,:,x)=T_x;
end

L_KM_1 = L_KM;
L_KM_1(4,:) = 1;
%L_KM_frame78 - constant fixed frame
L_KM_fx = inv(T(:,:,22)) * L_KM_1(:,1);


for x=42:67
    L_KM_miss = T(:,:,x) * L_KM_fx;
    L_KM_1(:,x-21) = L_KM_miss';
end

F3=L_KM_1';

%Fill L.Knee.MedialX frame 98-123
m=21;
for x=42:67
    D(x,27)={F3(m,1)};
    m=m+1;
end

%Fill L.Knee.MedialY frame 98-123
m=21;
for x=42:67
    D(x,28)={F3(m,2)};
    m=m+1;
end

%Fill L.Knee.MedialZ frame 98-123
m=21;
for x=42:67
    D(x,29)={F3(m,3)};
    m=m+1;
end


%%trajectory plot
figure()
plot3(F1(:,1),F1(:,2),F1(:,3)) 
hold on
plot3(F2(:,1),F2(:,2),F2(:,3))
hold on
plot3(F3(:,1),F3(:,2),F3(:,3))
xlabel('x') 
ylabel('y')
zlabel('z') 
title('Trajectories of L.Knee.Medial from frame 78-143 ')
legend('linear interpolation','Cubic spline filling','Redundant marker filling')