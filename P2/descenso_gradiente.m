%% Function de descenso de gradiente
function [theta, tab_J] = descenso_gradiente(X, y, alpha, conv_obj)
    N = size(X, 1); % N = Number of rows
    D = size(X, 2); % D = Number of columns
    % Normalizar los attributos
    mu = mean(X(:, 2:end)); % mu = Mean of each column
    var = std(X(:, 2:end)); % var = Variance of each column
    X(:,2:end) = (X(:,2:end) - repmat(mu,N,1))./ repmat(var,N,1);
    % Regresion
    theta = rand(D, 1); % theta is an array of D elements which are the weights
    convergence = Inf;
    tab_J = [];
    while convergence > conv_obj
        [J, grad, ~] = CosteL2(theta, X, y);
        theta = theta - alpha * grad;
        convergence = norm(grad); % Norma del vector para saber cuando la deriva es suficiente pequena
        tab_J = [tab_J J]; % Recuperacion del coste
    end
    % Desnormalizacion de los pesos
    theta(1) = theta(1) - (mu ./var * theta(2:end));
    theta(2:end) = theta(2:end) ./ var';
end

