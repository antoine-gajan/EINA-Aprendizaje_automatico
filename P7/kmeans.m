function [mu, c] = kmeans(D,mu0)
    % D(m,n), m datapoints, n dimensions
    % mu0(K,n) K initial centroids
    %
    % mu(K,n) final centroids
    % c(m) assignment of each datapoint to a class

    % Initialization of variable
    m = size(D, 1);
    c = zeros(m, 1);
    mu = mu0;
    cond = true;
    % While a data has changed of class during the past iteration
    while cond
        % Update clusters
        previous_c = c;
        c = updateClusters(D, mu);
        % Update centroids
        mu = updateCentroids(D, c);
        % Evaluate condition
        cond = ~isequal(previous_c, c);
    end
end

