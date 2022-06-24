function self = updateTemp(self, Diff)
%% get gradient
Grad = self.Grad;

%% states
DiffS = Diff(self.mapping,:);

%% dynamics
Gamma = self.Gamma;
dQ = self.dQ;

M = eye(size(self.mapping,2));
AMA = Grad*Grad';

XQ = M - Grad'/AMA*Grad;
XG = Grad'/AMA;
LQ = AMA\Grad;
LG = -1/AMA;

Q = dQ-DiffS;

self.d2x_temp(1:end-1,:) = XQ*Q + XG*Gamma;
self.d2x_temp(end,:) = LQ*Q + LG*Gamma;
%Msys = [M Grad';Grad 0];
%Qsys = [dQ-DiffS; Gamma];

%self.d2x_temp = Msys\Qsys;
end