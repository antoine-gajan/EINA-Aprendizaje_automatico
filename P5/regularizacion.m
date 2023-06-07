function [best_modelo, best_lambda, tab_acierto_T, tab_acierto_V] = regularizacion(K, X, y, lambda_list, naiveBayes)
    % K =  número de grupos en los que se divide los datos
    % X = datos de entrenamiento + validacion
    % y = valores de salida asociados a X

    % Initializacion variables de la funcion
    best_lambda = 10e-10;
    best_tasa_acierto_V = 0;
    tab_acierto_T = [];
    tab_acierto_V = [];

    % Ver cual es el mejor modelo
    for lambda = lambda_list
        % Inicializacion variables
        err_T = 0;
        err_V = 0;
        tasa_acierto_T = 0;
        tasa_acierto_V = 0;
        % Para cada pliegue
        for fold = 1:K
            % Dividir los datos
            [X_validacion, y_validacion, X_entrenamiento, y_entrenamiento] = particion(fold, K, X, y);
            % Aprender con los datos de entrenamiento
            modelo  = entrenarGaussianas(X_entrenamiento, y_entrenamiento, naiveBayes, lambda);
            % Calculo metricas elegidas
            tasa_acierto_T = tasa_acierto_T + tasa_acierto(modelo, X_entrenamiento, y_entrenamiento);
            tasa_acierto_V = tasa_acierto_V + tasa_acierto(modelo, X_validacion, y_validacion);
        end
        % Calculo de la tasa media
        tasa_acierto_T = tasa_acierto_T / K;
        tasa_acierto_V = tasa_acierto_V / K;
        % Actualizacion del mejor modelo
        if tasa_acierto_V > best_tasa_acierto_V
            best_tasa_acierto_V = tasa_acierto_V;
            best_lambda = lambda;
        end
        % Añadir a la tabla de los aciertos para dibujar
        tab_acierto_T = [tab_acierto_T tasa_acierto_T];
        tab_acierto_V = [tab_acierto_V tasa_acierto_V];
    end
    
    % Reentrenar con el mejor modelo
    best_modelo = entrenarGaussianas(X, y, naiveBayes, best_lambda);
end

