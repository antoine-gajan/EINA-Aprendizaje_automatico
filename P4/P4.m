%% GAJAN Antoine (895824) - Practica 4 : Regresion Logistica Multi-Clase

%% Cargar datos
clear ; close all;
addpath(genpath(pwd));
example_minFunc

% Carga los datos y los permuta aleatoriamente
load('MNISTdata2.mat'); % Lee los datos: X, y, Xtest, ytest
rand('state',0);
p = randperm(length(y));
X = X(p,:);
y = y(p);

%% Cuestion 1 : Regresión logística regularizada

% Aprendizaje
theta = one_vs_all(10, X, y);

%% Cuestion 2 : Evaluación del modelo final

% Evaluacion del modelo
[~,y_pred_tr] = max(pred(X, theta),[],2);
accuracy_tr = mean(y_pred_tr == y)
[~,y_pred_test] = max(pred(Xtest, theta),[],2);
accuracy_test = mean(y_pred_test == ytest)

% Ver confusiones
verConfusiones(X, y, y_pred_tr);
verConfusiones(Xtest, ytest, y_pred_test);

% Con los datos de entrenamiento
figure;
mat_confusiones_chart_tr = confusionchart(y, y_pred_tr, 'RowSummary','row-normalized', 'ColumnSummary','column-normalized');
mat_confusiones_chart_tr.Title = "Matriz de confusion con los datos de entrenamiento";

% Con los datos de test
figure;
mat_confusiones_chart_test = confusionchart(ytest, y_pred_test, 'RowSummary','row-normalized', 'ColumnSummary','column-normalized');
mat_confusiones_chart_test.Title = "Matriz de confusion con los datos de test";
