function [C, G, H] = Resistance(X, Param)
%% get parameter
R = Param.R;

%% Jacobian
C = X(1) - R * X(3);
G = [1 0 -R];
H = zeros(3,3);
end