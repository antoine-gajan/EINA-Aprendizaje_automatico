function [theta_best_modelo, best_modelo] = seleccion_exhaustiva(K, X, y)
    % K =  número de grupos en los que se divide los datos
    % X = datos de entrenamiento + validacion
    % y = valores de salida asociados a X

    % Encontrar todas las combinaciones posibilidades
    [A, B, C] = ndgrid(1:10, 1:10, 1:10);
    all_possibilities = [A(:), B(:), C(:)];
    % Verificar que tenemos todas las combinaciones
    num_modelos = size(all_possibilities, 1)
    % Ver cual es el mejor modelo
    [best_modelo, theta_best_modelo] = Kfoldcrossvalidation(K, X, y, all_possibilities); 
end

