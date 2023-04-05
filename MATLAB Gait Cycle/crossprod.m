%Cross product
function[CP]=crossprod(A,B)
    col=size(A,2)
    for x=1:col
        m = A(:,[x])
        n = B(:,[x])
        CP = cross(A,B)
    end
end