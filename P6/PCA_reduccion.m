function [Z, Uk] = PCA_reduccion(X_norm, k)
    %PCA Algorithm
    % Compute variance
    sig = covarianza_muestral(X_norm);
    % Compute eigenvalues and eigenvectors, sorted according to eigenvalues
    [U, ~] = eig(sig);
    Uk = U(:, 1:k);
    % Reduce dimension of normalized data
    Z = X_norm * Uk;
end

