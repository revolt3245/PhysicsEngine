clear; clc; close;

%% param
Param = Solver.getParameters(size_A = 50);

%% initial condition
X = ones(Param.size_A*2, 1) * 0.1;

%% graphics
ax = gca; hold(ax, 'on'); grid(ax, 'on');
ax.YLim = [0 0.15];

plot(lsqminnorm(Param.A, Param.B), LineWidth=2.0, Color = [0 0 1]);

h = plot(X(1:Param.size_A), LineWidth = 2.0, Color = [1 0 0]);
drawnow;

for i = 1:60
    for j=1:100
        tic
        X = Solver.RungeKutta(@dynamics, X, Param);
        toc
    end

    h.YData = X(1:Param.size_A);
    drawnow;
end