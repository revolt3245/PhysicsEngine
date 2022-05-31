function Gamma = getGamma(dx, C, G, H, Param)
%% parameters
alpha_eq = Param.alpha_eq;
beta_eq = Param.beta_eq;

d2C = dx'*H*dx;
dC = G * dx;

Gamma = -d2C - alpha_eq*dC - beta_eq*C;
end