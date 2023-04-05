%transformation matrix along frames
function[Tmat]=transmat(X,Y,Z,org)
    for n = 1:size(X,2)
        Tx = [X(:,n),Y(:,n),Z(:,n),org(:,n)];
        Tx(4,4)= 1;
        Tmat(:,:,n) = Tx;
    end
end