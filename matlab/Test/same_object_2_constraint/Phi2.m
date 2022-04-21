function [C, G, H] = Phi2(x, Parameter)
C = x(1) * sin(x(3)) - x(2)*cos(x(3));
G = [sin(x(3)) -cos(x(3)) x(1)*cos(x(3))+x(2)*sin(x(3))];
H = [0 0 cos(x(3)); 0 0 sin(x(3)); cos(x(3)) sin(x(3)) -x(1)*sin(x(3))+x(2)*cos(x(3))];
end