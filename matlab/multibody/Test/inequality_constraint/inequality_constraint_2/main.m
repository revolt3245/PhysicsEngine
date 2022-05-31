clear; clc; close;

%% Parameter
Param = getParameter(b = 0, mu = 0.1, e = 0.1);

%% initial condition
x = [0 10 4 0]';
cond = false;

%% figure
fig = gcf;
ax = gca; hold(ax, 'on'); grid(ax, 'on'); axis(ax, 'equal');

ax.XLim = [-2.1, 42.1];
ax.YLim = [-0.1, 12.1];

Shapes = draw_init(ax, Param);

%% Video setting
FPS = 60;
resolution = 100;
second = 10;

totalFrame = FPS * second;

dt = 1/FPS/resolution;

filename = "Constraint Dynamics";

video = VideoWriter(filename + ".mp4", 'MPEG-4');
video.FrameRate = FPS;
video.Quality = 100;

video.open;

for i=1:totalFrame
    for j=1:resolution
        x_next = RungeKuttaWrapper(@(x)dynamics(x, Param, cond), x, dt);

        [dx_next, cond] = collision(x_next(1:2,:), x_next(3:4, :), Param);
        x = x_next;
        x(3:4,:) = dx_next;
    end

    Shapes = draw_update(Shapes, x, Param);

    frame = getframe(fig);
    writeVideo(video, frame);
    pause(0.017);

    disp(getEnergy(x, Param));
end
video.close;

function E = getEnergy(x, Param)
m = Param.m;
g = Param.g;

E = m*g*x(2) + m*(x(3)^2 + x(4)^2)/2;
end