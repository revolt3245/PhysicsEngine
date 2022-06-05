function cond_out = getCondition(X, cond_pre, Param)
%{
X(1) : time

X(2) : VSource-
X(3) : VSource+
X(4) : VR+

X(5) : ISource
X(6-9) : ID1-4
X(10) : IR

cond = true --> V = 0;
cond = false --> I = 0;

D1 : VSource+, VR+;
D2 : VSource-, VR-;
D3 : GND, VSource+;
D4 : GND, VSource-;
%}
VD = [X(3)-X(4) X(2)-X(4) -X(3) -X(2)];
cond_out = cond_pre;

for i=1:4
    cond_out(i) = getSingleCond(VD(i), X(5+i), cond_pre(i), Param);
end
end

function cond_out = getSingleCond(Vd, Id, cond_pre, Param)
if cond_pre
    cond_out = Id >= 0;
else
    cond_out = Vd >= 0;
end
end