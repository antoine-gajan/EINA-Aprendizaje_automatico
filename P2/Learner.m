function [theta] = Learner(X, y, lambda)
    % X = datos
    % y = salida asociada a X
    
    % Verificar si hay un lambda
    if nargin < 3
        lambda =   0;
    end

    % Normalizacion de los datos
    [X, mu, sig] = normalizar(X);

    % Aprender con los datos normalizados
    if lambda > 0
        H = X'*X + lambda*diag([0 ones(1, size(X, 2) - 1)]);
        theta = H \ (X'*y); 
    else
        theta = X \ y;
    end
    % Desnormalizar los pesos
    theta = desnormalizar(theta, mu, sig);
end

