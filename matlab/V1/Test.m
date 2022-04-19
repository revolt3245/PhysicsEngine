clear; clc; close;

x = [1 1 0 0]';

ax = gca;hold(ax, 'on'); grid(ax, 'on'); axis(ax, 'equal');

ax.XLim = [-1.5 1.5];
ax.YLim = [-0.5 2.5];

t = -1.5:0.01:1.5;
Constraint = plot(ax, t, t.^2, 'Color', [0 0 0]);
p = scatter(ax, x(1), x(2));

for i=1:1800
    for j=1:100
        x = RungeKuttaWrapper(@(x)ConstrainedDynamics(x), x, 1/6000);
    end
    p.XData = x(1);
    p.YData = x(2);
    
    Energy = (x(3)^2 + x(4)^2)/2 + 9.8*x(2);
    disp(Energy);
    
    pause(0.017);
end