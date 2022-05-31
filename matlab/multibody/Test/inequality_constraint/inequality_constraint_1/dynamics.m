function dx = dynamics(x, Param)
arguments
    x
    
    Param.g (1,1) double=9.8
    Param.m (1,1) double=1

    Param.cond (1,1) logical=false

    Param.dt (1,1) double=1e-3;
    Param.alpha_hat (1,1) double=1;
end
%% Param
g = Param.g;
m = Param.m;

alpha = Param.alpha_hat/Param.dt;

cond = Param.cond;

%% states
dx_cur = x(2,:);

dx(1,:) = dx_cur;
if cond
    dx(1,:) = dx(1,:) -alpha*x(1,:);
end

dx(2,:) = -m*g;
end