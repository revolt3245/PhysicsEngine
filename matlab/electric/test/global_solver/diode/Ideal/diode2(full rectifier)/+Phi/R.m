function [C, G, H] = R(idx, X, Param)
%{
X(1) : time

X(2) : VSource-
X(3) : VSource+
X(4) : VR+

X(5) : ISource
X(6-9) : ID1-4
X(10) : IR
%}
%% parameter
R = Param.R(idx);

%% jacobian
if idx == 1
    C = X(4) - R*X(10);
    G = [0 0 0 1 0 0 0 0 0 -R];
    H = zeros(10);
else
    C = 0;
    G = zeros(1,10);
    H = zeros(10);
end
end