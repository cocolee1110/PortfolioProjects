%unit vector
function[UV]=unitvector(A)
    for n=1:size(A,2)
        s = A(:,[n]);
        s_uv = s/norm(s);
        UV(1:3,n)=s_uv;
    end
end