function [R, H] = runSimulator(dx, dy, initialPosition, xPlot, yPlot, z)

    neatov2.connect();

    % set initial parameters
    r = initialPosition; % start position
    lambda = 0.05;  
    delta = 1;
    n = 0;
    n_max = 100;
    tolerance = 0.05;
    limit = 3;
    
    % get initial gradient
    grad_r = [dx(find(xPlot==r(1), 1)); dy(find(yPlot==r(2), 1))];
    R = r;
    
    % store headings
    H = 0;
    
    % set neato initial position and orientation
    neatov2.setPositionAndOrientation(r(1), r(2), atan2(grad_r(2), grad_r(1)));

    % Main loop for gradient ascent
    while (n < n_max && norm(grad_r) > tolerance && norm(grad_r) < limit)
    
        % Move the Neato along the gradient ascent path
        neatov2.driveFor(1, 0.05, 0.05, true);
        pause(1);

        % Update Neato's position and orientation
        [~, xMinIdx] = min(abs(xPlot(1,:)-r(1)));
        [~, yMinIdx] = min(abs(yPlot(:,1)-r(2)));
        grad_r = [dx(yMinIdx, xMinIdx); dy(yMinIdx, xMinIdx)];
        r = r - lambda * grad_r;
        lambda = delta * lambda;
        R = [R r];  
    
        % Calculate new orientation 
        heading = pi + atan2(grad_r(2), grad_r(1));
        H = [H heading];
        
        % Set Neato position and orientation
        neatov2.setPositionAndOrientation(r(1), r(2), heading);

        n = n + 1;

        % Set contour plot
        neatov2.setFlatlandContours(xPlot, yPlot, z);
        xlim([-0.5 1.7]);
        ylim([-0.5 2]);
        xlabel('x distance (m)');
        ylabel('y distance (m)');
        title('Neato Path');
        grid on;
        axis equal;
        
    end
end