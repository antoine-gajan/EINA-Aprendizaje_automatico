function [theta_best_modelo, best_lambda, tab_error_T, tab_error_V, tab_acierto_T, tab_acierto_V] = regularizacion(K, X, y, lambda_list)
    % K =  número de grupos en los que se divide los datos
    % X = datos de entrenamiento + validacion
    % y = valores de salida asociados a X

    % Initializacion variables de la funcion
    best_lambda = 10e-10;
    best_errV = inf;
    tab_error_T = [];
    tab_error_V = [];
    tab_acierto_T = [];
    tab_acierto_V = [];
    % Initilizacion del unico modelo (cada atributo tiene un grado de 6)
    grados = [6 6];
    X_exp = expandir2(X(:,2), X(:,3), grados(1));
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
            [X_validacion, y_validacion, X_entrenamiento, y_entrenamiento] = particion(fold, K, X_exp, y);
            % Aprender con los datos de entrenamiento
            theta  = LearnerRegularizado(X_entrenamiento, y_entrenamiento, lambda);
            % Calculo de los errores con los datos de entrenamiento y de validacion
            err_T = err_T + CosteLogReg(theta, X_entrenamiento, y_entrenamiento, lambda);
            err_V = err_V + CosteLogReg(theta, X_validacion, y_validacion, lambda);
            % Calculo metricas elegidas
            tasa_acierto_T = tasa_acierto_T + tasa_acierto(theta, X_entrenamiento, y_entrenamiento);
            tasa_acierto_V = tasa_acierto_V + tasa_acierto(theta, X_validacion, y_validacion);
        end
        % Calculo del error medio
        err_T = err_T / K;
        err_V = err_V / K;
        % Actualizacion del mejor modelo
        if err_V < best_errV
            best_errV = err_V;
            best_lambda = lambda;
        end
        % Añadir a la tabla de los errores para dibujar
        tab_error_T = [tab_error_T err_T];
        tab_error_V = [tab_error_V err_V];
        % Añadir a la tabla de los aciertos para dibujar
        tab_acierto_T = [tab_acierto_T tasa_acierto_T / K];
        tab_acierto_V = [tab_acierto_V tasa_acierto_V / K];
    end
    % Reentrenar con el mejor modelo
    theta_best_modelo = LearnerRegularizado(X_exp, y, best_lambda);
end

