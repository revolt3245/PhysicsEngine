function dx = ConstrainedDynamics2(x)
%{
x = [x y phi dx dy dphi];
%}

m = 1;
g = 9.8;
r = 0.5;
I = m*r^2/12;
% best
a_hat = 3.46;
b_hat = 3.78;
step = 1/6000;

a = a_hat/step;
b = b_hat/(step^2);

pos = x(1:3);
dpos = x(4:6);
Const = PinpointConstraint([0 0], 1);
C = Const.constraintVector(pos);
J = Const.jacobianMatrix(pos);
H = Const.hessianTensor(pos);

M = diag([m m I]);

Sys = [M J'; J zeros(size(J, 1))];
Q = [0-dpos(1) -m*g-dpos(2) 0]';

Gamma = reshape(pagemtimes(pagemtimes(dpos',H),dpos),2,1);

Gamma = Gamma - a * J * dpos - b * C;
A = Sys\[Q;Gamma];

dx(1:3) = x(4:6);
dx(4:6) = A(1:3);

dx = reshape(dx, 6,1);