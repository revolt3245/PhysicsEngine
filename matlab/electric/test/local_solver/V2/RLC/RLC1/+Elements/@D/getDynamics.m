function [Q, dQ] = getDynamics(~, ~, dX)
Q = dX;
dQ = zeros(4, 1);
end