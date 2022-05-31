function [C, G, H] = getPhi(x, Parameter)
%% Export
l = Parameter.l;

dx = x(1) - x(3);
dy = x(2) - x(4);

C = dx^2 + dy^2 - l^2;
G = 2 * [dx dy -dx -dy];
H = 2 * eye(4);
end