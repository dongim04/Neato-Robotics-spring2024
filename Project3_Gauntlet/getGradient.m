function [x, y, z, dx, dy] = getGradient(x_points, y_points, circle)

    [x,y] = meshgrid(-.5:.01:1.7, -0.5:.01:2);
    
    % Initialize z with zeros
    z = zeros(size(x));
    
    % Set the values at the indices corresponding to [x_points, y_points] as sources
    for i = 1:size(x_points, 2)
        % Find the index of the closest point in the meshgrid
        % Set the corresponding z value as the source value
        z = z - (log(sqrt((x-x_points(i)).^2 + (y-y_points(i)).^2)))/100;
    end
    
    %loop through angles from 0 to 2 pi
    radius=0.099;
    for theta = 0:0.1:2*pi
        % sources have coordinates (a,b)
        a = circle(1) + radius * cos(theta);
        b = circle(2) + radius * sin(theta);
        z = z + log(sqrt((x-a).^2 + (y-b).^2));
    end
    
    % Calculate the gradient of z
    [dx, dy] = gradient(z);
end