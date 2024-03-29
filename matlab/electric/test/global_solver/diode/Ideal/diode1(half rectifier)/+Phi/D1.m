function [C, G, H] = D1(X, cond, Param)
%{
X(1) = t
X(2:3) = v1, v2;
X(4:6) = i1, i2, i3;

cond == false --> i = 0;
cond == true --> V = 0;
%}
%% parameter
Rd = Param.Rd;

if cond
    C = X(2) - X(3) - Rd*X(5);
    G = [0 1 -1 0 -Rd 0];
    H = zeros(6);
else
    C = X(5);
    G = [0 0 0 0 1 0];
    H = zeros(6);
end
end