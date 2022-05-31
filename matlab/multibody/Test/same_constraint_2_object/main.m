clear; clc; close;

%% Parameter
Param = getParameter;

M = Param.M;

m1 = Param.m1;
m2 = Param.m2;
g = Param.g;
b = Param.b;

iter = Param.iter;

%% initial state
x = [-0.5 10 0.5 10 0 -1 0 -1]';

%% global solution
[C, G, H] = getPhi(x(1:4,:), Param);

Gamma = getGamma(x(5:8,:), C, G, H, Param);

Msys = [M G'; G 0];
Q = -g*[0 m1 0 m2]' - b*x(5:8,:);

Qsys = [Q; Gamma];

dx = Msys\Qsys;

disp(dx);

%% gauss-seidel solution
M1 = M(1:2, 1:2); M2 = M(3:4, 3:4);
G1 = G(:,1:2); G2 = G(:,3:4);
Q1 = Q(1:2,:); Q2 = Q(3:4,:);

Gs = [G1; G2];

Msys1 = [M1 G1';G1 0];
Msys2 = [M2 G2';G2 0];

Qsys1 = [Q1; Gamma/2]; Qsys2 = [Q2; Gamma/2];

dx_gs = zeros(3,2);

for i=1:iter
    Qsys1(3,1) = Qsys1(3,1) - G2*(M2\(Q2 - dx_gs(3,1)*G2'));
    Qsys2(3,1) = Qsys2(3,1) - G1*(M1\(Q1 - dx_gs(3,2)*G1'));
    
    dx_temp(:,1) = Msys1\Qsys1;
    dx_temp(:,2) = Msys2\Qsys2;
    
    dx_gs = 0.5*dx_gs + 0.5*dx_temp;
    
    disp(dx_gs);
end