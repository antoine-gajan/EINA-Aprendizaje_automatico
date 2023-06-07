%% GAJAN Antoine (895824) - Practica 3 : Regresion Logistica
%% Añadir minFunc y comprobar que funciona
addpath(genpath(pwd))

example_minFunc

%% Cargar los datos

% Optiones para minFunc
options.useMex = 1 ;
options.display = 'none';
options.method = 'newton';

% Cargar y preparar datos
wine_train = load('wine_train.txt');
wine_test  = load('wine_test.txt');

clase = 1;
f1 = 6; f2 = 10; 
disp(sprintf('----- Clasificación de la clase %g con las features %g y %g ----', clase, f1, f2));

ydata = wine_train(:,1);
Xdata = wine_train(:,2:end);
x1 = Xdata(:,f1);
x2 = Xdata(:,f2);
y = ydata==clase;
X = [ones(length(y),1) x1 x2];

yt = wine_test(:,1);
Xt = wine_test(:,2:end);
xt1 = Xt(:,f1);
xt2 = Xt(:,f2);
ytest = yt==clase;
Xtest = [ones(length(ytest),1) xt1 xt2];

%% Cuestion 1 : Regresion logistica basica

% Regresion logistica basica
theta_q1 = Learner(X, y);

% Dibujo
plot_wines(Xdata, ydata, f1, f2);
plotDecisionBoundary(theta_q1, X);
title("Frontera de decision");

% Calculo metricas
tasa_entrenamiento = tasa_acierto(theta_q1, X, y)
tasa_test = tasa_acierto(theta_q1, Xtest, ytest)


% Vino clase 6 = 0.6
% Valor atributo 10
interval = [min(x2) max(x2)];
valor_10 = linspace(interval(1), interval(2), 100)';
% Calculo probabilidades
x_06 = repmat([1 0.6], size(valor_10, 1), 1);
x_06 = [x_06 valor_10];
probs = pred(x_06, theta_q1);
%% Plot
plot(valor_10, probs)
hold on; grid on;
yline(0.5, 'LineWidth', 2);
xlabel("Valores atributo 10");
ylabel("Probilidad");
title("Probabilidad de pertenecer a la clase 1 segun los valores del atributo 10");

%% Cuestion 2 : Regularizacion

grados = [6 6];
lambda_list = 10.^(-6:0);
[theta_q2_best, best_lambda, tab_error_T, tab_error_V, tab_acierto_T, tab_acierto_V] = regularizacion(10, X, y, lambda_list);

%% Dibujar los errores en funcion de lambda
grid on;
semilogx(logspace(-6, 0, 7), tab_error_T, logspace(-6, 0, 7), tab_error_V);
ylabel('Coste Logistico Regularizado'); xlabel('Lambda');
title("Coste logistico regularizado en funcion del valor de lambda");
legend("Entrenamiento", "Validacion");

%% Dibujar las metricas elegidas por cada modelo
grid on;
semilogx(logspace(-6, 0, 7), tab_acierto_T .* 100, logspace(-6, 0, 7), tab_acierto_V .* 100);
ylabel('Tasa de acierto (en %)'); xlabel('Lambda');
title("Tasa de acierto en funcion del valor de lambda");
legend("Entrenamiento", "Validacion");


X_exp_tr = expandir2(X(:,2), X(:,3), grados(1));
X_exp_test = expandir2(Xtest(:,2), Xtest(:,3), grados(1));

% Calculo metricas con el mejor modelo
tasa_entrenamiento = tasa_acierto(theta_q2_best, X_exp_tr, y)
tasa_test = tasa_acierto(theta_q2_best, X_exp_test, ytest)

% Calculo metricas con lambda = 0
theta_q2_lambda0 = regularizacion(10, X, y, 0);
tasa_entrenamiento_lambda0 = tasa_acierto(theta_q2_lambda0, X_exp_tr, y)
tasa_test_lambda0 = tasa_acierto(theta_q2_lambda0, X_exp_test, ytest)

%% Plot best lambda
plot_wines(Xdata, ydata, f1, f2);
plotDecisionBoundary(theta_q2_best, X);

%% Plot lambda = 0
plot_wines(Xdata, ydata, f1, f2);
plotDecisionBoundary(theta_q2_lambda0, X);

%% Vino x6 = 0.6
% Vino clase 6 = 0.6
% Valor atributo 10
interval = [min(x2) max(x2)];
valor_10 = linspace(interval(1), interval(2), 100)';
% Calculo probabilidades
x_06 = repmat([1 0.6], size(valor_10, 1), 1);
x_06 = [x_06 valor_10];
x = expandir2(x_06(:,2), x_06(:,3), 6);
probs = pred(x, theta_q2_best);

plot(valor_10, probs);
hold on; grid on;
yline(0.5, 'LineWidth', 2);
xlabel("Valores atributo 10");
ylabel("Probilidad");
title("Probabilidad de pertenecer a la clase 1 segun los valores del atributo 10");


%% Cuestion 3 : Precision / Recall

precisions_q1 = [];
recalls_q1 = [];
precisions_q2_best = [];
recalls_q2_best = [];
precisions_q2_lambda0 = [];
recalls_q2_lambda0 = [];

X_q1 = Xtest;
X_q2 = expandir2(Xtest(:,2), Xtest(:,3), 6);
umbral = linspace(0, 1, 50);
% Calculo de la precision y recall para cada umbral entre 0 y 1
for seuil = umbral 
    % Cuestion 1
    [precision_q1, recall_q1] = precision_recall(theta_q1, X_q1, ytest, seuil);
    precisions_q1 = [precisions_q1 precision_q1];
    recalls_q1 = [recalls_q1 recall_q1];
    % Cuestion 2 : mejor modelo
    [precision_q2_best, recall_q2_best] = precision_recall(theta_q2_best, X_q2, ytest, seuil);
    precisions_q2_best = [precisions_q2_best precision_q2_best];
    recalls_q2_best = [recalls_q2_best recall_q2_best];
    % Cuestion 2 : lambda = 0
    [precision_q2_lambda0, recall_q2_lambda0] = precision_recall(theta_q2_lambda0, X_q2, ytest, seuil);
    precisions_q2_lambda0 = [precisions_q2_lambda0 precision_q2_lambda0];
    recalls_q2_lambda0 = [recalls_q2_lambda0 recall_q2_lambda0];
end

plot(recalls_q1, precisions_q1);
hold on; grid on;
plot(recalls_q2_best, precisions_q2_best);
plot(recalls_q2_lambda0, precisions_q2_lambda0);
xlabel("Recall");
ylabel("Precision");
ylim([0, 1]);
title("Precision / Recall curve");
legend("Cuestion 1", "Cuestion 2 : mejor modelo", "Cuestion 2 : lambda = 0", 'Location', 'southwest');

%% Opcional : umbral para alcanzar el objetivo de precision > 0.9

plot(umbral, precisions_q2_best);
hold on; grid on;
title("Precision del modelo con lambda = 10^{-6} en funcion del umbral");
xlabel("Umbral"); 
ylabel("Precision"); ylim([0.4 1]);
yline(0.9, 'LineWidth', 1, 'LineStyle','--', 'Color', [1 0 0.5]);