function dx = dynamics(x, cond, Param)
%% parameters
iter = Param.iteration;

alpha_gd = Param.alpha_gd;

%% dx
x_cur = x(1:10,:);
dx_cur = x(11:end,:);

dx(1:10,:) = dx_cur;

%% dynamics
M = eye(10);
Q = zeros(10,1);

%% constraints
C = zeros(9,1);
G = zeros(9,10);
H = zeros(9,10,10);

[C(1), G(1,:), H(1,:,:)] = Phi.VSource(1, x_cur, Param);

[C(2), G(2,:), H(2,:,:)] = Phi.R(1, x_cur, Param);

for i = 1:3
    [C(2+i), G(2+i,:), H(2+i,:,:)] = Phi.KCL(i, x_cur, Param);
end

for i = 1:4
    [C(5+i), G(5+i,:), H(5+i,:,:)] = Phi.D(i, x_cur, cond, Param);
end

Gt = G;
Gt(:,1) = 0;

%% Msys, Qsys
Msys = zeros(9, 11, 11);
Qsys = zeros(9, 11);

for i=1:9
    C_cur = C(i);
    G_cur = G(i,:);
    Gt_cur = Gt(i,:);
    H_cur = reshape(H(i,:,:), 10, 10);

    Msys(i,:,:) = [M Gt_cur';Gt_cur 0];
    Gamma = getGamma(dx_cur, C_cur, G_cur, H_cur, Param);
    Qsys(i,:) = [Q; Gamma]';
end

%% iteration
dxs = zeros(11, 9);
dx_temp = zeros(11,9);

for iteration = 1:iter
    for constraints = 1:9
        Msys_cur = reshape(Msys(constraints,:,:), 11, 11);
        Qsys_cur = reshape(Qsys(constraints,:), 11, 1);

        lambdas = dxs(end,:);
        lambdas(constraints) = 0;

        Residual = lambdas * Gt;

        dx_temp(:,constraints) = Msys_cur\(Qsys_cur - [Residual 0]');
    end
    dxs = dxs * (1-alpha_gd) + alpha_gd * dx_temp;
end

dx(11:20, :) = dxs(1:end-1, 1);
end