function [C, G, H] = VSource(X, Param)
%{
X(1) = t
X(2:3) = v1, v2;
X(4:6) = i1, i2, i3;
%}

%% Param
Vp = Param.Vp;
freq = Param.freq;

omega = 2*pi*freq;
%% jacobian
C = X(2) - Vp*sin(omega*X(1));
G = [-omega*Vp*cos(omega*X(1)) 1 zeros(1,4)];
H = zeros(6);
H(1,1) = omega^2*Vp*sin(omega*X(1));
end