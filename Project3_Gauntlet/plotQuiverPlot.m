function plotQuiverPlot(xPlot, yPlot, dx, dy)
    figure;
    space = 45;
    quiver(xPlot(1:space:end), yPlot(1:space:end), dx(1:space:end), dy(1:space:end), 3.5);
    xlabel('x distance (m)');
    ylabel('y distance (m)');
    title('Gradient Vector Field');
    grid on;
    axis equal;
end