function x_next = RungeKutta(self, Fcn, x_pre)
dx1 = Fcn(x_pre);
dx2 = Fcn(x_pre + dx1*self.dt/2);
dx3 = Fcn(x_pre + dx2*self.dt/2);
dx4 = Fcn(x_pre + dx3*self.dt);

x_next = x_pre + (dx1 + dx2*2 + dx3*2 + dx4)/6;

end