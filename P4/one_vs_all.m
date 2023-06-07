function [theta] = one_vs_all(K, X, y)
    % K =  número de grupos en los que se divide los datos
    % X = datos de entrenamiento + validacion
    % y = valores de salida asociados a X

    % Initializacion variables
    list_clases = unique(y)';
    theta = [];
    lambda_list = 10.^(-8:0);

    % Para cada clase
    for clase = list_clases
        % One vs all
        y_clase = y == clase;
        % Entrenamiento con regularizacion
        [theta_clase, best_lambda, tab_acierto_T, tab_acierto_V] = regularizacion(K, X, y_clase, lambda_list);
        % Actualizacion de theta
        theta = [theta theta_clase];
        
        % Plot figure by figure
        figure;
        grid on;
        semilogx(logspace(-8, 0, 9), tab_acierto_T, logspace(-8, 0, 9), tab_acierto_V);
        xline(best_lambda, '-', 'Color', [1 1 0]);
        title(sprintf("Tasa de acierto de la clase %d segun los valores de lambda", clase));
        ylabel('Tasa de acierto'); xlabel('Lambda');
        legend("Datos de entrenamiento", "Datos de test");
    end
end

