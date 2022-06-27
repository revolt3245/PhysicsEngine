function [C, G, H] = KCL(X, mapping, Param)
%% state
state = X(mapping);

C = sum(state);
G = ones(1, size(state, 1));
H = zeros(size(state, 1));
end