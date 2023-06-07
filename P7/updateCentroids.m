function munew = updateCentroids(D,c)
    % D((m,n), m datapoints, n dimensions
    % c(m) assignment of each datapoint to a class
    %
    % munew(K,n) new centroids

    munew = [];
    K = max(c);
    for k = 1:K
        D_good = D(c == k, :);
        munew = [munew; mean(D_good)];
    end
end

