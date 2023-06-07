function Z = updateClusters(D,mu)
    % D(m,n), m datapoints, n dimensions
    % mu(K,n) final centroids
    %
    % c(m) assignment of each datapoint to a class
    Z = [];
    K = size(mu, 1);

    % Calculate the distances between the data points and the centroids
    distances = pdist2(D, mu, 'squaredeuclidean');
    
    % Assign each data point a class which corresponds to the index min of distance
    [~, Z] = min(distances, [], 2);
end
    
