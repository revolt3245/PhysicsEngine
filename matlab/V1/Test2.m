clear; clc; close;

x = [1 0 0 0 0 0]';

figure(1);
ax = gca;hold(ax, 'on'); grid(ax, 'on'); axis(ax, 'equal');

ax.XLim = [-1.5 1.5];
ax.YLim = [-1.5 1.5];

box = [-0.25 -0.25 0.25 0.25 -0.25; -0.25 0.25 0.25 -0.25 -0.25; ones(1,5)];

p_box = [cos(x(3)) -sin(x(3)) 0; sin(x(3)) cos(x(3)) 0; 0 0 1] * box;
p_box = [eye(2) x(1:2,1);zeros(1,2) 1] * p_box;
B = plot(ax, p_box(1,:), p_box(2,:), 'Color', [0 0 1], 'LineWidth', 1.5);

line = [zeros(2,1) x(1:2,1)];
L = plot(ax, line(1,:), line(2,:), 'Color', [0 0 0], 'LineWidth', 1.5);

figure(2);
ax2 = gca; hold(ax2, 'on'); grid(ax2, 'on');
ax2.YLim = [-10 1];
ax2.XLim = [0 3];

G = 0;
T = 0;

H = plot(ax2, T, G, 'Color', [1 0 0], 'LineWidth', 1.5);

for i=1:1800
    for j=1:100
        x = RungeKuttaWrapper(@(x)ConstrainedDynamics2(x), x, 1/6000);
    end
    
    p_box = [cos(x(3)) -sin(x(3)) 0; sin(x(3)) cos(x(3)) 0; 0 0 1] * box;
    p_box = [eye(2) x(1:2,1);zeros(1,2) 1] * p_box;
    B.XData = p_box(1,:);
    B.YData = p_box(2,:);
    
    line(:,2) = x(1:2,1);
    L.XData = line(1,:);
    L.YData = line(2,:);
    
    Energy = (x(4)^2 + x(5)^2)/2 + x(2)*9.8 + x(6)^2*0.5^2/24;
    G = [G Energy];
    T = [T T(end)+1/60];
    
    if size(T, 2) >= 180
        G = G(end-179:end);
        T = T(end-179:end);
        ax2.XLim = [T(1) T(end)];
    end
    H.XData = T;
    H.YData = G;
    pause(0.017);
end