function [C, G, H] = D1(X, Param)
%{
X(1) = t
X(2:3) = v1, v2;
X(4:6) = i1, i2, i3;

cond == false --> i = 0;
cond == true --> V = 0;
%}
%% parameter
VT = Param.VT;
Is = Param.Is;

VD = X(2) - X(3);

%% jacobian
C = X(5) - Is * (exp(VD/VT) - 1);
G = [0 -Is/VT*exp(VD/VT) Is/VT*exp(VD/VT) 0 1 0];
H = zeros(6);

H(2,2) = -Is/VT^2*exp(VD/VT);
H(2,3) = Is/VT^2*exp(VD/VT);
H(3,2) = H(2,3);
H(3,3) = H(2,2);
end