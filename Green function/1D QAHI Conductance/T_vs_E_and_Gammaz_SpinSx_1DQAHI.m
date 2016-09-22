% ============= T vs E =========================================
clear
cont=1.0;   % =1 for 2D countour plot, otherwise for 1D plot

% Here we use ts as a reference for other energies.
L=20;        % number of sites
ts=10;       % hoping
tso=1.0;     % spin orbital coupling
tsoL=0;      % spin orbital coupling of the leads
tc1=0.2*ts;  % coupling between lead 1 and the sample
tc2=0.2*ts;  % coupling between lead 2 and the sample
muL=5.0;     % chemical potential of the leads
muS=0;       % chemical potential of the sample
disorder=0;  % local disorder
delta=0.0;   % superconducting pairing

M_gamma=200; % gamma
N_E=200;     % E

if cont==1
    % For cont=1, we try to plot G as a function of gamma
    % and E.
    gamma=3*(-ts:2.0*ts/M_gamma:ts);  % Zeeman energy
    E=(-muL:2*muL/N_E:1*muL);
else
    gamma=3.0;      % Zeeman energy Gammz_z as a constant
    gap=min(abs(2*ts-abs(gamma)),2*abs(tso));
    %  E=(-1*gap:2*gap/N:1*gap);                                 % bias energy eV
    E=(-muL:2*muL/N_E:1*muL);
    %pause(0.5)
end

M_gamma=length(gamma);N_E=length(E)
pause(0.5)

% TC: Transmission Coefficient.
% TL: what? TODO
TCee=zeros(N_E,M_gamma);
TChe=zeros(N_E,M_gamma);
TLee=zeros(N_E,M_gamma);
TLhe=zeros(N_E,M_gamma);
dis=disorder*(rand(1,L)-0.5);

for i=1:N_E
    i % Indicating the progress of this script
    for j=1:M_gamma
        [y11ee,y12ee,y11eh,y12eh,y21ee,y22ee,y21eh,y22eh,y11he,y12he,...
          y11hh,y12hh,y21he,y22he,y21hh,y22hh]=ScatteringM(E(i),L,muS,muL,ts,tc1,tc2,tso,tsoL,delta,gamma(j),dis);
        % TODO what is the purpose of the following code
        %yup=T_up(y11ee,y12ee,y11eh,y12eh,y21ee,y22ee,y21eh,y22eh,y11he,y12he,...
        %    y11hh,y12hh,y21he,y22he,y21hh,y22hh);
        %ydown=T_down(y11ee,y12ee,y11eh,y12eh,y21ee,y22ee,y21eh,y22eh,y11he,y12he,...
        %    y11hh,y12hh,y21he,y22he,y21hh,y22hh);
        %  TLee(i,j)=y(1,1)/2.0; % Local e-e
        %  TLhe(i,j)=y(3,1)/2.0; % Local AR
        %  TCee(i,j)=y(2,1)/2.0; % crossed e-e
        %  TChe(i,j)=y(4,1)/2.0; % CAR
        %  Tsumee(i,j)=TLee(i,j)+TCee(i,j);
        
        % TODO why do we sum before taking absolute value
        % why do we have to take the average.
        TCeeupup(j,i)=(abs(y21ee(1,1)+y21ee(2,1)+y21ee(1,2)+y21ee(2,2)))^2/4.0; % Local e-e Sx up up
        TCeedownup(j,i)=(abs(y21ee(1,1)-y21ee(2,1)+y21ee(1,2)-y21ee(2,2)))^2/4.0; % Local e-e Sx down up
        TCeeup(j,i)=(TCeeupup(j,i)+TCeedownup(j,i)); % crossed e-e
        TCeeupdown(j,i)=(abs(y21ee(1,1)+y21ee(2,1)-y21ee(1,2)-y21ee(2,2)))^2/4.0; % Local e-e Sx up up
        TCeedowndown(j,i)=(abs(y21ee(1,1)-y21ee(2,1)-y21ee(1,2)+y21ee(2,2)))^2/4.0; % Local e-e Sx down up
        TCeedown(j,i)=(TCeeupdown(j,i)+TCeedowndown(j,i)); % crossed e-e
    end
end

cont=2.0;

if cont==1
    [X,Y]=meshgrid(E,gamma);
    figure
    
    
    %subplot(2,1,1);
    axes('position',[.1  .15  .25  .80])
    contourf(X,Y,TCeeupup,20);shading flat;%colorbar;
    xlabel('E','FontSize',25);
    ylabel('\Gamma_z','FontSize',25);
    legend('TC (S_x up\rightarrow up)','FontSize',25)
    set(gca,'YTickLabel',[-30;-20;-10;0;10;20; 30],'FontSize',25)
    % title(['AR',',mu_S=',num2str(muS),',mu_L=',num2str(muL),',dis=',num2str(disorder)];['L=',int2str(L),',ts=',num2str(ts),',tc1=',num2str(tc1),',tc2=',num2str(tc2),',tso=',num2str(tso),',\Delta=',num2str(delta)]})
    
    %subplot(2,1,2);
    axes('position',[.4  .15  .25  .80])
    contourf(X,Y,TCeedownup,20);shading flat;%colorbar;
    xlabel('E','FontSize',25);
    legend('TC (S_x up\rightarrow  down)','FontSize',25)
    set(gca,'YTickLabel',[-30;-20;-10;0;10;20; 30],'FontSize',25)
    
    axes('position',[.70  .15  .35  .80])
    contourf(X,Y,TCeeup,20);shading flat;colorbar;
    %ylabel('\Gamma_z','FontSize',25);
    xlabel('E','FontSize',25);
    legend('TC (S_x) L=20','FontSize',25)
    set(gca,'YTickLabel',[-30;-20;-10;0;10;20; 30],'FontSize',25)
elseif cont==2.0
    figure;
    [X,Y]=meshgrid(E,gamma);
    
    axes('position',[.30  .15  .12  .60])
    contourf(X,Y,TCeeupdown,20);shading flat;%colorbar;
    xlabel('E','FontSize',25);
    ylabel('\Gamma_z','FontSize',25);
    legend('T_{+x,-x}','FontSize',25)
    set(gca,'YTickLabel',[-30;-20;-10;0;10;20; 30],'FontSize',25)
    % title(['AR',',mu_S=',num2str(muS),',mu_L=',num2str(muL),',dis=',num2str(disorder)];['L=',int2str(L),',ts=',num2str(ts),',tc1=',num2str(tc1),',tc2=',num2str(tc2),',tso=',num2str(tso),',\Delta=',num2str(delta)]})
    
    %subplot(2,1,2);
    axes('position',[.45  .15  .12  .60])
    contourf(X,Y,TCeedowndown,20);shading flat;%colorbar;
    % ylabel('\Gamma_z','FontSize',25);
    xlabel('E','FontSize',25);
    legend('T_{-x,-x}','FontSize',25)
    set(gca,'YTickLabel',[-30;-20;-10;0;10;20; 30],'FontSize',25)
    
    axes('position',[.60  .15  .12  .60])
    contourf(X,Y,TCeeupup,20);shading flat;%colorbar;
    xlabel('E','FontSize',25);
    % ylabel('\Gamma_z','FontSize',25);
    legend('T_{+x,+x}','FontSize',25)
    set(gca,'YTickLabel',[-30;-20;-10;0;10;20; 30],'FontSize',25)
    % title(['AR',',mu_S=',num2str(muS),',mu_L=',num2str(muL),',dis=',num2str(disorder)];['L=',int2str(L),',ts=',num2str(ts),',tc1=',num2str(tc1),',tc2=',num2str(tc2),',tso=',num2str(tso),',\Delta=',num2str(delta)]})
    
    %subplot(2,1,2);
    axes('position',[.75  .15  .22  .60])
    contourf(X,Y,TCeedownup,20);shading flat;colorbar;
    xlabel('E','FontSize',25);
    legend('T_{-x,+x}','FontSize',25)
    set(gca,'YTickLabel',[-30;-20;-10;0;10;20; 30],'FontSize',25)
elseif cont==3.0
    figure;
    [X,Y]=meshgrid(E,gamma);
    
    axes('position',[.33  .15  .12  .60])
    contourf(X,Y,TCeeupdown,20);shading flat;%colorbar;
    xlabel('E','FontSize',25);
    ylabel('\Gamma_z','FontSize',25);
    legend('T_{+x,-x}','FontSize',25)
    set(gca,'YTickLabel',[-30;-20;-10;0;10;20; 30],'FontSize',25)
    % title(['AR',',mu_S=',num2str(muS),',mu_L=',num2str(muL),',dis=',num2str(disorder)];['L=',int2str(L),',ts=',num2str(ts),',tc1=',num2str(tc1),',tc2=',num2str(tc2),',tso=',num2str(tso),',\Delta=',num2str(delta)]})
    
    %subplot(2,1,2);
    axes('position',[.48  .15  .12  .60])
    contourf(X,Y,TCeedowndown,20);shading flat;%colorbar;
    % ylabel('\Gamma_z','FontSize',25);
    xlabel('E','FontSize',25);
    legend('T_{-x,-x}','FontSize',25)
    set(gca,'YTickLabel',[-30;-20;-10;0;10;20; 30],'FontSize',25)
    
    axes('position',[.63  .15  .12  .60])
    contourf(X,Y,TCeeupup,20);shading flat;%colorbar;
    xlabel('E','FontSize',25);
    % ylabel('\Gamma_z','FontSize',25);
    legend('T_{+x,+x}','FontSize',25)
    set(gca,'YTickLabel',[-30;-20;-10;0;10;20; 30],'FontSize',25)
    % title(['AR',',mu_S=',num2str(muS),',mu_L=',num2str(muL),',dis=',num2str(disorder)];['L=',int2str(L),',ts=',num2str(ts),',tc1=',num2str(tc1),',tc2=',num2str(tc2),',tso=',num2str(tso),',\Delta=',num2str(delta)]})
    
    %subplot(2,1,2);
    axes('position',[.78  .15  .22  .60])
    contourf(X,Y,TCeedownup,20);shading flat;colorbar;
    xlabel('E','FontSize',25);
    legend('T_{-x,+x}','FontSize',25)
    set(gca,'YTickLabel',[-30;-20;-10;0;10;20; 30],'FontSize',25)
else
    [X,Y]=meshgrid(E,gamma);
    figure
    
    
    %subplot(2,1,1);
    axes('position',[.1  .15  .25  .80])
    contourf(X,Y,TCeeupdown,20);shading flat;%colorbar;
    xlabel('E','FontSize',25);
    ylabel('\Gamma_z','FontSize',25);
    legend('TC (S_x down\rightarrow S_x up)','FontSize',25)
    set(gca,'YTickLabel',[-30;-20;-10;0;10;20; 30],'FontSize',25)
    % title(['AR',',mu_S=',num2str(muS),',mu_L=',num2str(muL),',dis=',num2str(disorder)];['L=',int2str(L),',ts=',num2str(ts),',tc1=',num2str(tc1),',tc2=',num2str(tc2),',tso=',num2str(tso),',\Delta=',num2str(delta)]})
    
    %subplot(2,1,2);
    axes('position',[.40  .15  .25  .80])
    contourf(X,Y,TCeedowndown,20);shading flat;%colorbar;
    % ylabel('\Gamma_z','FontSize',25);
    xlabel('E','FontSize',25);
    legend('TC (S_x down\rightarrow S_x down)','FontSize',25)
    set(gca,'YTickLabel',[-30;-20;-10;0;10;20; 30],'FontSize',25)
    
    axes('position',[.7  .15  .35  .80])
    contourf(X,Y,TCeedown,20);shading flat;colorbar;
    % ylabel('\Gamma_z','FontSize',25);
    xlabel('E','FontSize',25);
    legend('TC (S_x) L=20','FontSize',25)
    set(gca,'YTickLabel',[-30;-20;-10;0;10;20; 30],'FontSize',25)
    
    % title({['T_C_h_e',',mu_S=',num2str(muS),',mu_L=',num2str(muL),',dis
end
