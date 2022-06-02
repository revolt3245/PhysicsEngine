function [C, G, H] = KCL(X, Param)
C = X(2) - X(3);
G = [0 1 -1];
H = zeros(3,3);
end