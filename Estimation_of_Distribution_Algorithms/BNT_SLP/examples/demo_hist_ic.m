% Test de la fonction hist_ic revue et corrigée PhL
%

% ----------------------------------------------
% ===== Fichiers de données
%
% Changer sous Windows: \ au lieu de /
% ---------------------------------------------
f_rep      = '../Fatima/fichiers.txt/' ;

f_data     = strcat(f_rep,'Apprentissage.txt');
f_naevus   = strcat(f_rep,'Naevus.txt');
f_melanome = strcat(f_rep,'melanome.txt');
f_test     = strcat(f_rep,'Test.txt');
f_label    = strcat(f_rep,'label_test.txt');


% ==============================================
% Lecture et Echantillonnage des données
% ==============================================

X=load(f_data);
abheart=load(f_naevus);
prheart=load(f_melanome);
test=load(f_test);

numero=X(:,1);
numerot=test(:,1);

X=X(:,2:20);
test=test(:,2:20);

taille=[size(abheart,1) size(prheart,1)];

tic
fprintf('*** Bin determination + sampling\n');
[n,bornes,nbbornes,xechan]=hist_ic(X);
d1=toc;

tic
fprintf('*** Ancienne méthode\n');
[bornes2,nbbornes2]=histogramme(X);
d2=toc;


OK = sum(abs(nbbornes-nbbornes2));

fprintf('Différence entre les bornes des 2 méthodes : %d\n',OK);
fprintf('Durées PhL: %3.3f  OLD: %3.3f\n',d1,d2);

fprintf('*** Echantillonage des données APP\n');
fprintf('ancienne méthode (fonction echantillonage)\n');
xechan2=echantillonage(X,nbbornes2,bornes2);

OK=sum(sum(abs(xechan-xechan2)));
fprintf('Différence entre les résultats des 2 méthodes : %d\n',OK);

fprintf('*** Echantillonage des données TEST\n');
fprintf('ancienne méthode (fonction echantillonage)\n');
xtechan2=echantillonage(test,nbbornes2,bornes2);

fprintf('nouvelle méthode\n');
[n,xtechan]=histc_ic(test,bornes);
OK=sum(sum(abs(xtechan-xtechan2)));
fprintf('Différence entre les résultats des 2 méthodes : %d\n',OK);

