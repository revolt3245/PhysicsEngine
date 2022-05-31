function Shapes = Draw(ax, Parameters)
%% Param
l0 = Parameters.l0;

Shapes = plot(ax, [0 l0], zeros(1,2), LineWidth = 2.0, Color = [0 0 0]);
end