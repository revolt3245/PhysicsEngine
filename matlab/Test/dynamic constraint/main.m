clear; clc; close;

%% Parameter
Parameter = getParameters;

%% Init cond
x = [1 0 0 0 0 0]';

%% figure
fig = gcf;
fig.InnerPosition = [0 0 600 800];
ax = gca; hold(ax, 'on'); grid(ax, 'on'); axis(ax, 'equal');

ax.XLim = [-1.5 1.5];
ax.YLim = [-1.5 1.5];

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
        x = RungeKuttaWrapper(@(x)Dynamics(x, Parameter), x, dt);
    end
    disp(x);
    Shapes = UpdateDraw(Shapes, x, Parameter);
    frame = getframe(fig);
    writeVideo(video, frame);
    pause(0.017);
end

video.close;