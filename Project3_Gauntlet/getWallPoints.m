function [x_points, y_points] = getWallPoints(walls)

    % Define the desired distance between points
    desired_distance = 0.01; % For example, 1 unit
    
    % Initialize arrays to store the points
    x_points = [];
    y_points = [];
    
    % Loop through each row of the walls matrix
    for i = 1:size(walls, 1)
        % Extract endpoints of the current line segment
        x1 = walls(i, 1);
        y1 = walls(i, 2);
        x2 = walls(i, 3);
        y2 = walls(i, 4);
        
        % Calculate the total length of the line segment
        total_length = sqrt((x2 - x1)^2 + (y2 - y1)^2);
        
        % Calculate the number of points needed
        num_points = ceil(total_length / desired_distance);
        
        % Generate equally spaced points between the endpoints
        x_segment = linspace(x1, x2, num_points);
        y_segment = linspace(y1, y2, num_points);
        
        % Append the points of the current segment to the arrays
        x_points = [x_points, x_segment];
        y_points = [y_points, y_segment];
    end
end