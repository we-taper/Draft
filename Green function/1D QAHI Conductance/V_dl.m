function y=V_dl(tc)
% Vdl: The coupling between the sample and the lead. Vld=Vdl'
% T: the coupling amplitude 
y=tc*diag([-1,-1,-1,-1]); 
end
