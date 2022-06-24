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
self.d2x = zeros(size(S, 1) + 1, 1);
self.d2x_temp = zeros(size(S, 1) + 1, 1);
end