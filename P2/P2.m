%% GAJAN Antoine (895824) - Practica 2

%% Cargar los datos
datos = load('CochesTrain.txt');
ydatos = datos(:, 1);   % Precio en Euros
Xdatos = datos(:, 2:4); % Años, Km, CV
x1dibu = linspace(min(Xdatos(:,1)), max(Xdatos(:,1)), 100)'; %para dibujar

datos2 = load('CochesTest.txt');
ytest = datos2(:,1);  % Precio en Euros
Xtest = datos2(:,2:4); % Años, Km, CV
Ntest = length(ytest);

%% Cuestion 1

disp("Cuestion 1 : Selección de modelos mediante búsqueda heurística");
[theta, grados] = seleccion_heuristica(10, Xdatos, ydatos);
% Mostrar los mejores grados para cado atributo
grados
% Estudiar el error
X = expandir(Xdatos, grados);
rmse_train = RMSE(theta, X, ydatos)
X = expandir(Xtest, grados);
rmse_test = RMSE(theta, X, ytest)
%% Cuestion 2

disp("Cuestion 2 : Selección de modelos mediante búsqueda exhaustiva (grid search)")

% Obtener el mejor modelo
[theta, modelo] = seleccion_exhaustiva(10, Xdatos, ydatos);
modelo
% Estudiar el error
X = expandir(Xdatos, modelo);
rmse_train = RMSE(theta, X, ydatos)
X = expandir(Xtest, modelo);
rmse_test = RMSE(theta, X, ytest)

%% Cuestion 3

disp("Cuestion 3 : Regularización")
[theta, best_lambda] = regularizacion(10, Xdatos, ydatos);
best_lambda
% Estudiar el error
grados = [10 10 10];
X = expandir(Xdatos, grados);
rmse_train = RMSE(theta, X, ydatos)
X = expandir(Xtest, grados);
rmse_test = RMSE(theta, X, ytest)

