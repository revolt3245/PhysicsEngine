function [C, G, H] = KCL(idx, X, Param)
%{
X(1) : time

X(2) : VSource-
X(3) : VSource+
X(4) : VR+

X(5) : ISource
X(6-9) : ID1-4
X(10) : IR
%}

switch idx
    case 1
        C = -X(5) - X(7) + X(9);
        G = [0 0 0 0 -1 0 -1 0 1 0];
        H = zeros(10);
    case 2
        C = X(5) - X(6) + X(8);
        G = [0 0 0 0 1 -1 0 1 0 0];
        H = zeros(10);
    case 3
        C = X(6) + X(7) - X(10);
        G = [0 0 0 0 0 1 1 0 0 -1];
        H = zeros(10);
    otherwise
        C = 0;
        G = zeros(1,10);
        H = zeros(10);
end
end