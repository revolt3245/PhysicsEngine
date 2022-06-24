function [Q, dQ] = getDynamics(~, X, dX)
Q = dX;
dQ = zeros(size(X, 1), 1);
end