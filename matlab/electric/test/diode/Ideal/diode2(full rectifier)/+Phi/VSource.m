function [C, G, H] = VSource(idx, X, Param)
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
Vp = Param.Vp(idx);
freq = Param.freq(idx);

omega = 2*pi*freq;

Vpsin = Vp*sin(omega*X(1));
Vpcos = Vp*cos(omega*X(1));

if idx == 1
    %% jacobian
    C = X(3)-X(2)-Vpsin;
    G = [-omega*Vpcos -1 1 zeros(1,7)];
    H = zeros(10);
    H(1,1) = omega^2*Vpsin;
else
    C = 0;
    G = zeros(1,10);
    H = zeros(10);
end
end