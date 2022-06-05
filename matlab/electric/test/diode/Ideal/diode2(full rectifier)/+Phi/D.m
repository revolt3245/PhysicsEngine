function [C, G, H] = D(idx, X, cond, Param)
%{
X(1) : time

X(2) : VSource-
X(3) : VSource+
X(4) : VR+

X(5) : ISource
X(6-9) : ID1-4
X(10) : IR

cond = true --> V = 0;
cond = false --> I = 0;
%}

cond_each = cond(idx);
switch idx
    case 1
        [C, G, H] = D1(X, cond_each, Param);
    case 2
        [C, G, H] = D2(X, cond_each, Param);
    case 3
        [C, G, H] = D3(X, cond_each, Param);
    case 4
        [C, G, H] = D4(X, cond_each, Param);
    otherwise
        C = 0;
        G = zeros(1,10);
        H = zeros(10);
end
end

function [C, G, H] = D1(X, cond, Param)
Rd = Param.Rd;

if cond
    C = X(3) - X(4) - Rd * X(6);
    G = [0 0 1 -1 0 -Rd 0 0 0 0];
    H = zeros(10);
else
    C = X(6);
    G = [0 0 0 0 0 1 0 0 0 0];
    H = zeros(10);
end
end

function [C, G, H] = D2(X, cond, Param)
Rd = Param.Rd;

if cond
    C = X(2) - X(4) - Rd*X(7);
    G = [0 1 0 -1 0 0 -Rd 0 0 0];
    H = zeros(10);
else
    C = X(7);
    G = [0 0 0 0 0 0 1 0 0 0];
    H = zeros(10);
end
end

function [C, G, H] = D3(X, cond, Param)
Rd = Param.Rd;

if cond
    C = -X(3) - Rd*X(8);
    G = [0 0 -1 0 0 0 0 -Rd 0 0];
    H = zeros(10);
else
    C = X(8);
    G = [0 0 0 0 0 0 0 1 0 0];
    H = zeros(10);
end
end

function [C, G, H] = D4(X, cond, Param)
Rd = Param.Rd;

if cond
    C = -X(2) - Rd*X(9);
    G = [0 -1 0 0 0 0 0 0 -Rd 0];
    H = zeros(10);
else
    C = X(9);
    G = [0 0 0 0 0 0 0 0 1 0];
    H = zeros(10);
end
end