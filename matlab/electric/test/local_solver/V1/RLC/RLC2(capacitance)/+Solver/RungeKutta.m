function x_next = RungeKutta(fcn, x_pre, Param)
%% parameter
dt = Param.dt;

%% rk4
dx1 = fcn(x_pre, Param);
dx2 = fcn(x_pre + dx1*dt/2, Param);
dx3 = fcn(x_pre + dx2*dt/2, Param);
dx4 = fcn(x_pre + dx3*dt, Param);

dx = (dx1 + 2*dx2 + 2*dx3 + dx4)/6;

%% output
x_next = x_pre + dx*dt;
end