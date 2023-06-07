%% GAJAN Antoine (895824) - Practica 5 : Clasificacion Bayesiana

%% Cargar datos
clear ; close all;

% Carga los datos y los permuta aleatoriamente
load('MNISTdata2.mat'); % Lee los datos: X, y, Xtest, ytest
rand('state',0);
p = randperm(length(y));
X = X(p,:);
y = y(p);

%% Cuestion 1 : Entrenamiento y clasificación con modelos Gaussianos regularizados
% Funciones programadas

%% Cuestion 2 : Bayes ingenuo
lambda_list = 10.^(-4:0.5:-1);
[modelo, best_lambda, tab_acierto_T, tab_acierto_V] = regularizacion(10, X, y, lambda_list, 1);

% Dibujar la metrica en funcion de lambda
figure;
grid on;
semilogx(logspace(-4, -1, 7), tab_acierto_T, logspace(-4, -1, 7), tab_acierto_V);
xline(best_lambda, '-', 'Color', [1 1 0]);
title("Tasa de acierto segun los valores de lambda");
ylabel('Tasa de acierto'); xlabel('Lambda');
legend("Datos de entrenamiento", "Datos de validacion");

% Confusiones datos de entrenamiento
y_pred_tr = clasificacionBayesiana(modelo, X);
verConfusiones(X, y, y_pred_tr);
accuracy_tr = mean(y_pred_tr == y)

% Confusiones datos de test
y_pred_test = clasificacionBayesiana(modelo, Xtest);
verConfusiones(Xtest, ytest, y_pred_test);
accuracy_test = mean(y_pred_test == ytest)

% Con los datos de entrenamiento
figure;
mat_confusiones_chart_tr = confusionchart(y, y_pred_tr, 'RowSummary','row-normalized', 'ColumnSummary','column-normalized');
mat_confusiones_chart_tr.Title = "Matriz de confusion con los datos de entrenamiento";

% Con los datos de test
figure;
mat_confusiones_chart_test = confusionchart(ytest, y_pred_test, 'RowSummary','row-normalized', 'ColumnSummary','column-normalized');
mat_confusiones_chart_test.Title = "Matriz de confusion con los datos de test";


%% Cuestion 3 : Bayes completo
lambda_list = 10.^(-4:0.5:-1);
[modelo, best_lambda, tab_acierto_T, tab_acierto_V] = regularizacion(10, X, y, lambda_list, 0);

% Dibujar la metrica en funcion de lambda
figure;
grid on;
semilogx(logspace(-4, -1, 7), tab_acierto_T, logspace(-4, -1, 7), tab_acierto_V);
xline(best_lambda, '-', 'Color', [1 1 0]);
title("Tasa de acierto segun los valores de lambda");
ylabel('Tasa de acierto'); xlabel('Lambda');
legend("Datos de entrenamiento", "Datos de validacion");


% Confusiones datos de entrenamiento
y_pred_tr = clasificacionBayesiana(modelo, X);
verConfusiones(X, y, y_pred_tr);
accuracy_tr = mean(y_pred_tr == y)

% Confusiones datos de test
y_pred_test = clasificacionBayesiana(modelo, Xtest);
verConfusiones(Xtest, ytest, y_pred_test);
accuracy_test = mean(y_pred_test == ytest)

% Con los datos de entrenamiento
figure;
mat_confusiones_chart_tr = confusionchart(y, y_pred_tr, 'RowSummary','row-normalized', 'ColumnSummary','column-normalized');
mat_confusiones_chart_tr.Title = "Matriz de confusion con los datos de entrenamiento";

% Con los datos de test
figure;
mat_confusiones_chart_test = confusionchart(ytest, y_pred_test, 'RowSummary','row-normalized', 'ColumnSummary','column-normalized');
mat_confusiones_chart_test.Title = "Matriz de confusion con los datos de test";
