function dx = dynamics(x, Parameter)
%% load model parameters
M = Parameter.M;
g = Parameter.g;
m = Parameter.m;
b = Parameter.b;

%% iteration
iter = Parameter.iter;

%% states
dx(1:3,:) = x(4:6,:);
x_cur = x(1:3,:);

%% constraints
[C1, G1, H1] = Phi1(x_cur, Parameter);
[C2, G2, H2] = Phi2(x_cur, Parameter);

%% system matrix
Msys1 = [M G1'; G1 0];
Msys2 = [M G2'; G2 0];

L1 = [-b*dx(1) -m*g-b*dx(2) 0 getGamma(dx(1:3), C1, G1, H1, Parameter)]';
L2 = [-b*dx(1) -m*g-b*dx(2) 0 getGamma(dx(1:3), C2, G2, H2, Parameter)]';

dx1 = zeros(4,1); dx2 = zeros(4,1);

for i=1:iter
    L1temp = L1 - dx2(4)*[G2 0]';
    L2temp = L2 - dx1(4)*[G1 0]';
    
    dx1 = Msys1\L1temp;
    dx2 = Msys2\L2temp;
end

dx(4:6) = dx1(1:3);
end