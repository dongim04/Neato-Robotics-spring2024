function plotPotentialFields(xPlot, yPlot, z)

    % Plot the contour
    figure;
    contour(xPlot,yPlot,z);
    xlabel('x distance (m)');
    ylabel('y distance (m)');
    title('Contour of Potential Field');
    colorbar;
    grid on;
    axis equal;

    % Plot the 3D surface
    figure;
    surf(xPlot, yPlot, z);
    shading interp;
    xlabel('x distance (m)');
    ylabel('y distance (m)');
    zlabel('z potential');
    title('3D Plot of Potential Field');
    colorbar;
end