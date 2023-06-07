function [] = draw_confusion_chart(modelo, X, y)
    % Function to draw confusion matrix
    y_pred = clasificacionBayesiana(modelo, X);
    accuracy = mean(y_pred == y);    
    % Confusion matrix
    figure;
    mat_confusiones_chart_tr = confusionchart(y, y_pred, 'RowSummary','row-normalized', 'ColumnSummary','column-normalized');
    mat_confusiones_chart_tr.Title = "Matriz de confusion";
end

