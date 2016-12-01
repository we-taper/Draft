function H=H_matrix(z)
    I=eye(2);
    J=[0,-1;1,0];
    x=real(z);y=imag(z);
    H=x*I+y*J;
end