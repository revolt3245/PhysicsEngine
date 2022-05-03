function [C, G, H] = Phi(x, Parameter)
l0 = Parameter.l0;

C = x(1)^2 + x(2)^2 - (x(3) + l0)^2;
G = 2 * [x(1) x(2) -(x(3)+l0)];
H = diag([2 2 -2]);
end