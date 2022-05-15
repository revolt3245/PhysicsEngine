clear; clc; close;

%% initial condition
x = [10 0]';
dt = 1e-3;

%% Parameter
m = 1;
e = 1;

dPhi_pre = 0;
x_pre = x;
cond = false;

%% animation
ax = gca; hold(ax, 'on'); grid(ax, 'on'); axis(ax, 'equal');

ax.XLim = [-0.5, 0.5];
ax.YLim = [-0.1, 10.1];

h = scatter(ax, 0, x(1), 20, MarkerFaceColor = [1 0 0], MarkerEdgeColor = [1 0 0]);

for i=1:5000
    for j=1:10
        x_next = RungeKuttaWrapper(@(x)dynamics(x, m = m, cond = cond), x, dt);
        
        cond = x_next(1) <= 0 && x_next(2) <= 0;
        if cond
            %x(1) = 0;
            %x(2) = -e * (x(2)*x_next(1) - x_next(2)*x(1))/(x_next(1) - x(1));
            x(2) = -e * x_next(2);
            x(1) = x_next(1);
            %x(2) = -e * x(2);
        else
            x = x_next;
        end
    end
    h.YData = x(1);
    
    pause(0.01);
    disp(m*9.8*x(1) + m*x(2)^2/2);
end