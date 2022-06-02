function cond_next = getCondition(X, cond_pre, Param)
%{
X(1) = t
X(2:3) = v1, v2;
X(4:6) = i1, i2, i3;

cond == false --> i = 0;
cond == true --> V = 0;
%}

if cond_pre
    cond_next = X(5) >= 0;
else
    cond_next = X(2) - X(3) >= 0;
end
end