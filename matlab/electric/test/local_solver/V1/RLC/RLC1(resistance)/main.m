clear; clc; close;

%% phis
Phis(1) = Dynamics.getPhi_mapping(Phi = @Phi.V, mapping = [1 2]);
Phis(2) = Dynamics.getPhi_mapping(Phi = @Phi.R, mapping = [2 1 5]);
Phis(3) = Dynamics.getPhi_mapping(Phi = @Phi.KCL, mapping = [3 4]);
Phis(4) = Dynamics.getPhi_mapping(Phi = @Phi.KCL, mapping = [4 5]);
Phis(5) = Dynamics.getPhi_mapping(Phi = @Phi.KCL, mapping = [5 6]);
Phis(6) = Dynamics.getPhi_mapping(Phi = @Phi.GND, mapping = [1]);

%% parameters
Param = Solver.getParameters(Phi_mapping = Phis, alpha_gs = 0.5, iteration = 10);

%% graph
ax = gca; hold(ax, 'on'); grid(ax, 'on');

h = plot(ax, [0], [0], LineWidth=2.0, Color=[1 0 0]);

%% initial condition
x = zeros(12,1);

States = zeros(12, 6000);
Time = (0:5999)/6000;

ind = 1;

for i = 1:60
    for j = 1:100
        x = Solver.RungeKutta(@dynamics, x, Param);
        States(:,ind) = x;
        ind = ind + 1;
    end

    h.XData = Time(1:ind-1);
    h.YData = States(2,1:ind-1);

    drawnow;
end