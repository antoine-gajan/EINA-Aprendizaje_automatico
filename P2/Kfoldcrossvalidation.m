function [best_modelo, theta_best_modelo, tab_errT, tab_errV] = Kfoldcrossvalidation(K, X, y, modelos, lambda)
    % K =  número de grupos en los que se divide los datos
    % X = datos de entrenamiento + validacion
    % y = valores de salida asociados a X
    % modelos = los diferentes modelos a probar

    if nargin < 5
        lambda =   0;
    end

    % Initializacion errores y mejor modelo
    tab_errT = [];
    tab_errV = [];
    best_modelo = modelos(1, :);
    best_errV = inf;

    % Para cada modelo
    for i = 1:size(modelos, 1)
        modelo = modelos(i, :);
        % Inicializacion variables
        err_T = 0;
        err_V = 0;
        X_exp = expandir(X, modelo);
        % Para cada pliegue
        for fold = 1:K
            % Dividir los datos
            [X_validacion, y_validacion, X_entrenamiento, y_entrenamiento] = particion(fold, K, X_exp, y);
            % Aprender con los datos de entrenamiento
            theta  = Learner(X_entrenamiento, y_entrenamiento, lambda);
            % Calculo de los errores con los datos de entrenamiento y de validacion
            err_T = err_T + RMSE(theta, X_entrenamiento, y_entrenamiento);
            err_V = err_V + RMSE(theta, X_validacion, y_validacion);
        end
        % Calculo del error medio
        err_T = err_T / K;
        err_V = err_V / K;
        % Actualizacion del mejor modelo
        if err_V < best_errV
            best_errV = err_V;
            best_modelo = modelo;
        end
        % Añadir a la tabla de los errores para dibujar cuando se pide
        tab_errT = [tab_errT err_T];
        tab_errV = [tab_errV err_V];
    end
    % Entrenamiento de todos los datos con el mejor modelo
    X_exp = expandir(X, best_modelo);
    theta_best_modelo  = Learner(X_exp, y);
end

