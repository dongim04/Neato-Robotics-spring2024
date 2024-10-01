function plotGauntletMap(data)
    load(data,'angles','positions','scans');
    allPlots = figure;
    title('LIDAR Map of the Gauntlet');
    xlabel('x distance (m)');
    ylabel('y distance (m)');
    colors = ['r', 'g', 'b', 'm'];
    axis equal;
    grid on;
    for i=1:size(positions,1)
        th = deg2rad(angles(i));
        RobotToGlobal = [cos(th) -sin(th) positions(i,1);
                         sin(th) cos(th) positions(i,2);
                         0 0 1];
        % the scanner is located about 8cm behind the center of rotation of
        % the robot
        ScannerToRobot = [1 0 -0.082;
                          0 1 0;
                          0 0 1];

        ScannerToGlobal = RobotToGlobal * ScannerToRobot;
        ranges = scans{i}.ranges;
        thetasInRadians = scans{i}.thetasInRadians;
        cart = [cos(thetasInRadians);
                sin(thetasInRadians)].*[ranges; ranges];
        cartHomogeneous = [cart; ones(1, size(cart,2))];
        cleaned = cartHomogeneous(:, ranges~=0);
        globalCleaned = ScannerToGlobal*cleaned;
        figure(allPlots);
        hold on;
        scatter(globalCleaned(1,:), globalCleaned(2,:), colors(i));
    end
    legend("Scan 1", "Scan 2", "Scan 3", "Scan 4", Location="southeast")
end