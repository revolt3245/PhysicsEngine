clear; clc; close;

%% parameter
Param = getParameters(freq = 5, Vp = 2, dt = 1/6000, alpha_hat_eq = 3.46, beta_hat_eq = 3.78);

%% initial condition
X = zeros(12, 1);
X(7) = 1;
%X(8) = 2*pi*Param.freq * Param.Vp;
%X(9) = 2*pi*Param.freq;
%X(10) = 2*pi*Param.freq;
%X(11) = 2*pi*Param.freq;
%X(12) = 2*pi*Param.freq;

cond = false;

States = zeros(6000, 12);

idx = 1;

%% graph
ax = gca; hold(ax, 'on'); grid(ax, 'on');

h = plot(ax, [0], [0], LineWidth = 2.0, Color = [1 0 0]);

for i=1:60
    for j=1:100
        X = Solver.RungeKutta(@(x, Param)dynamics(x, cond, Param), X, Param, Param.dt);

        States(idx,:) = X;
        idx = idx + 1;
        
        cond = Cond.getCondition(X, cond, Param);
    end
    h.XData = States(1:idx-1,1);
    h.YData = States(1:idx-1,3);

    drawnow;
    disp(X);
end