%% GAJAN Antoine (894825) - Aprendizaje automatico - Practica 1
%% Cargar los datos de entrenamiento y de test
datos = load('PisosTrain.txt');
y = datos(:,3);  % Precio en Euros
x0 = ones(length(y), 1);
x1 = datos(:,1); % m^2
x2 = datos(:,2); % Habitaciones
N = length(y);

datostest = load('PisosTest.txt');
ytest = datostest(:,3);  % Precio en Euros
x0test = ones(length(ytest), 1);
x1test = datostest(:,1); % m^2
x2test = datostest(:,2); % Habitaciones
Ntest = length(ytest);

%% Cuestion 2
disp("Cuestion 2 : Regresion monovariable utilizando ecuacion cuadratica")
x = [x0 x1]; % No olvidar que x0 pertenece a x
theta = x \ y;

% Plot datos
close all;
t = tiledlayout(1,2); % Plot 2 figures in only 1 figure
nexttile;
plot(x1, y, '.');
xlabel("Superficie (m^2)",'FontSize',12);
ylabel("Precio (en €)",'FontSize',12);
title(t, "Precio de los pisos en funcion de la superficie", 'fontweight', 'bold', 'FontSize',15);
hold on; grid on;
% Plot regresion
res = 0.001;
domain = 0:res:350;
plot(domain, theta(1) + theta(2) * domain, '-')
legend('Datos de entrenamiento', 'Prediccion');

% Calculo de las metricas con los datos de entrenamiento
mae = MAE(theta, x, y)
mre = MRE(theta, x, y)

% Calculo de las metricas con los datos de test
xtest = [x0test x1test]; % No olvidar que x0 pertenece a x
mae_test = MAE(theta, xtest, ytest)
mre_test = MRE(theta, xtest, ytest)

% Plot datos de test
nexttile;
plot(x1test, ytest, '.', 'MarkerEdgeColor',[0.8500 0.3250 0.0980]);
xlabel("Superficie (m^2)",'FontSize',12);
ylabel("Precio (en €)",'FontSize',12);
hold on; grid on;
% Plot regresion
res = 0.001;
domain = 0:res:350;
plot(domain, theta(1) + theta(2) * domain, '-')
legend('Datos de test', 'Prediccion');

%% Cuestion 3
disp("Cuestion 3 : Regresion multivariable utilizando ecuacion cuadratica")
x = [x0 x1 x2]; % No olvidar que x0 pertenece a x
theta = x \ y;
yest = x * theta;

% Plot
close all;
% Dibujar los puntos de entrenamiento y su valor estimado 
figure;  
plot3(x1, x2, y, '.r', 'markersize', 20);
axis vis3d; hold on;
plot3([x1 x1]' , [x2 x2]' , [y yest]', '-b');

% Generar una retícula de np x np puntos para dibujar la superficie
np = 20;
ejex1 = linspace(min(x1), max(x1), np)';
ejex2 = linspace(min(x2), max(x2), np)';
[x1g,x2g] = meshgrid(ejex1, ejex2);
x1g = x1g(:); %Los pasa a vectores verticales
x2g = x2g(:);

% Calcula la salida estimada para cada punto de la retícula
Xg = [ones(size(x1g)), x1g, x2g];
yg = Xg * theta;

% Dibujar la superficie estimada
surf(ejex1, ejex2, reshape(yg,np,np)); grid on; 
title('Precio de los Pisos')
zlabel('Euros'); xlabel('Superficie (m^2)'); ylabel('Habitaciones');

% Calculo de las metricas con los datos de entrenamiento
mae = MAE(theta, x, y)
mre = MRE(theta, x, y)

% Calculo de las metricas de errores con los datos de tests
xtest = [x0test x1test x2test];
mae_test = MAE(theta, xtest, ytest)
mre_test = MRE(theta, xtest, ytest)


%% Cuestion 4

disp("Cuestion 4 : Regresion monovariable utilizando descenso de gradiente")
x = [x0 x1];
[theta, tab_J] = descenso_gradiente(x, y, 1, 1);

% Plot datos y regresion
close all;
t = tiledlayout(1,2); % Plot 2 figures in only 1 figure
nexttile;
plot(x1, y, '.');
xlabel("Superficie (m^2)",'FontSize',12);
ylabel("Precio (en €)",'FontSize',12);
title(t, "Precio de los pisos en funcion de la superficie", 'fontweight', 'bold', 'FontSize',15);
hold on; grid on;
% Plot regresion
res = 0.001;
domain = 0:res:350;
plot(domain, theta(1) + theta(2) * domain, '-')
legend('Datos de entrenamiento', 'Prediccion');

% Plot datos de test
nexttile;
plot(x1test, ytest, '.', 'MarkerEdgeColor',[0.8500 0.3250 0.0980]);
xlabel("Superficie (m^2)",'FontSize',12);
ylabel("Precio (en €)",'FontSize',12);
hold on; grid on;
% Plot regresion
res = 0.001;
domain = 0:res:350;
plot(domain, theta(1) + theta(2) * domain, '-')
legend('Datos de test', 'Prediccion');

% Plot evolución del coste
figure(2);
plot(tab_J);
xlabel("Iteraciones",'FontSize',12);
ylabel("Coste cuadratico",'FontSize',12);
title("Evolucion del coste cuadratico");

% Calculo de las metricas con los datos de entrenamiento
mae = MAE(theta, x, y)
mre = MRE(theta, x, y)

% Calculo de las metricas con los datos de test
xtest = [x0test x1test]; % No olvidar que x0 pertenece a x
mae_test = MAE(theta, xtest, ytest)
mre_test = MRE(theta, xtest, ytest)

%% Observar el mejor alpha (menos iteraciones)
close all;
alpha_list = linspace(0.1, 1.1, 100);
iteraciones_list = [];
for alpha = alpha_list
    [~, tab_J] = descenso_gradiente(x, y, alpha, 1);
    iteraciones_list = [iteraciones_list length(tab_J)];
end
plot(alpha_list, iteraciones_list);
xlabel("Alpha"); 
ylabel("Numero de iteraciones");
title("Evolucion del numero de iteraciones para converger en funcion de alpha");

%% Cuestion 5

disp("Cuestion 5 : Regresion multivariable utilizando descenso de gradiente")
x = [x0 x1 x2];
% Calculo de los pesos y recuperacion del vector con la evolucion del coste
[theta, tab_J] = descenso_gradiente(x, y, 1, 1);


% Plot 
close all;
% Dibujar los puntos de entrenamiento y su valor estimado 
figure(1);  
plot3(x1, x2, y, '.r', 'markersize', 20);
axis vis3d; hold on;
yest = x * theta;
plot3([x1 x1]' , [x2 x2]' , [y yest]', '-b');

% Generar una retícula de np x np puntos para dibujar la superficie
np = 20;
ejex1 = linspace(min(x1), max(x1), np)';
ejex2 = linspace(min(x2), max(x2), np)';
[x1g,x2g] = meshgrid(ejex1, ejex2);
x1g = x1g(:); %Los pasa a vectores verticales
x2g = x2g(:);

% Calcula la salida estimada para cada punto de la retícula
Xg = [ones(size(x1g)), x1g, x2g];
yg = Xg * theta;

% Dibujar la superficie estimada
surf(ejex1, ejex2, reshape(yg,np,np)); grid on; 
title('Precio de los Pisos')
zlabel('Euros'); xlabel('Superficie (m^2)'); ylabel('Habitaciones');

% Dibujar datos de test en el mismo plot
plot3(x1test, x2test, ytest, '.g', 'markersize', 20);
legend("Datos de entrenamiento", "Error entre salida calculada y valor real");

% Plot evolución del coste
figure(2);
plot(tab_J);
xlabel("Iteraciones",'FontSize',12);
ylabel("Coste cuadratico",'FontSize',12);
title("Evolucion del coste cuadratico");

% Calculo de las metricas con los datos de entrenamiento
mae = MAE(theta, x, y)
mre = MRE(theta, x, y)

% Calculo de las metricas con los datos de test
xtest = [x0test x1test x2test]; % No olvidar que x0 pertenece a x
mae_test = MAE(theta, xtest, ytest)
mre_test = MRE(theta, xtest, ytest)


%% Cuestion 6

disp("Cuestion 6 : Regresion robusta multivariable")
x = [x0 x1 x2];
% Calculo de los pesos y recuperacion del vector con la evolucion del coste
[theta, tab_J] = descenso_gradiente_Huber(x, y, 1, 1, 4e+05);

% Plot
close all;
% Dibujar los puntos de entrenamiento y su valor estimado 
figure(1);  
plot3(x1, x2, y, '.r', 'markersize', 20);
axis vis3d; hold on;
yest = x * theta;
plot3([x1 x1]' , [x2 x2]' , [y yest]', '-b');

% Generar una retícula de np x np puntos para dibujar la superficie
np = 20;
ejex1 = linspace(min(x1), max(x1), np)';
ejex2 = linspace(min(x2), max(x2), np)';
[x1g,x2g] = meshgrid(ejex1, ejex2);
x1g = x1g(:); %Los pasa a vectores verticales
x2g = x2g(:);

% Calcula la salida estimada para cada punto de la retícula
Xg = [ones(size(x1g)), x1g, x2g];
yg = Xg * theta;

% Dibujar la superficie estimada
surf(ejex1, ejex2, reshape(yg,np,np)); grid on; 
title('Precio de los Pisos')
zlabel('Euros'); xlabel('Superficie (m^2)'); ylabel('Habitaciones');

% Dibujar datos de test en el mismo plot
plot3(x1test, x2test, ytest, '.g', 'markersize', 20);
legend("Datos de entrenamiento", "Error entre salida calculada y valor real");

% Plot evolución del coste
figure(2);
plot(tab_J);
xlabel("Iteraciones",'FontSize',12);
ylabel("Coste de Huber",'FontSize',12);
title("Evolucion del coste de Huber");

% Calculo de las metricas con los datos de entrenamiento
mae = MAE(theta, x, y)
mre = MRE(theta, x, y)

% Calculo de las metricas con los datos de test
xtest = [x0test x1test x2test]; % No olvidar que x0 pertenece a x
mae_test = MAE(theta, xtest, ytest)
mre_test = MRE(theta, xtest, ytest)



%% Observar el mejor delta (menos iteraciones)
close all;
delta_list = linspace(200000, 900000, 200);
iteraciones_list = [];
for delta = delta_list
    [~, tab_J] = descenso_gradiente_Huber(x, y, 1, 1, delta);
    iteraciones_list = [iteraciones_list length(tab_J)];
end
plot(delta_list, iteraciones_list, 'LineWidth', 3);
xlabel("Delta"); 
ylabel("Numero de iteraciones");
title("Evolucion del numero de iteraciones para converger en funcion de delta");
