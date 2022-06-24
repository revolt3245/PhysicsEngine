function [C, G, H] = getPhi(self, X)
%% parameter
Vt = self.Vt;

V = Vt(X(1));

%% jacobian
C = X(2) - X(3) - V(1);
G = [-V(2) 1 -1];
H = zeros(3);
H(1,1) = V(3);
end