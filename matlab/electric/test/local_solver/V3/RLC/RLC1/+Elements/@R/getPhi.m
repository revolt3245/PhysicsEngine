function [C, G, H] = getPhi(self, X)
%% parameter
R0 = self.R0;

%C = X(2) - X(3) - R0*X(4);
G = [0 1 -1 -R0];
C = G * X;
H = zeros(4);
end