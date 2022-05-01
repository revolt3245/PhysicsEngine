clear; clc; close;

%% Parameter
Parameter = getParameter(b = 0.3, r = 2);

%% initial states
x = [2 0 0 0 0 0]';

%% figure
fig = gcf;
fig.InnerPosition = [0 0 600 800];
ax = gca; hold(ax, 'on'); grid(ax, 'on'); axis(ax, 'equal');

ax.XLim = [-3 3];
ax.YLim = [-3 3];

Shapes = Draw(ax, Parameter);

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

%% Simulation
for i=1:totalFrame
    for j=1:resolution
        x = RungeKuttaWrapper(@(x)dynamics(x, Parameter), x, dt);
    end
    disp(x);
    Shapes = UpdateDraw(Shapes, x, Parameter);
    frame = getframe(fig);
    writeVideo(video, frame);
    pause(0.017);
end

video.close;