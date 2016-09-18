function [G11,G1N,GN1,GNN,G1N_R,GN1_R,SE1,SE2]=GreenF(E,L,muS,muL,ts,tc1,tc2,tso,tsoL,delta,Gamma,dis)
% Obtain the GF with recursive method for twoo-lead with same material
% tc is coupling between S and N

w_energy_resol=1.*10^-3;                     % the resolution of energy

I=eye(4);
gL=g11(E,muL,ts,tsoL,w_energy_resol);
Tc1=V_dl(tc1);
SE1=Tc1*gL*Tc1';               % self energy for the L-L interfaces of lead-1
HnS=H_sample(1,muS,ts,tso,delta,Gamma,0);
HeS1=HnS+SE1+dis(1)*diag([-1,-1,1,1]);
Tc2=V_dl(tc2);
SE2=Tc2*gL*Tc2';               % self energy for the L-L interfaces of lead-2
HeS2=HnS+SE2+dis(L)*diag([-1,-1,1,1]);

%% from left to right ( lead 1 to lead 2)
Gnn=I/(((E+1i*w_energy_resol)*I-HeS1));      %| initial values of the first recursion, i.e. the isolated GF for the first component
G1n=Gnn;                        %|
Gn1=Gnn;                        %|
V1=V_sample(ts,tso);
V2=V1';
for i=2:L-1
    %i
    gnn=I/(((E+1i*w_energy_resol)*I-HnS+dis(i)*diag([-1,-1,1,1]))); % isolated GF for 2 ~ N-1 componets
    Gnn=(I-gnn*V2*Gnn*V1)\gnn;
    Gn1=Gnn*V2*Gn1;
    G1n=G1n*V1*Gnn;
end

gnn=I/(((E+1i*w_energy_resol)*I-HeS2));      % isolated GF for the last component at lead-2
GNN=(I-gnn*V2*Gnn*V1)\gnn;
GN1=GNN*V2*Gn1;
G1N=G1n*V1*GNN;

%% from right to left
Gnn=I/(((E+1i*w_energy_resol)*I-HeS2));      %| initial values of the first recursion, i.e. the isolated GF for the first component
GNn=Gnn;                        %|
GnN=Gnn;                        %|
for i=1:L-2
    %i
    gnn=I/(((E+1i*w_energy_resol)*I-HnS+dis(L-i)*diag([-1,-1,1,1]))); % isolated GF for 2 ~ N-1 componets
    Gnn=(I-gnn*V1*Gnn*V2)\gnn;
    GNn=GNn*V2*Gnn;
    GnN=Gnn*V1*GnN;
end
gnn=I/(((E+1i*w_energy_resol)*I-HeS1));      % isolated GF for the last component
G11=(I-gnn*V1*Gnn*V2)\gnn;
GN1_R=GNn*V2*G11;
G1N_R=G11*V1*GnN;
end


