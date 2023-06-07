function [mu0] = initialize_mu0(D, K)
    % D(m,n) = datas
    % K = number of clusters
    % mu0 = initial centroids
    m = size(D, 1);
    n = size(D, 2);
    nb_clusters = 0;
    mu0 = [];
    while nb_clusters < K
        % Pick random data
        index = randsample(m, 1);
        data_selected = D(index, :);
        % Check if already in mu0 and if not, add to mu0
        if isempty(mu0)
            mu0 = [mu0; data_selected];
            nb_clusters = nb_clusters + 1;
        else
            if ~ismember(data_selected, mu0, 'rows')
                mu0 = [mu0; data_selected];
                nb_clusters = nb_clusters + 1;
            end
        end
    end
end

