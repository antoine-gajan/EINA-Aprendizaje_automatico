function [theta] = LearnerRegularizado(X, y, lambda)
    % X = datos
    % y = salida asociada a X

    % Opciones
    options.useMex = 1 ;
    options.display = 'none';
    options.method = 'lbfgs';

    % Calculo theta
    theta_ini = [zeros(size(X, 2), 1)];
    theta = minFunc(@CosteLogReg, theta_ini, options, X, y, lambda);
end

