function outParam = getParameters(inParam)
arguments
    %% solver
    inParam.dt (1,1) double = 1/6000;
    
    inParam.alpha_hat_eq (1,1) double = 3.46;
    inParam.beta_hat_eq (1,1) double = 3.78;

    inParam.iteration (1,1) uint64 = 20;
    %% dynamics
    inParam.V0 (1,1) double = 5;
    inParam.R (1,1) double = 1;
end
%% sovler option
dt = inParam.dt;

alpha_hat_eq = inParam.alpha_hat_eq;
beta_hat_eq = inParam.beta_hat_eq;

alpha_eq = alpha_hat_eq/dt;
beta_eq = beta_hat_eq/dt^2;

%% output
outParam = inParam;

outParam.alpha_eq = alpha_eq;
outParam.beta_eq = beta_eq;
end