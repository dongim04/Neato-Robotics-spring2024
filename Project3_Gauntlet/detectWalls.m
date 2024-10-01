function [walls] = detectWalls(x, y)

    % Define thresholds for detecting walls
    xThreshold = 0.01; % Adjust as needed for detecting vertical lines
    yThreshold = 0.027; % Adjust as needed for detecting horizontal lines
    xminConsecutivePoints = 16; % Minimum consecutive points to identify a wall
    yminConsecutivePoints = 20; % Minimum consecutive points to identify a wall
    
    % Initialize variables to store wall segments
    verticalWalls = [];
    horizontalWalls = [];
    xminInliers = 21;
    yminInliers = 52;
    
    % Iterate over the points to detect vertical walls
    for i = 1:numel(x)-xminConsecutivePoints
        % Check if current point is within the threshold of the previous point in x-direction
        if all(abs(diff(x(i:i+xminConsecutivePoints))) < xThreshold)
            % Calculate distances of each point from the center
            xc = x(i);
            distances = abs(x - xc);
        
            % Count inliers
            inliers = y(distances < xThreshold);
            numInliers = sum(distances < xThreshold);
    
            if numInliers > xminInliers
                startPoint = find(y==min(inliers));
                endPoint = find(y==max(inliers));
    
                orderedInliers = sort(inliers);
    
                if any(diff(orderedInliers) > 0.5)
                    lineEndIdx = find(diff(orderedInliers) > 0.5, 1);
                    endPoint = find(y==orderedInliers(lineEndIdx));
                end
    
                % Add the wall segment to the list
                verticalWalls = [verticalWalls; x(startPoint), y(startPoint), x(endPoint), y(endPoint)];
            end
        end
    end
    
    % Iterate over the points to detect horizontal walls
    for i = 1:numel(y)-yminConsecutivePoints
        % Check if current point is within the threshold of the previous point in y-direction
        if all(abs(diff(y(i:i+yminConsecutivePoints))) < yThreshold)
            % Calculate distances of each point from the center
            yc = y(i);
            distances = abs(y - yc);
        
            % Count inliers
            inliers = x(distances < yThreshold);
            numInliers = sum(distances < yThreshold);
    
            if numInliers > yminInliers
                startPoint = find(x==min(inliers));
                endPoint = find(x==max(inliers));
    
                orderedInliers = sort(inliers);
    
                if any(diff(orderedInliers) > 0.5)
                    lineEndIdx = find(diff(orderedInliers) > 0.5, 1);
                    endPoint = find(x==orderedInliers(lineEndIdx));
                end
    
                % Add the wall segment to the list
                horizontalWalls = [horizontalWalls; x(startPoint), y(startPoint), x(endPoint), y(endPoint)];
            end
        end
    end
    walls = [verticalWalls; horizontalWalls];
end