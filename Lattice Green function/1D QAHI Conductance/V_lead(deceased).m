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