function Gamma = getGamma(dx, C, G, H, Parameter)
%% Export
alpha = Parameter.alpha;
beta = Parameter.beta;

%% Calculate
Ga = dx'*H*dx;
A = alpha*G*dx;
B = beta*C;

Gamma = - Ga - A - B;
end