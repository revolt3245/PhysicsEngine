function [Q, dQ] = getDynamics(~, ~, dX)
dQ = zeros(3,1);
Q = dX;
end