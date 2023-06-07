function [Z, Uk] = PCA_variabilidad(X_norm, threshold_variabilidad)
    %PCA Algorithm
    % Compute variance
    sig = covarianza_muestral(X_norm);
    % Compute eigenvalues and eigenvectors, sorted according to eigenvalues
    [U, lambda] = eig(sig);
    % Choose adequate k
    k = elegir_K(lambda, threshold_variabilidad);
    Uk = U(:, 1:k);
    % Reduce dimension of normalized data
    Z = X_norm * Uk;
end

