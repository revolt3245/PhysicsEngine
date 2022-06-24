function [x_next, dx_next] = RungeKutta(fcn, x_pre, dx_pre, Param)
%% parameter
dt = Param.dt;

%% rk4
[dx1, d2x1] = fcn(x_pre, dx_pre, Param);
[dx2, d2x2] = fcn(x_pre + dx1*dt/2, dx_pre + d2x1*dt/2, Param);
[dx3, d2x3] = fcn(x_pre + dx2*dt/2, dx_pre + d2x2*dt/2, Param);
[dx4, d2x4] = fcn(x_pre + dx3*dt, dx_pre + d2x3*dt, Param);

dx = (dx1 + 2*dx2 + 2*dx3 + dx4)/6;
d2x = (d2x1 + 2*d2x2 + 2*d2x3 + d2x4)/6;

%% output
x_next = x_pre + dx*dt;
dx_next = dx_pre + d2x*dt;
end