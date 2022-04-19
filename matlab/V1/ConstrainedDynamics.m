function dx = ConstrainedDynamics(x)
%{
x = [x1 x2 \dot{x1} \dot{x2}]^{T}

constraint = y = x^2
%}

m = 1;
g = 9.8;
M = [m 0 -2*x(1); 0 m 1; -2*x(1) 1 0];
G = [0; -m*g];

a_hat = 3.46;
b_hat = 3.78;
%a_hat = 0.1;
%b_hat = 0.0102;
%a_hat = 5.5;
%b_hat = 8.1;
%a_hat = 0;
%b_hat = 0;
step = 1/6000;

a = a_hat/step;
b = b_hat/(step^2);

Gamma = 2*x(3)^2 - a * (-2*x(1)*x(3) + x(4)) - b * (x(2)-x(1)^2);

A = M\[G;Gamma];

dx(1:2) = x(3:4);
dx(3:4) = A(1:2);

dx = reshape(dx, 4,1);
end