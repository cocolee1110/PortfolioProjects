clear
D = readtable('Marker_data_2022.xlsx','PreserveVariableNames',true);
%KM
L_KM = D{22:87,["L.Knee.MedialX","L.Knee.MedialY","L.Knee.MedialZ"]}
L_KM = L_KM'

%T_matrix for all frames 22:87
for x=1:size(D,1)
    [T_x]=lab_transmat_Lt(D,x)
    T(:,:,x)=T_x
end

L_KM_1 = L_KM
L_KM_1(4,:) = 1
L_KM_fx = inv(T(:,:,22)) * L_KM_1(:,1)


for x=42:67
    L_KM_miss = T(:,:,x) * L_KM_fx
    L_KM_1(:,x-21) = L_KM_miss'
end

F3=L_KM_1'

%%%%%Functions%%%%%
%unit vector
function[UV]=unitvector(A)
    for n=1:size(A,2)
        s = A(:,[n]);
        s_uv = s/norm(s);
        UV(1:3,n)=s_uv;
    end
end

%Cross product
function[CP]=crossprod(A,B)
    col=size(A,2)
    for x=1:col
        m = A(:,[x])
        n = B(:,[x])
        CP = cross(A,B)
    end
end

%transformation matrix along frames
function[Tmat]=transmat(X,Y,Z,org)
    for n = 1:size(X,2)
        Tx = [X(:,n),Y(:,n),Z(:,n),org(:,n)];
        Tx(4,4)= 1;
        Tmat(:,:,n) = Tx;
    end
end
