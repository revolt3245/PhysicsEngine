function outParam = getParameter(inParam)
arguments
    %% dynamics
    inParam.g (1,1) double=9.8;
    inParam.b (1,1) double=0.3;
    
    inParam.m1 (1,1) double=1.0;
    inParam.m2 (1,1) double=2.0;
    %% constraint
    inParam.l (1,1) double=1.0;
    
    %% stabilization
    inParam.alpha_hat (1,1) double=3.46;
    inParam.beta_hat (1,1) double=3.78;
    
    %% simulation
    inParam.dt (1,1) double=1/6000;
    
    %% gauss_seidel
    inParam.iter (1,1) double=100;
end
outParam = inParam;

%% export
m1 = inParam.m1;
m2 = inParam.m2;

alpha_hat = inParam.alpha_hat;
beta_hat = inParam.beta_hat;
dt = inParam.dt;
%% Dynamics
outParam.M = diag([m1 m1 m2 m2]);

%% Stabilization
outParam.alpha = alpha_hat/dt;
outParam.beta = beta_hat/dt^2;
end