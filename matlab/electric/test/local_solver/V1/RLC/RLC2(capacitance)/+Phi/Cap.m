function [C, G, H] = Cap(X, mapping, Param)
%{
mapping(1) - V+
mapping(2) - V-
mapping(3) - I+
mapping(4) - Vc(hidden)
%}
%% parameter
C1 = Param.C1;

%% state
state = X(mapping);

%% jacobian
C = state(1) - state(2) - state(4);
G = [1 -1 0 -1];
H = zeros(4);
end