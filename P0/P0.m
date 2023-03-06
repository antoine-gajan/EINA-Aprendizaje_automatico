%% Syntaxe :
% ";" : mode silencieux, évite les affichages à chaque ligne
% "%" : commentaire
% "%%" : bloc de code pouvant être executé indépendamment du reste

%% Matrices
%% Fonctions de bases
mat1 = []; % matrice vide
mat2 = [1 2 3 4 ; 5 6 7 8] % Matrice 2 dimensions
A = zeros(4,5);                  % Matrice 4*5 avec des zéros
B = ones (2,3);                  % Matrice 2*3 avec des 1
C = rand(3,3)                   % Matrice 3*3 avec des nombres randoms entre [0,1]
D = randn(2,5)                  % Matrice avec des nombres randoms normalisés
[E,F] = meshgrid(1:5)           % Transforme le domaine spécifié en matrice
G = eye(4)                      % Matrice identité
H = diag(1:4)                   % Matrice diagonale
I = logspace(0,2,6)             % Matrice 1*6 de nombres log espacés entre 10^0 et 10^2
J = blkdiag(rand(2,2),ones(3,2))% Matrice 5*4 par blocs
K = tril(ones(3,4))             % Matrice triangulaire inférieure 3*4
L = triu(ones(3,4))             % Matrice triangulaire supérieure 3*4
M = magic(6)                    % Matrice magique

A = [[1 2 3],ones(1,3)] % Concaténer [1 2 3], [1 1 1] le long des colonnes
B = [[1 2 3];ones(1,3)] % Concaténer [1 2 3], [1 1 1] le long des lignes
C = [99 A 42]           % Ajouter un nombre dans la matrice

%% Taille et statistiques sur les données  
[nrows,ncols] = size(A) % taille de la matrice
n = numel(A)            % nombre d'éléments dans la matrice
n = size(A, 2)          % taille sur une dimension spécifique (ici la deuxième). 1 = ligne, 2 = colonne
C = sum(A,1)            % Somme dimension 1
D = sum(A,2)            % Somme dimension 2
E = mean(A,1)           % Moyenne le long de la dimension 1

F1 = max(A, 2)          % Larger of A and 2 elementwise
F = max(A,[],2)         % Max de chaque ligne
G = min(A,[],1)         % Min de chaque colonne

%% Transposée d'une matrice
B = A'

%% Indexation logique
B = A > 30 % Renvoie une matrice avec des 1 aux endroits où l'élément est plus grand que 30 et 0 sinon

%% Modification et suppression de cases du tableau
A(4,10) = 222           % Met la valeur 222 en A[4][10] (même si le tableau a moins de cases, Matlab crée les manquantes avec des 0
A(1:5,1:5) = 3

A([1,3],:) = []         % Supprime la 1ère et la 3ème ligne
A(:,end) = []           % Supprime la dernière colonne

%% Modification de la taille d'une matrice
B = reshape(A,3,10) % B aura les éléments de A, en ayant 3 lignes et 10 colonnes
B = repmat(A,3,6)   % Copie A verticalement 3 fois et horizontalement 6 fois

%% Opérations éléments par éléments
A = [1 2 3; 4 5 6];
B = A + 1;               % Add or subtract a scalar value from every entry
C = 3.*A;                % Multiply every entry by a scalar value
D = A ./ 3;              % Divide every entry by a scalar value
E = A .^ 3;              % Exponentiate every entry by a scalar value
F = A - [2 4 8 ; 9 1 2]; % Add or subtract two matrices of the same size, (element-wise)
G = A ./ B;              % Divide every entry in A by the corresponding entry in B
H = A .* B;              % Multiply every entry in A by the corresponding entry in B
I = A .^ B;              % Exponentiate every entry in A by the corresponding entry in B

%% Résolution de systèmes matriciels
% On veut résoudre Y = XW
% Alors on a : 
X = W \ Y

%% Autres fonctions utiles
B = det(A);              % The determinant of A
C = rank(A);             % The rank of A
E = trace(A);            % sum of diagonal entries
G = orth(A);             % an orthonormal basis for range of A
H = null(A);             % an orthonormal basis for the nullspace of A
I = chol(A*A');          % Cholesky decomposition s.t. if R = chol(X) then R'*R = X
[evecs,evals] = eig(A);  % eigen vectors and values of A, (use eigs on sparse matrices)
[U,S,V] = svd(A);        % singular value decomposition s.t. A = U*S*V'
[Q,R] = qr(A);           % QR decomposition of A
B = cat(3,[1 2 ; 4 5],[3 2 ; 1 1])  % concatenate two matrices along the third dimension

A = sparse(A); % Convertir A en matrice creuse
A = full(A); % Convertir A en matrice pleine

A = cumsum(1:6); % Crée une matrice où chaque élément est la somme jusque i
C = cumprod(1:6); % Idem avec le produit
D = diff(A); % Chaque élément est la différence de A[i+1] et A[i] (attention : la taille est n - 1)
sort(); % Permet de trier le tableau

%% Fonctions
%% Fonction classique
function [X1,X2] = quadform(A,B,C)
% Implementation of the quadratic formula.
    tmp = sqrt(B.^2 - 4*A.*C);
    X1 = (-B + tmp)./(2*A);
    X2 = (-B - tmp)./(2*A);
end
 
% A, B, C sont les variables données par l'utilisateur lors de l'appel de la fonction
% X1 et X2 sont les variables renvoyées par la fonction

%% Lambda fonction
calcul = @(x) sum(100*(x(2)-x(1).^2).^2 + (1-x(1)).^2);

%% Fonctions standards utiles
s = str2func('sin')
s(0)
feval('cos',pi)
eval('E = 3')
nargin % Nombre d'arguments en entrée donnée par l'utilisateur
nargout % Nombre d'arguments en sortie souhaité par l'utilisateur

%% Chaines de caractères
A = 'This is a Test String #1'
% Strings = tableau de caractères
D = repmat('@!', 2, 5) % On copie @! sur 2 lignes et 5 colonnes

%% Fonctions relatives aux chaines de caractères
check = ischar() % tableau de booléen pour indiquer si chaque caractère est une lettre ou non
% isspace() % idem pour espaces
F = upper(A) % majuscules
G = lower(A) % minuscules
% strtrim() y deblank() enlèvent respectivement les blancs en début et fin,
% et à la fin de la chaine
% isstrprop(chaine, 'prop') étend les fonctions ischar() et autres à toutes les propriétés comme xdigit ou alphanum

A = char(65) % Convertir le code ASCII en caractères
B = abs('B') % Convertir en code ASCII le caractère en paramètre

%% Concaténation et tri d'une chaine
C = strvcat('hello','this','is','a','test') % concatenation verticale
D = sortrows(C) % Tri des lignes par ordre alphabétique
E = strjust(C) % Justifier le texte des chaines

%% Chaines formatées

fprintf('%s won the %s medal', 'Paul', 'gold')
str = sprintf('%07.4f',pi) % Affichage de pi avec 4 décimals et 7 caractères au total, avec des 0 si besoin devant pour arriver à 7 caractères

%% Tableau de cellules (cell arrays)

A = cell(2,4) % Création d'un cell array à 2*4 cellules
B = {[1,2,3],'hello',{1};[3;5],'yes',{'no'}}   % Ajoute un groupe d'objets à un tableau de cellules
C = B(1,2)      % Retourne la cellule 'hello'
D = B{1,2}      % Retourne la chaine elle même : hello

% Avec () : Accès et attribution des cellues
% Avec {} : Accès ou attribution des données dans les cellules

[F,G] = B{:,1} % Si on essaye de retourner des éléments de différentes cellules, c'est considéré comme plusieurs valeurs de retour

%% Assigner des valeurs dans des cell arrays
B(1,1) = {'test'}   % Obligé de passer une cellule en paramètre avec ()
B{1,1} = 'test'     % Idem mais avec {}
B{1,2} = {'test'}   % Attention : ajout d'une cellule
H = B{1,2}{1}       % Pour extraire la valeur de cette cellule, il faut indexer 2 fois

% Les opérations basiques (reshape, repmat, delete) des matrices restent valables

B = mat2cell(M,[2,2],[3,3,2]) % Passage d'une matrice à un cell array. 1er param : matrice, 2eme param : lignes, 3eme param : colonnes
B = cellstr(A) % Convertir à un cell array de strings

%% Appliquer une fonction à un tableau de cellules
A = {'A ', 'test ', 'message, ', 'Which', 'contains ', '3 ','punctuation ' ,'marks!'}
f = @(str) isequal(str, lower(str)); % is  lower case string?
B = cellfun(f,A)

%% Comparer des chaines de caractères
A = 'testString';
test1 = strcmp(A,'testString') % Comparer 2 chaines

%% Occurences d'une chaine de caractère
str = 'actgcgctgacgctgatacacgggagctgacgactgaggacgagc';
A = strfind(str,'ctga') % Renvoie un tableau avec les positions auxquelles on a trouvé la chaine

[token, remaining] = strtok('this is a test') % Split la chaine en fonction des espaces

%% Structures

S = struct('time',0:5,'distance',0:2:10,'height',1:0.5:2) % Création de la structure
names = fieldnames(S)           % Liste les fieldnames
check2 = isfield(S,'time')      % Vérifie si time est un fieldname
S = orderfields(S)              % Trie les fieldnames par ordre alphabétique
S = rmfield(S,'height')         % Supprimer un field

time = S.time % Accès à la valeur du champ
time = 2*S.time % Multiplie par 2 la valeur du temps

%% Tableau de structs
S = struct('Name',{},'ID',{},'Position',{});
S(1).Name = 'Greg'; S(1).ID = '123'; S(1).Position = 'Manager';
S(2).Name = 'Ed'  ; S(2).ID = '312'; S(2).Position = 'Clerk';
S(3).Name = 'Pete'; S(3).ID = '301'; S(3).Position = 'CEO';

%% Plotting

%% Afficher des données random en 2D
rand('twister',0);  % Seed
X = 5*rand(100,1);  y = rand*X + rand(100,1); % Données random
f1 = figure; % Création d'une figure vierge
p1 = plot(X,y,'.'); % Afficher y en fonction de x
X1 = X;

% Titre et labels
axis([-1,6,-1,5]);
xlabel('x'); ylabel('y');title('this is the title');

%% Afficher une courbe

f = @(x) x.^2; % Fonction carré
g = @(x) 5*sin(x)+5; % 2eme fonction
res = 0.001; 
domain = -pi:res:pi; % Domaine d'étude de f et g
f2 = figure; % Nouvelle figure
p3 = plot(domain,f(domain)); % Afficher f(x) en fonciton de x
hold on; % Indique de superposer tous les plots sur la même figure
p4 = plot(domain,g(domain)); % Afficher la deuxième fonction

%% Afficher plusieurs figures (subplots)

subplot(nr,nc,i) % Afficher nr * nc subplots, et travailler dans le ième
figure;
for i=1:6
  subplot(2,3,i);
  hist(rand(1,100),10);
  title(sprintf('subplot %d', i));
end
suptitle('master title')

% Handle de la figure
get(gca) % Obtenir le handle
get(handle,'property') % Obtenir la propriété du handle

%% Histogramme

figure;
grades = fix(normrnd(70,10,100,1));
hist(grades); % Avec hist                               % plot the histogram
xlabel('percent'); ylabel('count');
title('grade distribution');
set(gca,'XLim',[0,100],'YGrid','on'); % gca = get current axis
set(gca,'YMinorTick','on');

%% Densité de probabilité en 1D

figure;
domain = -4:0.01:4;
plot(domain,normpdf(domain),'-r','LineWidth',3);
hold on
% We shade two regions with the area command
L = fix(length(domain))/3;
R = 2*fix(length(domain))/3;
area(domain(1:L),normpdf(domain(1:L)));
area(domain(R:end),normpdf(domain(R:end)));
% Now add gratuitous vertical lines
stem([-0.7,0.1,0.4],normpdf([-0.7,0.1,0.4]),'LineWidth',2);
axis([-4,4,0,0.5]);
set(gca,'XMinorTick','on');
set(gca,'YMinorTick','on');

%% Afficher une image

% Exemple :
load mandrill % Image de MatLab
figure; imagesc(X); % Afficher l'immage
axis image
map = colormap(gray);
axis off

%% Heatmaps

figure;
rand('twister',1);
X = randn(10,10);
imagesc(X);
colorbar

%% Sauvegarde l'image

%figure(gcf);
%print -djpeg test.jpg
%print(gcf, '-djpeg', 'test.jpg');  % Idem si le nom du fichier est une
%variable