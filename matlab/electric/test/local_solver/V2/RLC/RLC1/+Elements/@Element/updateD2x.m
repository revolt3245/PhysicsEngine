function self = updateD2x(self, Param)
%% parameter
alpha_gs = Param.alpha_gs;

self.d2x = (1-alpha_gs)*self.d2x + alpha_gs * self.d2x_temp;
end