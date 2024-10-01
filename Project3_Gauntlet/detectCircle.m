function [circle] = detectCircle(x, y)
    % Convert the input x and y arrays into points
    points = [x y];
    
    % Initialize variables to store the best circle parameters and inliers
    bestCircle = [];
    bestInliers = 0;
    circle = [];
    
    % Parameters for the circle fitting
    minPoints = 6; % Minimum number of points to fit a circle
    radiusThreshold = 0.0007; % Threshold for the radius comparison
    expectedRadius = 0.099;
    
    % Iterate through consecutive points to fit circles
    for i = 1:(length(x) - minPoints + 1)
        % Select three consecutive points
        pointsSubset = points(i:i+minPoints-1, :);
        
        % Fit a circle using linear regression
        % Linear regression to find circle parameters
        xp = pointsSubset(:, 1);
        yp = pointsSubset(:, 2);
        A = [xp, yp, ones(size(xp))];
        b = -xp.^2 - yp.^2;
        params = pinv(A) * b;
        xc = -params(1) / 2;
        yc = -params(2) / 2;
    
        % Calculate radius
        r = sqrt((xc - pointsSubset(1, 1))^2 + (yc - pointsSubset(1, 2))^2);
    
        if (abs(r - expectedRadius) < radiusThreshold)
    
            % Calculate distances of each point from the circle edge
            distances = abs(sqrt((points(:, 1) - xc).^2 + (points(:, 2) - yc).^2) - r);
        
            % Count inliers
            inliers = sum(distances < radiusThreshold);
    
            % Check if the current circle has more inliers than the best one
            if inliers > bestInliers
                bestCircle = [xc, yc, r];
                bestInliers = inliers;    
                circle = [xc, yc];
            end
        end
    end
end