function Gamma = getGamma(dx, C, G, H, Parameter)
%% get parameter
a = Parameter.a_hat/Parameter.dt;
b = Parameter.b_hat/Parameter.dt^2;

Gamma = -dx'*H*dx;
A = a * (G*dx);
B = b * C;

Gamma = Gamma - A - B;
end