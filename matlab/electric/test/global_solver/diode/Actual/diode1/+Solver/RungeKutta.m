function x_next = RungeKutta(fcn, x, Param, dt)
dx1 = fcn(x, Param);
dx2 = fcn(x + dx1*dt/2, Param);
dx3 = fcn(x + dx2*dt/2, Param);
dx4 = fcn(x + dx3*dt, Param);

dx = (dx1 + 2*dx2 + 2*dx3 + dx4)/6;

x_next = x + dx*dt;
end