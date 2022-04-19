function x_next = RungeKuttaWrapper(Fcn, x, step)
dx1 = Fcn(x);
dx2 = Fcn(x + dx1 * step/2);
dx3 = Fcn(x + dx2 * step/2);
dx4 = Fcn(x + dx3 * step);

dx = (dx1 + dx2 * 2 + dx3 * 2 + dx4)/6;
x_next = x + dx * step;
end