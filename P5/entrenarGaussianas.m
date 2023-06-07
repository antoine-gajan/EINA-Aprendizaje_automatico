function modelo = entrenarGaussianas(Xtr, ytr, NaiveBayes, landa)
% Entrena una Gaussana para cada clase y devuelve:
% modelo{i}.N     : Numero de muestras de la clase i
% modelo{i}.mu    : Media de la clase i
% modelo{i}.Sigma : Covarianza de la clase i
% Si NaiveBayes = 1, las matrices de Covarianza serán diagonales
% Se regularizarán las covarianzas mediante: Sigma = Sigma + landa*eye(D)

% Initializacion modelo
modelo = struct('N',{},'mu',{},'Sigma',{});
% Cuales son las clases
clases = unique(ytr)';
% Para cada clase
for clase = clases
    Xtr_clase = Xtr(ytr==clase, :);
    modelo(clase).N = size(Xtr_clase, 1);
    % Bayes completo
    if NaiveBayes ~= 1
        modelo(clase).mu = mean(Xtr_clase, 1);
        % Matriz de covarianza
        X_menos_mu = bsxfun(@minus, Xtr_clase, modelo(clase).mu); 
        modelo(clase).sigma = 1 / (modelo(clase).N - 1) * (X_menos_mu' * X_menos_mu); 
    % Naive Bayes
    else
        modelo(clase).mu = [];
        modelo(clase).sigma = [];
        for atribute = 1:size(Xtr, 2)
            modelo(clase).mu(atribute) = mean(Xtr_clase(:,atribute));
            modelo(clase).sigma(atribute) = 1 / (modelo(clase).N - 1) * sum((Xtr_clase(:,atribute) - modelo(clase).mu(atribute)).^2);
        end
        modelo(clase).sigma = diag(modelo(clase).sigma);
    end
    % Regularizacion
   modelo(clase).sigma = modelo(clase).sigma + landa * eye(size(Xtr_clase, 2));
end

