function outParam = getParameter(inParam)
arguments
    %% solver
    inParam.alpha_hat (1,1) double = 3.46;
    inParam.beta_hat (1,1) double = 3.78;

    inParam.dt (1,1) double = 1/6000;
    %% iteration
    inParam.alpha_gs (1,1) double = 0.5;

    inParam.n_iter (1,1) uint64 = 1;
end
%% parameter
alpha_hat = inParam.alpha_hat;
beta_hat = inParam.beta_hat;

dt = inParam.dt;

alpha = alpha_hat/dt;
beta = beta_hat/dt^2;

%% result
outParam = inParam;

outParam.alpha = alpha;
outParam.beta = beta;
end