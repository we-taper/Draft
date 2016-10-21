function y=V_sample(ts,tso)
%V: the inside coupling term of the sample between two wires: Vn,n+1; Vn+1,n=conj(Vn,n+1).
%tso: SOC
% electron and hole section are the same in topological insulator case.

% ---- A exmaple output ------
% [     -ts,     tso, zero1_3, zero1_4]
% [    -tso,      ts, zero2_3, zero2_4]
% [ zero3_1, zero3_2,     -ts,     tso]
% [ zero4_1, zero4_2,    -tso,      ts]
% -------------------------------
% TODO find reference for this
y=zeros(4);
for i=1:1
    y(i,i)=-ts;
    y(i+1,i+1)=ts;
    y(i+2*1,i+2*1)=-ts;
    y(i+3*1,i+3*1)=ts;
    y(i,i+1)=tso;
    y(i+2*1,i+1+2*1)=tso;
    y(i+1,i)=-tso;
    y(i+1+2*1,i+2*1)=-tso;
end
