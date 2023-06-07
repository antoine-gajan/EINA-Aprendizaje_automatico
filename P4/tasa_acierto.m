function [tasa] = tasa_acierto(theta, X, y)
    % Numero de datos
    N = length(y);
    % Calcula salida predicha
    y_pred = 1 ./ (1 + exp(-(X * theta)));
    y_pred = y_pred >= 0.5;
    % Calcula tasas
    tasa = 1 / N * sum(y_pred == y);
end

