function plotIntendedPath(walls, circle, trajectory, optimal)

    figure;
    hold on;
    
    % Plot the detected walls
    for i = 1:size(walls, 1)
        wall = walls(i, :);
        A = plot([wall(1), wall(3)], [wall(2), wall(4)], 'r', 'LineWidth', 1);
    end
    
    % Plot the detected circle
    r=0.099;
    theta = linspace(0,2*pi,100);
    B = plot(circle(1) + r*cos(theta), circle(2) + r*sin(theta),'b', 'LineWidth', 2);

    % Plot the trajectory of descent
    C = plot(trajectory(1,:), trajectory(2,:), 'm', 'LineWidth', 2);
    D = scatter(optimal(1), optimal(2), 'k', 'filled');
    
    xlabel('x distance (m)');
    ylabel('y distance (m)');
    title('Intended Path');
    grid on;
    axis equal;
    legend([A B C D], 'Detected Walls', 'Detected Circle', 'Intended path', 'Optimal point', Location='southeast');

    hold off;
end