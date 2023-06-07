function [theta_best_modelo, best_lambda] = regularizacion(K, X, y)
    % K =  número de grupos en los que se divide los datos
    % X = datos de entrenamiento + validacion
    % y = valores de salida asociados a X

    % Initializacion variables de la funcion
    best_lambda = 10e-10;
    best_err_val = inf;
    tab_err_lambda_tr = [];
    tab_err_lambda_val = [];
    % Initilizacion del unico modelo (cada atributo tiene un grado de 10)
    grados = [10, 10, 10];
    X_exp = expandir(X, grados);
    % Creacion de una lista con valores de lambda
    lambda_list = 10.^(-10:10);
    % Ver cual es el mejor modelo
    for lambda = lambda_list
        [~, theta, tab_errT, tab_errV] = Kfoldcrossvalidation(K, X, y, [10,10,10], lambda);
        % Recuperacion errores de entrenamiento y de validacion
        rmse_tr = tab_errT(1);
        rmse_val = tab_errV(1);
        % Actualizacion del mejor lambda
        if rmse_val < best_err_val
            best_err_val = rmse_val;
            best_lambda = lambda;
        end
        % Tabla con errores de entrenamiento y de validacion
        tab_err_lambda_tr = [tab_err_lambda_tr rmse_tr];
        tab_err_lambda_val = [tab_err_lambda_val rmse_val];
    end
    % Dibujar los errores en funcion de lambda
    grid on;
    semilogx(logspace(-10, 10, 21), tab_err_lambda_tr, 'x', logspace(-10, 10, 21), tab_err_lambda_val, 'x');
    ylabel('RMSE'); xlabel('Lambda');
    title("Errores en funcion del valor de lambda");
    legend("Entrenamiento", "Validacion");
    % Reentrenar con el mejor modelo
    theta_best_modelo = Learner(X_exp, y, best_lambda);
end

