function Shapes = draw_init(ax, Param)
r = Param.r;

theta = 0:200;
theta = theta * pi/100;

X = r * cos(theta);
Y = r * sin(theta);
Shapes = plot(ax, X, Y, LineWidth=2.0, Color=[0 0 0]);
end