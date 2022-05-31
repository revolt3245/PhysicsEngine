function dx = dynamics(x, Param)
%% parameters
iter = Param.iteration;

%% dx
x_cur = x(1:3,:);
dx_cur = x(4:6,:);

dx(1:3,:) = dx_cur;

%% dynamics
M = eye(3);
Q = zeros(3,1);

[C1, G1, H1] = Phi.VSource(x_cur, Param);
[C2, G2, H2] = Phi.Resistance(x_cur, Param);
[C3, G3, H3] = Phi.KCL(x_cur, Param);

Msys1 = [M G1';G1 0]; Qsys1 = [Q; getGamma(dx_cur, C1, G1, H1, Param)];
Msys2 = [M G2';G2 0]; Qsys2 = [Q; getGamma(dx_cur, C2, G2, H2, Param)];
Msys3 = [M G3';G3 0]; Qsys3 = [Q; getGamma(dx_cur, C3, G3, H3, Param)];

dx1 = zeros(4,1); dx2 = zeros(4,1); dx3 = zeros(4,1);

for i=1:iter
    dx1_temp = Msys1\(Qsys1 - [G2 0]'*dx2(end) - [G3 0]'*dx3(end));
    dx2_temp = Msys2\(Qsys2 - [G3 0]'*dx3(end) - [G1 0]'*dx1(end));
    dx3_temp = Msys3\(Qsys3 - [G1 0]'*dx1(end) - [G2 0]'*dx2(end));

    dx1 = dx1_temp;
    dx2 = dx2_temp;
    dx3 = dx3_temp;
end

dx(4:6,:) = dx1(1:3,:);
end