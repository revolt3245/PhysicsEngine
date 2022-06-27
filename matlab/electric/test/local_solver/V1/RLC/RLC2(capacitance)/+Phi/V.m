function [C, G, H] = V(X, mapping, Param)
%% Parameter
Vdc = Param.Vdc;

%%
state = X(mapping);

C = state(2) - state(1) - Vdc;
G = [-1 1];
H = zeros(2);
end