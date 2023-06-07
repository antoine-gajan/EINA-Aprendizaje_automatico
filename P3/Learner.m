function [theta] = Learner(X, y)
    % X = datos
    % y = salida asociada a X

    % Opciones
    options.useMex = 1 ;
    options.display = 'none';
    options.method = 'newton';

    % Calculo theta
    theta_ini = [ones(size(X, 2), 1)];
    theta = minFunc(@CosteLogistico, theta_ini, options, X, y);
end

