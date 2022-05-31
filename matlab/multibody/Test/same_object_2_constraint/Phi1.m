function [C, G, H] = Phi1(x, Parameter)
r = Parameter.r;
C = x(1)^2 + x(2)^2 - r^2;
G = 2*[x(1) x(2) 0];
H = diag([2 2 0]);
end