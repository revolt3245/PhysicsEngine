function outParam = getParameters(inParam)
arguments
    inParam.alpha_hat = 3.46;
    inParam.beta_hat = 3.78;

    inParam.dt = 1/6000;

    inParam.size_A = 100;
    
    inParam.n_iter = 1;
    inParam.alpha_gs = 40;
end
%% parameter
alpha_hat = inParam.alpha_hat;
beta_hat = inParam.beta_hat;
dt = inParam.dt;
size_A = inParam.size_A;

%% out parameter
alpha = alpha_hat/dt;
beta = beta_hat/dt^2;

A = sparse(trigonalMatrix(size_A));
B = ones(size_A, 1)/size_A^2;

A_check = matCheck(A);
A_available = logical(A);

outParam = inParam;

outParam.alpha = alpha;
outParam.beta = beta;

outParam.A = A;
outParam.B = B;
outParam.A_check = A_check;
outParam.A_available = A_available;
end