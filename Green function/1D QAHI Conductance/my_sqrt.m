function y=my_sqrt(A)
% this function calculates the squre root of a sparse complex matrix
%
%A=round(A*10^5)/10^5;
[V,D]=eig(full(A));
d=sqrt(D);
y=V*d/V;
end
