function self = updateLambda(self, Param)
%% parameter
alpha_gs = Param.alpha_gs;

self.lambda = self.lambda + alpha_gs * self.lambda_temp;
end