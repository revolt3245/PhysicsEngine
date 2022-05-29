function dx = dynamics(x, Param, cond)
%% Param
g = Param.g;
m = Param.m;
b = Param.b;

beta = Param.beta_ineq;

%% states
x_cur = x(1:2, :);
dx_cur = x(3:4, :);

dx(1:2,:) = dx_cur;

[C,~,~] = getPhi(x, Param);

if cond
    dx(2,:) = dx(2,:) - beta * C;
end

%% system
M = diag([m, m]);
Q = -m*g*[0 1]' - b * dx(1:2,:);

dx(3:4,:) = M\Q;
end