function y=g11(E,mu,ts,tso,w)
%g11 The submatrix of the Green function of the LEAD
% Obtained by N times of recursion
D=(E+1i*w)*eye(4)-H_lead(1,mu,ts,tso);
A=V_lead(ts,tso);
B=A';
d=D;
for i=1:1000 %maximum number of recursive times
	d1=d-A/D*B;
	D1=D-A/D*B-B/D*A;
	A1=A/D*A;
	B1=B/D*B;
    if max(max(abs(d1-d)))<1e-99
        %i
        break
    end
	d=d1;
	D=D1;
	A=A1;
	B=B1;
end
y=eye(4)/d1;