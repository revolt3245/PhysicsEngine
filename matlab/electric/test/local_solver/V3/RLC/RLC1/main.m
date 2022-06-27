clear; clc; close;

%% parameter
Param = getParameter(alpha_gs = 0.3, n_iter = 1, dt = 1/6000);

%% initial_state
X = zeros(27, 1);
dX = ones(27, 1) * 1e-3;
dX(1) = 0;
%dX(1) = 1;

States = zeros(27, 6000);
ind = 0;

%% graphs
ax = gca; hold(ax, 'on'); grid(ax,'on');

h = plot(ax, [0], [0], LineWidth=2.0, Color=[1 0 0]);

VtA = @(t)[sin(2*pi*t) 2*pi*cos(2*pi*t) -4*pi^2*sin(2*pi*t)];
VtB = @(t)[sin(2*pi*t + 2*pi/3) 2*pi*cos(2*pi*t + 2*pi/3) -4*pi^2*sin(2*pi*t + 2*pi/3)];
VtC = @(t)[sin(2*pi*t - 2*pi/3) 2*pi*cos(2*pi*t - 2*pi/3) -4*pi^2*sin(2*pi*t - 2*pi/3)];

Rd = 1e-2;
%% circuit
circuit = [
    Elements.GND([1 2])

    Elements.V([1 3 2], Vt = VtA) % 8, 9
    Elements.V([1 4 2], Vt = VtB) % 10, 11
    Elements.V([1 5 2], Vt = VtC) % 12, 13

    Elements.D([1 6 3 14], Vd = 0, Rd = Rd) % 14, 15
    Elements.D([1 6 4 16], Vd = 0, Rd = Rd) % 16, 17
    Elements.D([1 6 5 18], Vd = 0, Rd = Rd) % 18, 19
    Elements.D([1 3 7 20], Vd = 0, Rd = Rd) % 20, 21
    Elements.D([1 4 7 22], Vd = 0, Rd = Rd) % 22, 23
    Elements.D([1 5 7 24], Vd = 0, Rd = Rd) % 24, 25

    Elements.R([1 7 6 26], R = 1) % 26, 27

    Elements.KCL([1 9 11 13]) % GND
    Elements.KCL([1 8 15 20]) % node 3
    Elements.KCL([1 10 17 22]) % node 4
    Elements.KCL([1 12 19 24]) % node 5
    Elements.KCL([1 14 16 18 27]) % node 6
    Elements.KCL([1 21 23 25 26]) % node 7

    Elements.KCL([1 8 9]) % VA
    Elements.KCL([1 10 11]) % VB
    Elements.KCL([1 12 13]) % VC
    Elements.KCL([1 14 15]) % D1
    Elements.KCL([1 16 17]) % D2
    Elements.KCL([1 18 19]) % D3
    Elements.KCL([1 20 21]) % D4
    Elements.KCL([1 22 23]) % D5
    Elements.KCL([1 24 25]) % D6
    Elements.KCL([1 26 27]) % R
    ];

size_c = size(circuit, 1);

while norm(dX) >= 1e-3
    [X, dX] = Solver.RungeKutta(@(x, dx, param)dynamics(circuit, x, dx, param), X, dX, Param);

    cond = [];

    for k = 1:size_c
        if class(circuit(k)) == "Elements.D"
            circuit(k) = circuit(k).changeCondition(X);

            cond = [cond circuit(k).cond];
        end
    end

    disp(cond);
    disp(norm(dX));
end

dX(1) = 1;
for i = 1:600
    for j = 1:100
        tic
        [X, dX] = Solver.RungeKutta(@(x, dx, param)dynamics(circuit, x, dx, param), X, dX, Param);
        toc
        ind = ind + 1;
        States(:, ind) = X;

        cond = logical(zeros(1,6));
        id = 1;
        for k = 1:size_c
            if class(circuit(k)) == "Elements.D"
                circuit(k) = circuit(k).changeCondition(X);
                cond(id) = circuit(k).cond;

                id = id + 1;
            end
        end
    end

    disp(X(4));
    h.XData = States(1,1:ind);
    h.YData = States(7,1:ind) - States(6,1:ind);

    drawnow;
end