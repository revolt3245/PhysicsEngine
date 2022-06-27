function Gamma = getGamma(X, dX, Param)
%% parameter
A = Param.A;
B = Param.B;

alpha = Param.alpha;
beta = Param.beta;

C = A*X - B;
dC = A * dX;

Gamma = -alpha*dC - beta*C;
end