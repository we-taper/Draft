%% without normal t
%% Modified program to calculate AIII topological insulator as
%% spin transistor

% i electron up
% i electron down


function y=H_sample(L,mu,ts,tso,delta,Gamma,dis)
y=zeros(4*L);

m_y=0.0;
m_x=00.0;
%Gamma=2.0;

for i=1:L-1
    mu=mu+dis*(rand-0.5);
    y(i,i)=Gamma-mu;
    y(i+L,i+L)=-Gamma-mu;
    y(i+2*L,i+2*L)=Gamma-mu;
    y(i+3*L,i+3*L)=-Gamma-mu;
    
    %y(i,i)=-mu;
    %y(i+L,i+L)=-mu;
    %y(i+2*L,i+2*L)=-mu;
    %y(i+3*L,i+3*L)=-mu;
    
    %=====================================================================
    % Additional term which break C2,T2 symmetry but preserve C1 and T1
    % symmetry. To test the influence of C1 and T1 symmetry.
    y(i,i+L)=j*m_y;
    y(i+L,i)=-j*m_y;
    y(i+2*L,i+3*L)=-j*m_y;
    y(i+3*L,i+2*L)=j*m_y;
    
    %=====================================================================
    
    
    
    y(i,i+1)=-ts;
    y(i+L,i+L+1)=ts;
    y(i+2*L,i+2*L+1)=-ts;
    y(i+3*L,i+3*L+1)=ts;
    
    y(i+1,i)=-ts;
    y(i+L+1,i+L)=ts;
    y(i+2*L+1,i+2*L)=-ts;
    y(i+3*L+1,i+3*L)=ts;
    
    y(i,i+L+1)=tso;
    y(i+1,i+L)=-tso;
    y(i+2*L,i+L+1+2*L)=tso;
    y(i+1+2*L,i+L+2*L)=-tso;
    
    y(i+L+1,i)=tso;
    y(i+L,i+1)=-tso;
    y(i+L+1+2*L,i+2*L)=tso;
    y(i+L+2*L,i+1+2*L)=-tso;
    
    y(i,i+3*L)=delta;
    y(i+L,i+2*L)=-delta;
    y(i+3*L,i)=delta;
    y(i+2*L,i+L)=-delta;
end
mu=mu+dis*(rand-0.5);
y(L,L)=Gamma-mu;
y(2*L,2*L)=-Gamma-mu;
y(3*L,3*L)=-Gamma+mu;
y(4*L,4*L)=Gamma+mu;

y(L,L+3*L)=delta;
y(L+L,L+2*L)=-delta;
y(L+3*L,L)=delta;
y(L+2*L,L+L)=-delta;
y=sparse(y);
end
%}

%% with normal
%{
function y=H_sample(L,mu,ts,tso,delta,Gamma,dis)
%
y=zeros(4*L);
t=.01; % add the normal hoping
for i=1:L-1
    mu=mu+dis*(rand-0.5);
    y(i,i)=Gamma-mu;
    y(i+L,i+L)=-Gamma-mu;
    y(i+2*L,i+2*L)=-Gamma+mu;
    y(i+3*L,i+3*L)=Gamma+mu;
    
    y(i,i+1)=-ts-t;
    y(i+L,i+L+1)=ts-t;
    y(i+2*L,i+2*L+1)=ts+t;
    y(i+3*L,i+3*L+1)=-ts+t;
    
    y(i+1,i)=-ts-t;
    y(i+L+1,i+L)=ts-t;
    y(i+2*L+1,i+2*L)=ts+t;
    y(i+3*L+1,i+3*L)=-ts+t;
    
    y(i,i+L+1)=tso;
    y(i+1,i+L)=-tso;
    y(i+2*L,i+L+1+2*L)=-tso;
    y(i+1+2*L,i+L+2*L)=tso;
    y(i+L+1,i)=tso;
    y(i+L,i+1)=-tso;
    y(i+L+1+2*L,i+2*L)=-tso;
    y(i+L+2*L,i+1+2*L)=tso;
    
    y(i,i+3*L)=delta;
    y(i+L,i+2*L)=-delta;
    y(i+3*L,i)=delta;
    y(i+2*L,i+L)=-delta;
end
mu=mu+dis*(rand-0.5);
y(L,L)=Gamma-mu;
y(2*L,2*L)=-Gamma-mu;
y(3*L,3*L)=-Gamma+mu;
y(4*L,4*L)=Gamma+mu;

y(L,L+3*L)=delta;
y(L+L,L+2*L)=-delta;
y(L+3*L,L)=delta;
y(L+2*L,L+L)=-delta;
y=sparse(y);
end
%}



