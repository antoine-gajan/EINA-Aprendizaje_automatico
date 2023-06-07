%% GAJAN Antoine (895824) - Practica 7 : Agrupamiento
%% Plot original image
figure(1)
im = imread('smallparrot.jpg');
imshow(im)
title("Original image");

%% Datos
D = double(reshape(im,size(im,1)*size(im,2),3));

%% Plot 3D para ver la estructura de los datos a analizar
plot3(D(:,1), D(:,2), D(:,3), 'o');
title("Plot 3D de los pixeles de la imagen");

%% Dimensiones
m = size(D,1);
n = size(D,2);

 %% Opcional : Mejor K

 % Get distorsion in function of K
 interval = 1:10;
 N = 3;
 tab_disto = [];
 for i = interval
     disp(i);
     [mu, c] = optimized_Kmeans(D, i, N);
     disto = distorsion(D, c, mu);
     tab_disto = [tab_disto disto];
 end

 %% Plot distorsion
 plot(interval, tab_disto);
 title("Distorsion in function of K");
 xlabel("K");
 ylabel("Distorsion J");

%% Kmeans 
 % K = (to introduce with your observation of the previous plot)
K = input("What is the value of K ? ");

%% Optimized K Means

N = 5;
[mu, c] = optimized_Kmeans(D, K, N);

%% Reconstruir imagen
 qIM=zeros(length(c),3);
 for h=1:K,
     ind=find(c==h);
     qIM(ind,:)=repmat(mu(h,:),length(ind),1);
 end
 qIM=reshape(qIM,size(im,1),size(im,2),size(im,3));
 figure(2)
 imshow(uint8(qIM));
 title("Reconstructed image");
