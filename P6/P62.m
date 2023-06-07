%% GAJAN Antoine (895824) - Practica 6 : Análisis de componentes principales (PCA)

%% Lab 6.2: PCA 

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
nimagestest = size(Xtest,1);

%% Part a) See influence of noise
% This parameter controls the amount of noise injected per pixel
noise_std =0.3;
X_noise = X + randn(nimages, nrows*ncols)*noise_std;
Xtest_noise = Xtest + randn(nimagestest, nrows*ncols)*noise_std;

%% Show the noisy images
for I=1:40:nimagestest, 
    subplot(1,2,1)
    imshow(reshape(Xtest(I,:),nrows,ncols))
    subplot(1,2,2)
    imshow(reshape(Xtest_noise(I,:),nrows,ncols))
    sgtitle(sprintf("Noise standard derivation : %f", noise_std))
    pause(0.1)
end

%% Prepare variables and normalization
lambda_list = 10.^(-4:-1);
% Normalize data
[X_noise_norm, mu] = estandardizacion(X_noise);
Xtest_noise_norm = X_menos_mu(Xtest_noise, mu);

%% Part b) Perform PCA (use your code from previous exercise)

% Try to see best k
accuracy = 0;
k = 0;
accuracy_table = [];
while accuracy < 0.95 && k < 400
    k = k + 1;
    % PCA with number of dimension defined
    [Z, Uk] = PCA_reduccion(X_noise_norm, k);
    % Train with Bayes
    [modelo, best_lambda, tab_acierto_T, tab_acierto_V] = regularizacion(10, Z, y, lambda_list, 0);
    y_pred = clasificacionBayesiana(modelo, Z);
    accuracy = mean(y_pred == y); 
    % Evaluate with test data
    Z_test = Xtest_noise_norm * Uk;
    y_pred_test = clasificacionBayesiana(modelo, Z_test);
    accuracy_test = mean(y_pred_test == ytest);
    accuracy_table = [accuracy_table; k accuracy accuracy_test];
end
% Print k
fprintf("Best value of k : %d\n", k);
% Evaluate with test data
Z_test = Xtest_noise_norm * Uk;
y_pred_test = clasificacionBayesiana(modelo, Z_test);
accuracy_test = mean(y_pred_test == ytest); 
% Display accuracies with best model
fprintf("Accuracy train : %f\n", accuracy);
fprintf("Accuracy test : %f\n", accuracy_test);
% Display confusion matrix with best k
draw_confusion_chart(modelo, Z, y);
draw_confusion_chart(modelo, Z_test, ytest);

%% Elegir k para obtener variabilidad > 0.99
[Z, Uk] = PCA_variabilidad(X_noise_norm, 0.99);
% Train with Bayes
[modelo, best_lambda, tab_acierto_T, tab_acierto_V] = regularizacion(10, Z, y, lambda_list, 0);
y_pred = clasificacionBayesiana(modelo, Z);
accuracy = mean(y_pred == y); 
% Evaluate with test data
Z_test = Xtest_noise_norm * Uk;
y_pred_test = clasificacionBayesiana(modelo, Z_test);
accuracy_test = mean(y_pred_test == ytest);
fprintf("Value of k : %d\n", size(Uk, 2));
% Display accuracies with best model
fprintf("Accuracy train : %f\n", accuracy);
fprintf("Accuracy test : %f\n", accuracy_test);
% Display confusion matrix with best k
draw_confusion_chart(modelo, Z, y);
draw_confusion_chart(modelo, Z_test, ytest);

%% Denoise test images using k components


% Reconstruct images to visualize denoising results
X_reconstructed = Z * (Uk');

% Display original and reconstructed images
figure;
for B=0:40:nimagestest-10
    for I = 1:10
        subplot(2,10,I);
        imshow(reshape(X_noise(B+I,:),nrows,ncols));
        title('Original');
        subplot(2,10,I+10);
        imshow(reshape(X_reconstructed(B+I,:),nrows,ncols));
        title('Reconstructed');
        sgtitle("Noised and associated denoised image");
    end
    pause(0.1)
    clf
end

%% Use the classifier from previous labs (P5 and P61) to classify noise 
%  test images both directly and on the PCA space


%% Optional You can try and analyse:
% 1- Propose a strategy to select the # of components (hint: reconstruction
% error for train images)
% 2- Training with denoised train images. Remember not to use test images
% during training. 







