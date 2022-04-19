function x_next = RK4(self, fcn, x_pre)
dx1 = fcn(x_pre);
dx2 = fcn(x_pre + dx1*self.dt/2);
dx3 = fcn(x_pre + dx2*self.dt/2);
dx4 = fcn(x_pre + dx3*self.dt);

x_next = x_pre + (dx1 + dx2*2 + dx3*2 + dx4)*self.dt/6;

end