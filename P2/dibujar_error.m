function [] = dibujar_error(titulo, x_values, err_tr, err_val)
    % titulo = titulo del dibujo
    % x_values = valor de grado
    % err_tr = valores de error de entrenamiento
    % err_val = valores de error de validacion

    figure;
    grid on; hold on;
    plot(x_values, err_tr);
    plot(x_values, err_val);
    ylabel('RMSE'); xlabel('Grado');
    title(titulo);
    legend("Entrenamiento", "Validacion");
end

