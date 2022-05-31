function [C, G, T] = getPhi(x, Param)
r = Param.r;

C = x(2,:) - r;
G = [0 1];
T = [1 0];
end