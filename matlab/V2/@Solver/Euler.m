function x_next = Euler(self, fcn, x_pre)
dx = fcn(x_pre);

x_next = x_pre + dx*self.dt;
end