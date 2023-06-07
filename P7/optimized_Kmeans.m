function [best_mu, best_c] = optimized_Kmeans(D, K, N)
    % D(m,n) = data
    % K = nb clusters
    % N = nb iterations
    J_min = inf;
    best_c = [];
    best_mu = [];
    for i = 1:N
        % Initialize mu0
        mu0 = initialize_mu0(D, K);
        % K Means
        [mu, c] = kmeans(D, mu0);
        % Calculate distorsion
        J = distorsion(D, c, mu);
        % Update best convergence model
        if J < J_min
            J_min = J;
            best_c = c;
            best_mu = mu;
        end
    end
end

