function outParam = getParameter(inParam)
arguments
    %% model
    inParam.m (1,1) double=1;
    inParam.r (1,1) double=1;

    inParam.g (1,1) double=9.8;
    inParam.b (1,1) double=0.1;

    %% solver
    inParam.dt (1,1) double=1/6000;

    %% equality constraint
    inParam.alpha_hat_eq (1,1) double = 3.46;
    inParam.beta_hat_eq (1,1) double = 3.78;

    %% inequality constraint
    inParam.beta_hat_ineq (1,1) double = 1.0;

    inParam.e_ineq (1,1) double = 1.0;
    inParam.mu_ineq (1,1) double = 0.05;
end
outParam = inParam;

%% equality constraint
outParam.alpha_eq = inParam.alpha_hat_eq/inParam.dt;
outParam.beta_eq = inParam.beta_hat_eq/inParam.dt^2;

outParam.beta_ineq = inParam.beta_hat_ineq/inParam.dt;
end