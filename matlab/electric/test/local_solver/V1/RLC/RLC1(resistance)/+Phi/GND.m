function [C, G, H] = GND(X, mapping, Param)
%% state
state = X(mapping);

C = X(1);
G = 1;
H = 0;
end