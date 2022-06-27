function self = initialize(self, X, dX, Param)
%% state
S = X(self.mapping, :);
dS = dX(self.mapping, :);

%% grad
[C, G, H] = self.getPhi(S);
self.Grad = G;
self.Grad(1) = 0;

%% dx, dQ
[self.dx, self.dQ] = self.getDynamics(S, dS);

%% gamma
self.Gamma = self.getGamma(C, G, H, dS, Param);

%% d2x
self.lambda = 0;
self.lambda_temp = 0;
end