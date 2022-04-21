function Shapes = Draw(ax, Parameter)
%% parameter
r = Parameter.r;
l = Parameter.l;

%% line
l1 = r - l/2;
X1 = [0 l1; 0 0];

Shapes(1) = plot(ax, X1(1,:), X1(2,:), 'LineWidth', 2.0, 'Color', [0 0 0]);

%% object
r2 = l/2;
X2 = r2*[1 1 -1 -1 1; 1 -1 -1 1 1];
X2 = [X2; ones(1,5)];

X2 = [eye(2) [r 0]'; 0 0 1] * X2;

Shapes(2) = plot(ax, X2(1,:), X2(2,:), 'LineWidth', 2.0, 'Color', [0 0 0]);
end