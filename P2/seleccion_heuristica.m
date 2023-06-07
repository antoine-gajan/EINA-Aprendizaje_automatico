function [theta, grados] = seleccion_heuristica(K, X, y)
    % K =  número de grupos en los que se divide los datos
    % X = datos de entrenamiento + validacion
    % y = valores de salida asociados a X

    % Grados = [1 ... 1]
    grados = ones(1, size(X, 2));
    % Para cada atributo xi
    for atributo = 1:size(X, 2)
        % Modelos a probar
        modelos = repmat(grados, 10, 1);
        modelos( :, atributo) = 1:10;
        % Ver cual es el mejor modelo
        [best_modelo, ~, tab_errT, tab_errV] = Kfoldcrossvalidation(K, X, y, modelos);
        % Dibujar par ver el mejor grado
        dibujar_error(sprintf("Atributo x%d", atributo), 1:10, tab_errT, tab_errV);
        % Actualizacion de los grados con el mejor valor
        grados = best_modelo; 
    end
    % Entrenamiento de todos los datos con el mejor modelo
    X_exp = expandir(X, grados);
    theta  = Learner(X_exp, y);
end

