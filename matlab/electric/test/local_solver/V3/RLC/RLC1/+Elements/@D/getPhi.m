function [C, G, H] = getPhi(self, X)
%% parameter
Vd = self.Vd;
Rd = self.Rd;
cond = self.cond;

if cond
    C = X(2) - X(3) - Vd - Rd*X(4);
    G = [0 1 -1 -Rd];
    H = zeros(4);
else
    C = X(4);
    G = [0 0 0 1];
    H = zeros(4);
end
end