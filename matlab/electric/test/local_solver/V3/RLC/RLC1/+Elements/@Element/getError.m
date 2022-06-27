function e = getError(self, Diff)
DiffS = Diff(self.mapping,:);

Grad = self.Grad;

%% get d2x
M = eye(size(self.mapping,2));
AMA = Grad*Grad';

XQ = M - Grad'/AMA*Grad;
XG = Grad'/AMA;

Q = self.dQ - DiffS;
Gamma = self.Gamma;

d2x = XQ * Q + XG * Gamma;

%% error
e = d2x + DiffS;
end