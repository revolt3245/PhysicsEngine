function x_next = RungeKuttaWrapper(fcn, x_cur, dt)
dx1 = fcn(x_cur);
dx2 = fcn(x_cur + dx1*dt/2);
dx3 = fcn(x_cur + dx2*dt/2);
dx4 = fcn(x_cur + dx3*dt);

x_next = x_cur + (dx1 + 2*dx2 + 2*dx3 + dx4)*dt/6;
end