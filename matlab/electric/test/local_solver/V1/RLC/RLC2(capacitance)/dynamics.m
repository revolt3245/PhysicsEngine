function dx = dynamics(x, Param)
%% parameters
iter = Param.iteration;
Phi_mapping = Param.Phi_mapping;

alpha_gs = Param.alpha_gs;

constraint_number = size(Phi_mapping, 2);
%% dx
x_cur = x(1:6,:);
dx_cur = x(7:12,:);

dx(1:6,:) = dx_cur;

%% dynamics
M = eye(6);
Q = zeros(6,1);

G_global = zeros(constraint_number, 6);

idx = 1;
%% local dynamics
for constraints = Phi_mapping
    mapping_local = constraints.mapping;
    [C, G, H] = constraints.Phi(x_cur, mapping_local, Param);

    dx_local = dx_cur(mapping_local);
    Gamma = Dynamics.getGamma(dx_local, C, G, H, Param);

    LD(idx) = Dynamics.getLocal_dynamics(M, Q, mapping_local, G, Gamma);

    G_global(idx, mapping_local) = G;
    idx = idx + 1;
end

%% iteration
dx_global = zeros(7, constraint_number);
dx_temp = zeros(7, constraint_number);
for i = 1:iter
    for constraints = 1:constraint_number
        mapping_local = Phi_mapping(constraints).mapping;

        Msys = LD(constraints).Msys;
        Qsys = LD(constraints).Qsys;

        lambdas = dx_global(end,:);
        lambdas(constraints) = 0;

        G_local = G_global(:,mapping_local);

        G_diff = [lambdas*G_local 0]';

        dx_out = Msys\(Qsys - G_diff);

        dx_temp(1:end-1, constraints) = -(lambdas * G_global)';

        dx_temp(mapping_local, constraints) = dx_out(1:end-1,:);
        dx_temp(end,constraints) = dx_out(end,:);
    end
    dx_global = dx_global * (1-alpha_gs) + dx_temp * alpha_gs;
end

dx(7:12,:) = mean(dx_global(1:end-1,:), 2);
end