function dx = Dynamics(x, Parameters)
%% load model parameter
m = Parameters.m;
g = Parameters.g;
b = Parameters.b;
k = Parameters.k;

M = diag([m m 0]);

%% states
dx(1:3,:) = x(4:6,:);
x_cur = x(1:3,:);

%% constraints
[C, G, H] = Phi(x_cur, Parameters);

%% system matrix
Msys = [M G'; G 0]';

%% Q
Viscous = -b*dx(1:2,:); Viscous = [Viscous; 0];
Gravity = -m*g*[0 1 0]';
Elastic = -k*[0 0 x_cur(3)]';

Q = Viscous + Gravity + Elastic;

%% Gamma
Gamma = getGamma(dx(1:3,:), C, G, H, Parameters);

Qsys = [Q; Gamma];

dx_next = Msys\Qsys;
dx(4:6,:) = dx_next(1:3,:);
end