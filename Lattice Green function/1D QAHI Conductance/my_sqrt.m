function y=my_sqrt(A)
% this function calculates the squre root of a sparse complex matrix
%
%A=round(A*10^5)/10^5;
[V,D]=eig(full(A)); % full: sparse matrix -> full matrix
d=sqrt(D);
% What is the point of doing "/V" here? TODO
y=V*d/V;
end
