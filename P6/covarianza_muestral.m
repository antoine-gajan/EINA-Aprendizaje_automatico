function [sig] = covarianza_muestral(X)
    % Compute matrix of covariance of X
    % Number of x datas
    m = size(X, 1);
    % Compute covariance
    sig = (1 ./ (m- 1)) .* (X') * X;
end

