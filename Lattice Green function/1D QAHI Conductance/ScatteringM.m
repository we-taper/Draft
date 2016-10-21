%function y=ScatteringM(1,Ly,W,E,Vy,u,t,a,tc,Ds,Dp,periodx)
function [y11ee,y12ee,y11eh,y12eh,y21ee,y22ee,y21eh,y22eh,y11he,y12he,...
  y11hh,y12hh,y21he,y22he,y21hh,y22hh]=ScatteringM_x(E,L,muS,muL,ts,tc1,tc2,tso,tsoL,delta,Gammaz,dis)
%SCateringMatrix calculates the scatering matrix from lattice Green function
%based on the formula: S=-1+i*sqrt(Gamma)*GF*sqrt(Gamma')
% TODO I think I should find reference for this file.

    [G11,G1N,GN1,GNN,G1N_R,GN1_R,SE1,SE2]=GreenF(E,L,muS,muL,ts,tc1,tc2,tso,tsoL,delta,Gammaz,dis);
    Gamma1 = (1i*(SE1-SE1'));
    A1     = my_sqrt(Gamma1);
    Gamma2 = (1i*(SE2-SE2'));
    A2     = my_sqrt(Gamma2);
    y11    = -eye(4)+1i*A1*G11*A1;
    y12    = 1i*A1*G1N*A2;
    y21    = 1i*A2*GN1*A1;
    y22    = -eye(4)+1i*A2*GNN*A2;
    %y=[y11,y12;y21,y22];   %the basis here is [e1u,e1d,h1u,h1d,e2u,e2d,h2u,h2d]
    % e/h for electron/hole, 1/2 for lead 1/2, u/d for spin up/down
    y11ee=y11(1:2*1     , 1:2*1);
    y12ee=y12(1:2*1     , 1:2*1);
    y11eh=y11(1:2*1     , 2*1+1:4*1);
    y12eh=y12(1:2*1     , 2*1+1:4*1);

    y21ee=y21(1:2*1     , 1:2*1);
    y22ee=y22(1:2*1     , 1:2*1);
    y21eh=y21(1:2*1     , 2*1+1:4*1);
    y22eh=y22(1:2*1     , 2*1+1:4*1);

    y11he=y11(2*1+1:4*1 , 1:2*1);
    y12he=y12(2*1+1:4*1 , 1:2*1);
    y11hh=y11(2*1+1:4*1 , 2*1+1:4*1);
    y12hh=y12(2*1+1:4*1 , 2*1+1:4*1);

    y21he=y21(2*1+1:4*1 , 1:2*1);
    y22he=y22(2*1+1:4*1 , 1:2*1);
    y21hh=y21(2*1+1:4*1 , 2*1+1:4*1);
    y22hh=y22(2*1+1:4*1 , 2*1+1:4*1);

    sq2   = 1/sqrt(2.0);
    R     = [sq2,-sq2;sq2,sq2];
    Rd    = transpose(R);
    y11ee = Rd*y11ee*R;
    y12ee = Rd*y12ee*R;

    %{
        % change the basis to [e1u,e1d,e2u,e2d,h1u,h1d,h2u,h2d] to obtain the whole S-matrix,

        y=[ y11ee , y12ee , y11eh , y12eh;
            y21ee , y22ee , y21eh , y22eh;
            y11he , y12he , y11hh , y12hh;
            y21he , y22he , y21hh , y22hh];
    %}
end
