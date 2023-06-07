%% GAJAN Antoine (895824) - Practica 6 : Análisis de componentes principales (PCA)

%% Lab 6.1: PCA 

clear all
close all

% load images 
% images size is 20x20. 

load('MNISTdata2.mat'); 
rand('state',0);
p = randperm(length(y));
X = X(p,:);
y = y(p);

nrows=20;
ncols=20;

nimages = size(X,1);

%Show the images
for I=1:40:nimages, 
    imshow(reshape(X(I,:),nrows,ncols))
    pause(0.1)
end


%% Perform PCA following the instructions of the lab

lambda_list = 10.^(-4:-1);
% Normalize data
[X_norm, mu] = estandardizacion(X);
Xtest_norm = X_menos_mu(Xtest, mu);

%% Parte a)

% Try to see with dimension 2 as in class
% Get Z from PCA
[Z, Uk] = PCA_reduccion(X_norm, 2);

% Show two prinicpal components with labels
figure(100)
clf, hold on
plotwithcolor(Z, y);

% Train with Bayes
[modelo, best_lambda, tab_acierto_T, tab_acierto_V] = regularizacion(10, Z, y, lambda_list, 0);

% Evaluate with training data
draw_confusion_chart(modelo, Z, y);

% Evaluate with test data
Xtest_norm = X_menos_mu(Xtest, mu);
Z_test = Xtest_norm * Uk;
draw_confusion_chart(modelo, Z_test, ytest);

%% Try to see best k by iterating
accuracy = 0;
k = 0;
accuracy_train_table = [];
while accuracy < 0.95 && k < 400
    k = k + 1;
    % PCA with number of dimension defined
    [Z, Uk] = PCA_reduccion(X_norm, k);
    % Train with Bayes
    [modelo, best_lambda, tab_acierto_T, tab_acierto_V] = regularizacion(10, Z, y, lambda_list, 0);
    y_pred = clasificacionBayesiana(modelo, Z);
    accuracy = mean(y_pred == y); 
    accuracy_train_table = [accuracy_train_table; k accuracy];
end
% Print k
fprintf("Best value of k : %d\n", k);
% Evaluate with test data
Z_test = Xtest_norm * Uk;
y_pred_test = clasificacionBayesiana(modelo, Z_test);
accuracy_test = mean(y_pred_test == ytest); 
% Display accuracies with best model
fprintf("Accuracy train : %f\n", accuracy);
fprintf("Accuracy test : %f\n", accuracy_test);
% Display confusion matrix with best k
draw_confusion_chart(modelo, Z, y);
draw_confusion_chart(modelo, Z_test, ytest);

%% Parte b) Variabilidad > 0.99

% Get Z from PCA
variabilidad = 0.99;
[Z, Uk] = PCA_variabilidad(X_norm, variabilidad);
fprintf("Number of dimension to have %d%% of variability : %d\n", variabilidad, size(Uk, 2));
% Train with Bayes
[modelo, best_lambda, tab_acierto_T, tab_acierto_V] = regularizacion(10, Z, y, lambda_list, 0);
y_pred = clasificacionBayesiana(modelo, Z);
accuracy = mean(y_pred == y) 
% Evaluate with test data
Z_test = Xtest_norm * Uk;
y_pred_test = clasificacionBayesiana(modelo, Z_test);
accuracy_test = mean(y_pred_test == ytest) 
% Display confusion matrix with best k
draw_confusion_chart(modelo, Z, y);
draw_confusion_chart(modelo, Z_test, ytest);

%% Parte c) Ver la tasa de acierto en funcion del numero de dimensiones
accuracy_train_table = [];
accuracy_test_table = [];
interval = 1:5:150;
for k = interval
    % PCA with number of dimension defined
    [Z, Uk] = PCA_reduccion(X_norm, k);
    % Train with Bayes
    [modelo, best_lambda, tab_acierto_T, tab_acierto_V] = regularizacion(10, Z, y, lambda_list, 0);
    y_pred = clasificacionBayesiana(modelo, Z);
    accuracy = mean(y_pred == y); 
    % Evaluate with test data
    Z_test = Xtest_norm * Uk;
    y_pred_test = clasificacionBayesiana(modelo, Z_test);
    accuracy_test = mean(y_pred_test == ytest); 
    accuracy_train_table = [accuracy_train_table accuracy];
    accuracy_test_table = [accuracy_test_table accuracy_test];
end
% Plot accuracy in function of k
figure;
grid on; hold on;
plot(interval, accuracy_train_table);
plot(interval, accuracy_test_table);
legend("Datos de entrenamiento", "Datos de test");
xlabel("Numero de dimensiones"); ylabel("Tasa de acierto");
title("Tasa de acierto en funcion del numero de dimension");