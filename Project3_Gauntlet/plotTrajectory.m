function plotTrajectory(trajectory, optimal, xPlot, yPlot, z)

    % Plot the function contours
    figure;
    contour(xPlot, yPlot, z);
    hold on;
    
    % Plot the trajectory of descent
    plot(trajectory(1,:), trajectory(2,:), 'r', 'LineWidth', 2);
    scatter(optimal(1), optimal(2), 'k', 'filled');
    hold off;
    
    xlabel('x distance (m)');
    ylabel('y distance (m)');
    title('Gradient Descent Trajectory on Contour Plot');
    legend('Function Contours', 'Descent trajectory', 'Optimal point');
    colorbar;
    grid on;
    axis equal;
end