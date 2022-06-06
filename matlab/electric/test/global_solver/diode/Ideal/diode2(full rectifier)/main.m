clear; clc; close;

%% parameters
Param = getParameters(freq = 1, iter = 20, alpha_gd = 0.9);

%% initial condition
X = zeros(20,1);
X(11) = 1;

cond = logical(zeros(1,4));

States = zeros(20, 6000);

idx = 1;

%% plot
ax = gca; hold(ax, 'on'); grid(ax, 'on');

h = plot(ax, 0, 0, LineWidth=2.0, Color=[1 0 0]);

%% solve
for i = 1:60
    for frame = 1:100
        X = Solver.RungeKutta(@(x, Param)dynamics(x, cond, Param), X, Param, Param.dt);

        States(:, idx) = X;
        idx = idx + 1;

        cond = Cond.getCondition(X, cond, Param);
    end

    h.XData = States(1,1:idx-1);
    h.YData = States(4,1:idx-1);

    disp(X(4));

    drawnow;
end