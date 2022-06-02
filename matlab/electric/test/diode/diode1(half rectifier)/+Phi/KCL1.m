function [C, G, H] = KCL1(X, Param)
%{
X(1) = t
X(2:3) = v1, v2;
X(4:6) = i1, i2, i3;
%}

C = X(4) - X(5);
G = [zeros(1,3) 1 -1 0];
H = zeros(6);
end