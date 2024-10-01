function [path, totalTime, totalDistance, encoders, R, H, times] = runRealNeato(IPAddress, dx, dy, initialPosition, xPlot, yPlot)

    neatov2.connect(IPAddress);
    
    % set initial parameters
    r = initialPosition; % initial position
    lambda = 0.05;  
    delta = 1;
    n = 1;
    n_max = 100;
    tolerance = 0.05;
    limit = 3;
    d = 0.245;
    vn = 0.03;
    
    % get initial gradient
    grad_r = [dx(find(xPlot==r(1), 1)); dy(find(yPlot==r(2), 1))];
    R = r;

    % store headings
    H = 0;
    
    % Main loop for gradient ascent
    while (n < n_max && norm(grad_r) > tolerance && norm(grad_r) < limit)    
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

        n = n + 1;
    end
    
    tic;
    encoders = zeros(0,3);
    times = [0 0];

    for i = 1:n-1

        % current and next position
        current_position = R(:, i);
        next_position = R(:, i + 1);

        % drive time
        drive_time = norm(next_position - current_position) / vn;

        % current and next heading
        current_heading = H(i);
        next_heading = H(i + 1);
    
        % turn time
        turn_time = (next_heading - current_heading) * d / (2 * vn);

        % drive neato
        elapsed = toc;
        neatov2.driveFor(drive_time, vn, vn);
        sensors = neatov2.receive();
        encoders(end+1,:) = [elapsed, sensors.encoders(1), sensors.encoders(2)];
        pause(0.01);

        times = [times; drive_time turn_time];
        % turn neato
        elapsed = toc;
        if turn_time >= 0
            neatov2.driveFor(turn_time, -vn, vn);
        else
            neatov2.driveFor(abs(turn_time), vn, -vn);
        end
        sensors = neatov2.receive();
        encoders(end+1,:) = [elapsed, sensors.encoders(1), sensors.encoders(2)];
        pause(0.01);
    end
    totalTime = encoders(end,1);

    totalDistance = 0;
    x = initialPosition(1);
    y = initialPosition(2);
    theta = 0;
    path = zeros(3, size(encoders,1));
    path(:,1) = [x y theta];
    encoderDiffs = diff(encoders);
    for i=1:size(encoderDiffs,1)
        XL = encoderDiffs(i,2);
        XR = encoderDiffs(i,3);
        XN = (XL + XR)/2;
        totalDistance = totalDistance + XN;
        deltaTheta = (XR - XL)/d;
        x = x + cos(theta)*XN;
        y = y + sin(theta)*XN;
        theta = theta + deltaTheta;
        path(:,i+1) = [x y theta];
    end
end