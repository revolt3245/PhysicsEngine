function Gamma = getGamma(~, C, G, H, dX, Param)
%% parameter
alpha = Param.alpha;
beta = Param.beta;

d2C = dX'*H*dX;
dC = G*dX;

Gamma = -d2C - alpha*dC - beta*C;
end