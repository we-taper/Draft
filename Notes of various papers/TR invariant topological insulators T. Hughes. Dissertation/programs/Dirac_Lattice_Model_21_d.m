clear all;
% This File has two purposes. Therefore, it plots two different graphs.
% Explanations of the two purposes is provided in the end of this
% file.
PY = [-pi:0.25:pi];
M = [-3:0.1:3];
sigma1 = [0,1;1,0];
sigma2 = [0,-1i;1i,0];
sigma3 = [1,0;0,-1];
A = 1i*sigma2 - sigma3;
C = -1i * sigma2 - sigma3;
TheTransferM = zeros(6);
i = 0;
for m = M
    i = i+1; % i for m
    j = 0;
    for py = PY
        j = j+1; % j for py

        B = 2*sin(py)*sigma1 - 2*cos(py)* sigma3 + (2-m)*sigma3;
        TheTransferM(1:2,1:2) = B;
        TheTransferM(1:2,3:4) = C;
        TheTransferM(1:2,5:6) = A;
        for k = 2:2
            B = 2*sin(py)*sigma1 - 2*cos(py)* sigma3 + (2-m)*sigma3;
            TheTransferM(2*k-1:2*k,2*(k-1)-1:2*(k-1)) = A;
            TheTransferM(2*k-1:2*k,2*(k  )-1:2*(k  )) = B;
            TheTransferM(2*k-1:2*k,2*(k+1)-1:2*(k+1)) = C;
        end
        TheTransferM(5:6,1:2) = C;
        TheTransferM(5:6,3:4) = A;
        TheTransferM(5:6,5:6) = B;
        [~,Eigenvalue]=eig(TheTransferM);
        D1(i,j) = Eigenvalue(1,1);
        D2(i,j) = Eigenvalue(2,2);
        D3(i,j) = Eigenvalue(3,3);
        D4(i,j) = Eigenvalue(4,4);
        D5(i,j) = Eigenvalue(5,5);
        D6(i,j) = Eigenvalue(6,6);
    end
    for py = 0
        B = 2*sin(py)*sigma1 - 2*cos(py)* sigma3 + (2-m)*sigma3;
        TheTransferM(1:2,1:2) = B;
        TheTransferM(1:2,3:4) = C;
        TheTransferM(1:2,5:6) = A;
        for k = 2:2
            B = 2*sin(py)*sigma1 - 2*cos(py)* sigma3 + (2-m)*sigma3;
            TheTransferM(2*k-1:2*k,2*(k-1)-1:2*(k-1)) = A;
            TheTransferM(2*k-1:2*k,2*(k  )-1:2*(k  )) = B;
            TheTransferM(2*k-1:2*k,2*(k+1)-1:2*(k+1)) = C;
        end
        TheTransferM(5:6,1:2) = C;
        TheTransferM(5:6,3:4) = A;
        TheTransferM(5:6,5:6) = B;
        [Eigenvector,Eigenvalue]=eig(TheTransferM);
        D_mIs0_3(i) = Eigenvalue(3,3);
        D_mIs0_4(i) = Eigenvalue(4,4);
        V_mIs0_3(i) = Eigenvector(1,3);
        V_mIs0_4(i) = Eigenvector(1,4);
    end
end
% Display the whole Energy spectrum in (m,py)
[mesh_M,mesh_Y] = meshgrid(M,PY);
figure;
mesh(mesh_M,mesh_Y,D1');
hold on;
mesh(mesh_M,mesh_Y,D2');
hold on;
mesh(mesh_M,mesh_Y,D3');
hold on;
mesh(mesh_M,mesh_Y,D4');
hold on;
mesh(mesh_M,mesh_Y,D5');
hold on;
mesh(mesh_M,mesh_Y,D6');
xlabel('m');
ylabel('p_y');
hold off;

% Plot the Eigenvector when py=0
% Confirms, that the 1st component of the 3rd and the 4th Eigenvector
% is actually a ocilliatory value (change quickly w.r.t m).
% Note: It is found that the 3rd and 4th eigenvalue represent the
% spectrum that will cross at point (py=0,m=-2).
figure;
plot(M,V_mIs0_3);
hold on;
plot(M,V_mIs0_4);
xlabel('m');
ylabel('Eigenvector');
hold off;
