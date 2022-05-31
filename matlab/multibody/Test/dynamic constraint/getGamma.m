function Gamma = getGamma(dx, C, G, H, Parameter)
%% alpha, beta
alpha = Parameter.alpha;
beta = Parameter.beta;

Gamma = -dx'*H*dx;
A = alpha * G*dx;
B = beta*C;

Gamma = Gamma - A - B;
end