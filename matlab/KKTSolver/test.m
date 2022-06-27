clear; clc; close;

M = diag([1 1 1 1 1 1 1 1]);
A = [1 2 3 4 5 6 7 8];
Q = zeros(8,1);
R = 1;

tic
[Mi, AMi, AMA] = KKT_Sys(M, A);

lambda = KKT_lambda(AMi, AMA, Q, R);
x = KKT_x(Mi, AMi, AMA, Q, R);
toc