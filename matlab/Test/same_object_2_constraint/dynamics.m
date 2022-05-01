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

Msys = cat(3, Msys1, Msys2);

L = zeros(4,2);
L13 = -b*[dx(1) dx(2) 0]' - [0 m*g 0]';
L(1:3,:) = repmat(L13, 1, 2);
L(4,1) = getGamma(dx(1:3), C1, G1, H1, Parameter);
L(4,2) = getGamma(dx(1:3), C2, G2, H2, Parameter);

dxtemp = zeros(4,2);
dxpre = zeros(4,2);

G = [G1' G2'];

for i=1:iter
    for j=1:2
        lambdas = dxpre(4,:);
        lambdas(j) = 0;
        
        subs = [G * lambdas'; 0];
        Ltemp = L(:,j) - subs;
        
        dxtemp(:,j) = Msys(:,:,j)\Ltemp;
    end
    dxpre = dxtemp;
end

dx(4:6) = dxtemp(1:3, 1);
end