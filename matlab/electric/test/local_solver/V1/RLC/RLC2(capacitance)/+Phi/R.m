function [C, G, H] = R(X, mapping, Param)
%{
mapping
1 - V+
2 - V-
3 - I+
%}
%% parameter
R = Param.R;

%% state
state = X(mapping);

%% jacobian
C = state(1) - state(2) - R*state(3);
G = [1 -1 -R];
H = zeros(3);
end