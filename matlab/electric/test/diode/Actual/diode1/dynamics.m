function dx = dynamics(x, Param)
%% parameters
iter = Param.iteration;

%% dx
x_cur = x(1:6,:);
dx_cur = x(7:12,:);

dx(1:6,:) = dx_cur;

%% dynamics
M = eye(6);
Q = zeros(6, 1);

C = zeros(5,1); G = zeros(5,6); H = zeros(5, 6, 6);

[C(1,1), G(1,:), H(1,:,:)] = Phi.VSource(x_cur, Param);
[C(2,1), G(2,:), H(2,:,:)] = Phi.KCL1(x_cur, Param);
[C(3,1), G(3,:), H(3,:,:)] = Phi.KCL2(x_cur, Param);
[C(4,1), G(4,:), H(4,:,:)] = Phi.R1(x_cur, Param);
[C(5,1), G(5,:), H(5,:,:)] = Phi.D1(x_cur, Param);

%% dynamics
Msys = zeros(5, 7, 7);
Qsys = zeros(5, 7, 1);

for constraints=1:5
    Hcur = reshape(H(constraints,:,:), 6, 6);

    Gt = G(constraints,:);
    Gt(1) = 0;

    Msys(constraints,:,:) = [M Gt';Gt 0];
    Qsys(constraints,:,:) = [Q; getGamma(dx_cur, C(constraints,:), G(constraints,:), Hcur, Param)];
end

%% iteration
dxs = zeros(7, 5);
dx_temp = zeros(7,5);

for i=1:iter
    for constraints=1:5
        Msys_cur = reshape(Msys(constraints, :, :), 7, 7);
        Qsys_cur = reshape(Qsys(constraints, :, :), 7, 1);
        Lambdas = dxs(end,:);

        Lambdas(constraints) = 0;

        diffs = Lambdas * G;
        diffs(1) = 0;
        diffs = [diffs 0]';
        
        dx_temp(:,constraints) = Msys_cur\(Qsys_cur - diffs);
    end
    dxs = dxs * 0.5 + dx_temp * 0.5;
end

dx(7:12,:) = dxs(1:end-1, 1);
end