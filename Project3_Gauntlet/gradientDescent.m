function [trajectory, optimal] = gradientDescent(x, y, z, initialPosition)
    
    % Set the starting point for gradient descent
    x_current = initialPosition(1);
    y_current = initialPosition(2);
    
    % Set learning rate (step size)
    alpha = 0.001;
    
    % Maximum number of iterations
    max_iterations = 10000;
    
    % Convergence threshold
    convergence_threshold = 1e-3;
    
    % Initialize arrays to store the trajectory of descent
    x_trajectory = [];
    y_trajectory = [];
    
    % Perform gradient descent
    for iteration = 1:max_iterations
        % Calculate the gradient at the current position using MATLAB's gradient function
        [grad_x, grad_y] = gradient(z);
        grad_x = interp2(x, y, grad_x, x_current, y_current);
        grad_y = interp2(x, y, grad_y, x_current, y_current);
        
        % Update the current position
        x_new = x_current - alpha * grad_x;
        y_new = y_current - alpha * grad_y;
        
        % Store the current position
        x_trajectory(iteration) = x_current;
        y_trajectory(iteration) = y_current;
        
        % Check for convergence
        if norm([grad_x, grad_y]) < convergence_threshold
            break;
        end
        
        % Update current position
        x_current = x_new;
        y_current = y_new;
    end

    trajectory = [x_trajectory; y_trajectory];
    optimal = [x_current y_current];
end
