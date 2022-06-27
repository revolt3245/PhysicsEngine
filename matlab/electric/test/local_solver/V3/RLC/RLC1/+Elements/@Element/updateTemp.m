function self = updateTemp(self, Diff)
%% get gradient
Grad = self.Grad;

%% states
DiffS = Diff(self.mapping,:);

%% dynamics
Gamma = self.Gamma;
dQ = self.dQ;

AMA = Grad*Grad';

LQ = AMA\Grad;
LG = -1/AMA;

Q = dQ-DiffS;

self.lambda_temp = LQ*Q + LG*Gamma;
end