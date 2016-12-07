% Purpose: Do a numerical calculation to test the result
%          about p_k and u_k when gamme=0, i.e. no dissipation.
% version: 20161209-1
% Description:
% The result is obtained using exact solution using Rabi Cycle (Wikipedia)
% formulae. The answer may be numerically incorrect because I need to
% calculate a theta, which is Arcsin(of something) or Arccos(of something 
% else). Unsurprisingly, the two result does not agree sometimes.
clear all;
v=rand()*10;
v1=rand()*10;
Er=rand()*10;
El=rand()*10;

% First test pk in an arbitrary time
t=rand()*10;
index=0;
k_range=-pi:0.05:pi;
for k= k_range
    index = index+1;
    W=conj(v+v1*exp(1i*k));
    E0= (Er+El)/2;
    Delta=(Er-El)/2;

    sin_t=abs(W)/sqrt(Delta^2+abs(W)^2);
    cos_t=Delta/sqrt(Delta^2+abs(W)^2);
    theta=asin(sin_t);
    Indication_of_goodness=asin(sin_t)-acos(cos_t);
    if Indication_of_goodness > 2*pi*1/360
    	sprintf('Bad result when getting the angle. The angle differ by ... %0.5e',Indication_of_goodness);
        pause;
    end;
    eiphi=conj(W/abs(W));
    emiphi=W/abs(W);
    Ep=E0+sqrt(Delta^2+abs(W)^2);
    Em=E0-sqrt(Delta^2+abs(W)^2);

    ket_Ep=zeros(2,1);
    ket_Ep(1)=eiphi*cos(theta/2);
    ket_Ep(1)=sin(theta/2);
    ket_Em=zeros(2,1);
    ket_Em(1)=-eiphi*sin(theta/2);
    ket_Ep(1)=cos(theta/2);

    psi=zeros(2,1);
    psi(1)=cos(theta/2)*exp(-1i*Ep*t)*ket_Ep(1)- ...
            sin(theta/2)*emiphi*exp(-1i*Em*t)*ket_Em(1);
    psi(2)=cos(theta/2)*exp(-1i*Ep*t)*ket_Ep(2)- ...
            sin(theta/2)*emiphi*exp(-1i*Em*t)*ket_Em(2);
    pk(index)=psi'*psi;
end;
plot(k_range,pk);
title('Testing p_k');

% Then test uk in both two dimension (t,k)
t_range=0:0.1:10;
uk = zeros(length(t_range),length(k_range));
index_t=0;
for t= t_range
    index_t = index_t+1;
    index_k=0;
    for k= k_range
        index_k = index_k+1;
        
        W=conj(v+v1*exp(1i*k));
        E0= (Er+El)/2;
        Delta=(Er-El)/2;

        sin_t=abs(W)/sqrt(Delta^2+abs(W)^2);
        cos_t=Delta/sqrt(Delta^2+abs(W)^2);
        theta=asin(sin_t);
        Indication_of_goodness=asin(sin_t)-acos(cos_t);
        if Indication_of_goodness > 2*pi*1/360
            sprintf('Bad result when getting the angle. The angle differ by ... %0.5e',Indication_of_goodness);
            pause;
        end;
        eiphi=conj(W/abs(W));
        emiphi=W/abs(W);
        Ep=E0+sqrt(Delta^2+abs(W)^2);
        Em=E0-sqrt(Delta^2+abs(W)^2);

        ket_Ep=zeros(2,1);
        ket_Ep(1)=eiphi*cos(theta/2);
        ket_Ep(1)=sin(theta/2);
        ket_Em=zeros(2,1);
        ket_Em(1)=-eiphi*sin(theta/2);
        ket_Ep(1)=cos(theta/2);

        psi=zeros(2,1);
        psi(1)=cos(theta/2)*exp(-1i*Ep*t)*ket_Ep(1)- ...
                sin(theta/2)*emiphi*exp(-1i*Em*t)*ket_Em(1);
        psi(2)=cos(theta/2)*exp(-1i*Ep*t)*ket_Ep(2)- ...
                sin(theta/2)*emiphi*exp(-1i*Em*t)*ket_Em(2);
            

        uk(index_t,index_k)=angle(psi(2));
    end;
end
[X,Y]=meshgrid(t_range,k_range);
X=transpose(X); Y=transpose(Y);
figure;
mesh(X,Y,uk);
xlabel('t');ylabel('k');
title('Test u_k');