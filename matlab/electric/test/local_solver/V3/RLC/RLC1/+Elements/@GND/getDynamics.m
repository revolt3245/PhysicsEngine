function [Q, dQ] = getDynamics(~, ~, dX)
Q = dX;
dQ = zeros(2, 1);
end