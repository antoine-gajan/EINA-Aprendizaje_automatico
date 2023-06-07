%% Funcion para calcular la prediccion de y
function y = pred(X, theta)
    y = 1./(1+exp(-(X*theta)));
end
