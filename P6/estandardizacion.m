function [X_norm, mu] = estandardizacion(X)
    % Funcion que permite estandardizar los datos
    mu = mean(X);
    X_norm = X;
    for i = 1:size(X,2)
        X_norm(:,i) = X(:,i) - mu(i); 
    end
end

