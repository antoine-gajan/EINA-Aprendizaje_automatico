function [X_norm] = X_menos_mu(X, mu)
    X_norm = X;
    for i = 1:size(X,2)
        X_norm(:,i) = X(:,i) - mu(i); 
    end
end

