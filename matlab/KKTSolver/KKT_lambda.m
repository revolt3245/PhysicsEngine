function lambda = KKT_lambda(AMi, AMA, Q, R)
%{
Mi = inv(M);

AMi = A/Mi;
AMA = AMi*A';
%}

LQ = AMi/AMA;
LR = -1/AMA;

lambda = LQ*Q + LR*R;
end