function Shapes = UpdateDraw(Shapes, x, Parameter)
%% parameter
l = Parameter.l;
r = Parameter.r;

R = [cos(x(3)) -sin(x(3)); sin(x(3)) cos(x(3))];
%% line
l1 = r - l/2;
X1 = [0 l1; 0 0];
X1 = R*X1;

Shapes(1).XData = X1(1,:);
Shapes(1).YData = X1(2,:);

%% object
r2 = l/2;
X2 = r2*[1 1 -1 -1 1; 1 -1 -1 1 1];
X2 = [X2; ones(1,5)];

X2 = [R x(1:2,:); 0 0 1] * X2;

Shapes(2).XData = X2(1,:);
Shapes(2).YData = X2(2,:);
end