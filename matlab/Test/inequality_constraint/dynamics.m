function dx = dynamics(x, Param)
arguments
    x
    
    Param.alpha (1,1) double=3.46/1e-3
    Param.beta (1,1) double=3.78/1e-6
    
    Param.g (1,1) double=9.8
    Param.m (1,1) double=1
    Param.e (1,1) double=1.0
    
    Param.cond (1,1) logical=false
    
    Param.x_pre (2,1) double=[0;0]
    
    Param.dt (1,1) double=1e-3
end
%% Param
g = Param.g;
m = Param.m;
cond = Param.cond;
x_pre = Param.x_pre;

e = Param.e;
dt = Param.dt;

%% states
x_cur = x(1,:);
dx_cur = x(2,:);

dx(1,:) = dx_cur;

%% inequality cond
if cond
    M = m;
    Q = 0;
    
    [C, G, H] = Phi(x_cur - x_pre(1,:), Param);
    [Cpre, Gpre, ~] = Phi(x_pre(1,:), Param);
    
    Msys = [M G';G 0];
    
    if dx_cur >= x_pre(2)
        Qsys = [Q;0];
    else
        Qsys = [Q; getGamma(C, G, H, dx_cur+e*x_pre(2,:), Param)];
    end
    
    %Qsys = [Q; getGamma(C, G, H, dx_cur+e*x_pre(2,:), Param)];
    dx_next = Msys\Qsys;
else
    M = m;
    Q = -m*g;
    
    dx_next = Q/M;
end

dx(2,:) = dx_next(1,:);
end

function Gamma = getGamma(C, G, H, dx, Param)
alpha = Param.alpha;
beta = Param.beta;

Gamma = -dx'*H*dx - alpha*G*dx - beta*C;
end