function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
    %COFICOSTFUNC Collaborative filtering cost function
    %   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
    %   num_features, lambda) returns the cost and gradient for the
    %   collaborative filtering problem.
    %
    
    % Unfold the U and W matrices from params
    X = reshape(params(1:num_movies*num_features), num_movies, num_features);
    Theta = reshape(params(num_movies*num_features+1:end), ...
                    num_users, num_features);
        
    % Compute the difference between predicted and actual ratings only if
    % R(i,j) equals to 1
    diff = (X * Theta' - Y) .* R;
    % Compute the sum of squared errors unregularized
    J = sum(sum(diff .^ 2)) / 2;
    % Add regularization term to J
    reg_term = lambda / 2 * (sum(sum(Theta .^ 2)) + sum(sum(X .^ 2)));
    % Get final value of J
    J = J + reg_term;
    
    % Compute X_grad which contains the partial derivatives w.r.t. to each element of X
    X_grad = ((R .* (X * Theta' - Y)) * Theta) + lambda * X;
    
    % Compute Theta_grad which contains the partial derivatives w.r.t. to each element of Theta
    Theta_grad = ((R .* (X * Theta' - Y))' * X) + lambda * Theta;
    
    % Store gradients in a unique matrix
    grad = [X_grad(:); Theta_grad(:)];
end