% without normal t
% Modified program to calculate AIII topological insulator as
% spin transistor

% i electron up
% i electron down


function y=H_sample(L,mu,ts,tso,delta,Gamma,dis)
% TODO Find reference for this code
%y=zeros(4*L);

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
% TODO the following code might be wrong!
y(3*L,3*L)=-Gamma+mu;
y(4*L,4*L)=Gamma+mu;

y(L,L+3*L)=delta;
y(L+L,L+2*L)=-delta;
y(L+3*L,L)=delta;
y(L+2*L,L+L)=-delta;
y=sparse(y);
end
%}

% % A sample output of the above code:
% [ gamma - mu - dis*(rand - 0.5),                             -ts,                         zero1_3,                          m_y*1i,                               tso,                           zero1_6,                       zero1_7,                         zero1_8,                         zero1_9,                           delta,                          zero1_11,                        zero1_12]
% [                           -ts, gamma - mu - 2*dis*(rand - 0.5),                             -ts,                            -tso,                            m_y*1i,                               tso,                       zero2_7,                         zero2_8,                         zero2_9,                        zero2_10,                             delta,                        zero2_12]
% [                       zero3_1,                             -ts, gamma - mu - 3*dis*(rand - 0.5),                         zero3_4,                              -tso,                           zero3_6,                       zero3_7,                         zero3_8,                         zero3_9,                        zero3_10,                          zero3_11,                           delta]
% [                       -m_y*1i,                            -tso,                         zero4_3, - gamma - mu - dis*(rand - 0.5),                                ts,                           zero4_6,                        -delta,                         zero4_8,                         zero4_9,                        zero4_10,                          zero4_11,                        zero4_12]
% [                           tso,                         -m_y*1i,                            -tso,                              ts, - gamma - mu - 2*dis*(rand - 0.5),                                ts,                       zero5_7,                          -delta,                         zero5_9,                        zero5_10,                          zero5_11,                        zero5_12]
% [                       zero6_1,                             tso,                         zero6_3,                         zero6_4,                                ts, - gamma - mu - 3*dis*(rand - 0.5),                       zero6_7,                         zero6_8,                          -delta,                        zero6_10,                          zero6_11,                        zero6_12]
% [                       zero7_1,                         zero7_2,                         zero7_3,                          -delta,                           zero7_5,                           zero7_6, gamma - mu - dis*(rand - 0.5),                             -ts,                         zero7_9,                         -m_y*1i,                               tso,                        zero7_12]
% [                       zero8_1,                         zero8_2,                         zero8_3,                         zero8_4,                            -delta,                           zero8_6,                           -ts, gamma - mu - 2*dis*(rand - 0.5),                             -ts,                            -tso,                           -m_y*1i,                             tso]
% [                       zero9_1,                         zero9_2,                         zero9_3,                         zero9_4,                           zero9_5,                            -delta,                       zero9_7,                             -ts, mu - gamma + 3*dis*(rand - 0.5),                        zero9_10,                              -tso,                        zero9_12]
% [                         delta,                        zero10_2,                        zero10_3,                        zero10_4,                          zero10_5,                          zero10_6,                        m_y*1i,                            -tso,                        zero10_9, - gamma - mu - dis*(rand - 0.5),                                ts,                       zero10_12]
% [                      zero11_1,                           delta,                        zero11_3,                        zero11_4,                          zero11_5,                          zero11_6,                           tso,                          m_y*1i,                            -tso,                              ts, - gamma - mu - 2*dis*(rand - 0.5),                              ts]
% [                      zero12_1,                        zero12_2,                           delta,                        zero12_4,                          zero12_5,                          zero12_6,                      zero12_7,                             tso,                        zero12_9,                       zero12_10,                                ts, gamma + mu + 3*dis*(rand - 0.5)]
 
% Refer to the scanned notes for a better display of above result.


% with normal
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



