# Hierarchical structure of the program

* T_vs_E_and_Gammaz_SpinSx_1DQAHI
    * ScatteringM
        * GreenF
            * g11
            * V_sample
            * H_sample
        * my_sqrt

# g11

    y = g11(E,mu,ts,tso)
    % g11 The submatrix of the Green function of the LEAD
    % Obtained by N times of recursion

# GreenF

    [G11,G1N,GN1,GNN,G1N_R,GN1_R,SE1,SE2]=GreenF(E,L,muS,muL,ts,tc1,tc2,tso,
    tsoL,delta,Gamma,dis)
    % Obtain the GF with recursive method for twoo-lead with same material
    % tc is coupling between S and N

Using:

* g11
* V_sample
* H_sample

# H_lead
    y=H_lead(L,mu,ts,tso)

# H_sample
    y=H_sample(L,mu,ts,tso,delta,Gamma,dis)
    %% Modified program to calculate AIII topological insulator as 
    %% spin transistor

# my_sqrt
    y=my_sqrt(A)
    % this function calculates the squre root of a sparse complex matrix 

# ScatteringM
    function 
    [y11ee,y12ee,y11eh,y12eh,y21ee,y22ee,y21eh,y22eh,y11he,y12he,...
    y11hh,y12hh,y21he,y22he,y21hh,y22hh]
    = ScatteringM_x(E,L,muS,muL,ts,tc1,tc2,tso,tsoL,delta,Gammaz,dis)
    
Using:

* GreenF
* my_sqrt

# T_vs_E_and_Gammaz_SpinSx_1DQAHI.m

Using:

* ScatteringM

# V_dl
    y=V_dl(tc)
    % Vdl: The coupling between the sample and the lead. Vld=Vdl'

# V_lead
    y=V_lead(ts,tso)
    %V: the inside coupling term of the sample between two wires: Vn,n+1; 
        Vn+1,n=conj(Vn,n+1).

# V_sample(ts,tso)
    %V: the inside coupling term of the sample between two wires: 
        Vn,n+1; Vn+1,n=conj(Vn,n+1).
    % tso: SOC
    % electron and hole section are the same in topological insulator case.
