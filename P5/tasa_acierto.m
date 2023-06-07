function [tasa] = tasa_acierto(modelo, X, y)
    % Numero de datos
    N = length(y);
    % Calcula salida predicha
    y_pred = clasificacionBayesiana(modelo, X);
    % Calcula tasa de acierto
    tasa = 1 / N * sum(y_pred == y);
end

