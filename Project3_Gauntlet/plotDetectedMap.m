function plotDetectedMap(x, y, walls, circle)
    % Plot the Lidar points
    figure;
    A = scatter(x, y, 'c', 'filled');
    hold on;
    
    % Plot the detected walls
    for i = 1:size(walls, 1)
        wall = walls(i, :);
        B = plot([wall(1), wall(3)], [wall(2), wall(4)], 'r', 'LineWidth', 2);
    end
    
    % Plot the detected circle
    r=0.099;
    theta = linspace(0,2*pi,100);
    C = plot(circle(1) + r*cos(theta), circle(2) + r*sin(theta),'b', 'LineWidth', 2);
    
    % Set plot properties
    xlabel('x distance (m)');
    ylabel('y distance (m)');
    title('Detected Circle and Walls');
    grid on;
    axis equal;
    legend([A B C], 'Lidar Points', 'Detected Walls', 'Detected Circle', Location='southeast');
    hold off;
end