function self = changeCondition(self, X)
S = X(self.mapping);

if self.cond
    self.cond = S(4) >= 0;
else
    self.cond = S(2) - S(3) >= self.Vd;
end
end