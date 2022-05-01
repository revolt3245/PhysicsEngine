clear; clc; close;

%% initial condition
x = [5 0]';
dt = 1e-3;

%% Parameter
m = 1;
e = sqrt(2*dt);

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
        x_next = RungeKuttaWrapper(@(x)dynamics(x, m = m, e = e, cond = cond, x_pre = x_pre), x, dt);
        
        cond = x_next(1) <= 0;
        
        if ~cond
            x_pre = x_next;
        end
        x = x_next;
    end
    h.YData = x(1);
    
    pause(0.01);
    disp(m*9.8*x(1) + m*x(2)^2/2);
end