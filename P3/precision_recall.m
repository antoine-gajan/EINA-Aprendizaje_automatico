function [precision, recall] = precision_recall(theta, X, y, umbral)
    % Entrenamiento
    y_pred = 1 ./ (1 + exp(-(X * theta)));
    y_pred = y_pred >= umbral;
    % Calcular las metricas
    TP = sum(y_pred == 1 & y == 1);
    FP = sum(y_pred == 1 & y == 0);
    FN = sum(y_pred == 0 & y == 1);
    TN = sum(y_pred == y & y == 0);
    % Calcular precision y recall
    precision = TP / (FP + TP);
    recall = TP / (TP + FN) ;
end

