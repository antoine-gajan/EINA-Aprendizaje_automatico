function yhat = clasificacionBayesiana(modelo, X)
% Con los modelos entrenados, predice la clase para cada muestra X
tab_probs = [];
for clase = 1:10
    prob = gaussLog(modelo(clase).mu, modelo(clase).sigma, X);
    tab_probs = [tab_probs prob];
end
% Get index of max value along rows
[~, yhat] = max(tab_probs, [], 2);
end


