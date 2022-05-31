clc; clear; close;

%% Parameters
Param = getParameters(R = 5);

%% initial condition
X = zeros(6,1);

for i=1:60
    for j=1:100
        X = Solver.RungeKutta(@dynamics, X, Param, Param.dt);
    end

    disp(X);
end