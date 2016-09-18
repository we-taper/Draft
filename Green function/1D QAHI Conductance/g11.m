function y=g11(E,mu,ts,tso,w_energy_resol)
    %g11 The submatrix of the Green function of the LEAD
    % Obtained by N times of recursion
    D=(E+1i*w_energy_resol)*eye(4)-H_lead(1,mu,ts,tso);
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

function y=H_lead(L,mu,ts,tso)
    y=zeros(4*L);
    Gamma=00.0;  % Gamma: the Zeeman energy in the leads.
    condition=1.0; % =1 for spin independent hoping ts
    %tso=0.0; tso=0 or not, the results are quite different!
    m_y=00.0;
    m_x=0.0;

    %=====================================================================
    % Additional term which break C2,T2 symmetry but preserve C1 and T1
    % symmetry. To test the influence of C1 and T1 symmetry.
    %y(i,i+L)=I*m_y;
    %y(i+L,i)=-I*m_y;
    %y(i+2*L,i+3*L)=-I*m_y;
    %y(i+3*L,i+2*L)=I*m_y;
    %=====================================================================
    for i=1:L-1
        y(i,i)=Gamma-mu;
        y(i+L,i+L)=-Gamma-mu;
        y(i+2*L,i+2*L)=Gamma-mu;
        y(i+3*L,i+3*L)=-Gamma-mu;
        
        %=====================================================================
        % Additional term which break C2,T2 symmetry but preserve C1 and T1
        % symmetry. To test the influence of C1 and T1 symmetry.
        y(i,i+L)=m_x+I*m_y;
        y(i+L,i)=m_x-I*m_y;
        y(i+2*L,i+3*L)=m_x-I*m_y;
        y(i+3*L,i+2*L)=m_x+I*m_y;
        
        %=====================================================================
        if condition==1
            y(i,i+1)=-ts;
            y(i+L,i+L+1)=-ts;
            y(i+2*L,i+2*L+1)=-ts;
            y(i+3*L,i+3*L+1)=-ts;
            
            y(i+1,i)=-ts;
            y(i+L+1,i+L)=-ts;
            y(i+2*L+1,i+2*L)=-ts;
            y(i+3*L+1,i+3*L)=-ts;
        else
            y(i,i+1)=-ts;
            y(i+L,i+L+1)=ts;
            y(i+2*L,i+2*L+1)=-ts;
            y(i+3*L,i+3*L+1)=ts;
            
            y(i+1,i)=-ts;
            y(i+L+1,i+L)=ts;
            y(i+2*L+1,i+2*L)=-ts;
            y(i+3*L+1,i+3*L)=ts;
        end

        y(i,i+L)=I*m_y;
        y(i+L,i)=-I*m_y;
        y(i+2*L,i+3*L)=-I*m_y;
        y(i+3*L,i+2*L)=I*m_y;
        
        y(i,i+L+1)=tso;
        y(i+1,i+L)=-tso;
        y(i+2*L,i+L+1+2*L)=tso;
        y(i+1+2*L,i+L+2*L)=-tso;
        y(i+L+1,i)=tso;
        y(i+L,i+1)=-tso;
        y(i+L+1+2*L,i+2*L)=tso;
        y(i+L+2*L,i+1+2*L)=-tso;
    end
    y(L,L)=-mu;
    y(2*L,2*L)=-mu;
    y(3*L,3*L)=-mu;
    y(4*L,4*L)=-mu;
    %y=sparse(y);
end

function y=V_lead(ts,tso)
    %V: the inside coupling term of the sample between two wires: Vn,n+1; Vn+1,n=conj(Vn,n+1).
    %tso: SOC
    y=zeros(4);
    for i=1:1
        y(i,i)=-ts;
        y(i+1,i+1)=-ts;
        y(i+2*1,i+2*1)=ts;
        y(i+3*1,i+3*1)=ts;
        
        y(i,i+1)=tso;
        y(i+2*1,i+1+2*1)=-tso;
        y(i+1,i)=-tso;
        y(i+1+2*1,i+2*1)=tso;
end
