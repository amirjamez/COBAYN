clear all;
close all;
dbstop if error

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n=8;
names={ 'A' , 'S' , 'T' , 'L' , 'B' , 'O' , 'X' , 'D' };
%names={ 'visit' , 'smoking' , 'tuberculosis' , 'lung' , 'bronchitis' , 'ou' , 'Xray' , 'dyspnoea' };
node = struct('visit', 1, ...
    'smoking', 2, ...
    'tuberculosis', 3, ...
    'bronchitis', 5, ...
    'lung', 4, ...
    'ou', 6, ...
    'Xray', 7, ...
    'dyspnoea', 8);

adjacency = zeros(8);
adjacency([node.visit], node.tuberculosis) = 1;
adjacency([node.smoking], node.lung) = 1;
adjacency([node.lung node.tuberculosis], node.ou) = 1;
adjacency([node.ou], node.Xray) = 1;
adjacency([node.smoking], node.bronchitis) = 1;
adjacency([node.bronchitis node.ou], node.dyspnoea) = 1;

value = {{'a1'; 'a2'}, ...
        {'b1'; 'b2'}, ...
        {'f1'; 'f2'}, ...
        {'e1'; 'e2'}, ...
        {'c1'; 'c2'}, ...
        {'d1'; 'd2'}, ...
        {'g1'; 'g2'}, ...
        {'h1'; 'h2'}};

node_sizes=2*ones(1,n);
node_type={'tabular','tabular','tabular','tabular','tabular','tabular','tabular','tabular'};
carre=ones(1,n);
A=1;S=2;T=3;L=4;B=5;E=6;X=7;D=8;

bnet0 = mk_bnet(adjacency, node_sizes);
bnet0.CPD{node.visit} = tabular_CPD(bnet0, node.visit, [0.01 0.99]);
bnet0.CPD{node.tuberculosis} = tabular_CPD(bnet0, node.tuberculosis, [0.05 0.01 0.95 0.99]);
bnet0.CPD{node.smoking} = tabular_CPD(bnet0, node.smoking, [0.5 0.5]);
bnet0.CPD{node.lung} = tabular_CPD(bnet0, node.lung, [0.1 0.01 0.9 0.99]);
bnet0.CPD{node.ou} = tabular_CPD(bnet0, node.ou, [1.0 1.0 1.0 0.0 0.0 0.0 0.0 1.0]);
bnet0.CPD{node.Xray} = tabular_CPD(bnet0, node.Xray, [0.98 0.05 0.02 0.95]);
bnet0.CPD{node.bronchitis} = tabular_CPD(bnet0, node.bronchitis, [0.6 0.3 0.4 0.7]);
bnet0.CPD{node.dyspnoea} = tabular_CPD(bnet0, node.dyspnoea, [0.9 0.7 0.8 0.1 0.1 0.3 0.2 0.9]);

    [xx yy] = make_layout(bnet0.dag);
    yy=(yy-0.2)*.8/.6+.1;
    xx=(xx-0.2833)*.8/.517+.1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load asia20000;
asia20000=asiab;
col = ['y', 'r', 'g', 'b','c'] ;        ncol = length(col);
rond = ['-', ':','-.','--'];            nrond = length(rond);

root = node.smoking
classifi = 1;
imprim = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nouveaux tests


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for sco=2%1:2
 if sco==1, scoring = 'mutual_info';
 else scoring = 'bic';
 end
  
for taille=1:4
 if taille == 1,
   load asia250; taill = 250
 elseif taille == 2,
   load asia500; taill = 500
 elseif taille == 3,
   load asia1000; taill = 1000
 elseif taille == 4,
   load asia2000; taill = 2000
 elseif taille == 5,
   load asia5000; taill = 5000
 elseif taille == 6,
   load asia10000; taill = 10000
 end

 for manq=1:4
  if manq==1
    DM = 0; manqu = 0, EM=0,
  elseif manq==2
    DM = 0.1; manqu = 10, EM=1,
  elseif manq==3
    DM = 0.2; manqu = 20, EM=1,
  elseif manq==4
    DM = 0.3; manqu = 30, EM=1,
  end

  for priori = 0%:1

  ddd = datestr(now);
  ddd([12 15 18])='-' ;
  fnd=[ddd '.txt']; 
  diary(fnd)

  fprintf('Experience du %s\n\n',ddd);
  scoring, taill, manqu, priori

BD0 = asiab;
ns = max(BD0');
[N, m]=size(BD0);

rand('state',0); randn('state',0);

vide = rand(size(BD0))<(1-DM);
BD=BD0.*vide;
BD = mat_to_bnt(BD,0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if EM==0
  methode = 'MWST';
    disp(' Apprentissage de la structure avec l''algorithme MSWT.');
    tmp=cputime;
    dag=learn_struct_mwst(BD0, ones(n,1), node_sizes, node_type, scoring, root);
    tmp=cputime-tmp
    dag
    fprintf('\tL''algorithme MSWT a dure %3.2f secondes\n',tmp);
    editing_d=editing_dist(dag,bnet0.dag)
    score = score_dags(asia20000, ns, {dag})
    oui=0;

 if imprim
  disp(' Affichage des graphes');
    [xx yy] = make_layout(bnet0.dag);
    yy=(yy-0.2)*.8/.6+.1;
    xx=(xx-0.2833)*.8/.517+.1;

    fnout=[ddd '-dag-asia' num2str(taill) '-' num2str(manqu) '-' scoring  '-' methode '.mat'];
    eval(['save ' fnout ' dag']); 
    fprintf(' Sauvegarde de la matrice d''adjacence : %s\n',fnout);

    figure; draw_graph(dag,names,carre,xx,yy);
    fnout=[ddd '-dag-asia' num2str(taill) '-' num2str(manqu) '-' scoring  '-' methode '-RES'];
    eval(['print -depsc2 ' fnout]);    
    fprintf(' Sauvegarde du DAG final : %s\n',fnout);
    %EM = 1;
 end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if EM==1
  methode = 'MWST-EM';
    disp(' Apprentissage de la structure avec l''algorithme MSWT-EM.');
    tmp=cputime;
    bnet = learn_struct_mwst_em(BD, ones(1,n), ns, priori, node_type, scoring, root);
    tmp=cputime-tmp
    dag = bnet.dag
    fprintf('\tL''algorithme MSWT a dur� %3.2f secondes\n',tmp);
    editing_d=editing_dist(dag,bnet0.dag)
    score = score_dags(asia20000, ns, {dag})

 if imprim
    fnout=[ddd '-dag-asia' num2str(taill) '-' num2str(priori) '-' num2str(manqu) '-' scoring  '-' methode '.mat'];
    eval(['save ' fnout ' dag']);
    fprintf(' Sauvegarde de la matrice d''adjacence : %s\n',fnout);

    figure; draw_graph(dag,names,carre,xx,yy);
    fnout=[ddd '-dag-asia' num2str(taill) '-' num2str(priori) '-' num2str(manqu) '-' scoring  '-' methode '-RES'];
    eval(['print -depsc2 ' fnout]);    
    fprintf(' Sauvegarde du DAG final : %s\n',fnout);
 end
 
  disp(' Calcul de la vraissemblance du reseau par rapport aux donnees incompletes :');
  engine = jtree_inf_engine(bnet);
  [data_mat, LLik] = fill_in_by_inference(BD, engine);
  LLik

end

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if classifi   

    meth=1;
    bnet=mk_bnet(dag,node_sizes);
    fprintf('Apprentissage des parametres en cours\n');

    for j=1:N
       bnet.CPD{j}=tabular_CPD(bnet, j, 'prior_type', 'dirichlet', 'dirichlet_type', 'unif');
    end
    bnet = learn_params(bnet,BD0);

    class_node = 8;
    load asia1000
    BDT = asiab;

    fprintf('Test de classification :\n');
    [ratio, ratiominus, ratioplus,Cmat,AlphaRej,TauxRej,PerfRej,Pmax] = classification_evaluation(bnet, BDT, class_node);

    figure;
    %subplot(1,2,1), hist(Pmax); title(METHOD);
    %subplot(1,2,2), 
    pp(meth)=plot(TauxRej,PerfRej,[col(1+mod(meth,ncol)) rond(1+mod(round(meth/ncol),nrond))]); hold on;
    fprintf('Performances en test : %3.2f [%3.2f-%3.2f] \n',ratio,ratiominus,ratioplus);
    fprintf('ConfMat en test :\t| %3d %3d |\n\t\t\t\t\t| %3d %3d |\n',cell2num(Cmat(1:2,1:2,1))')
    meth=meth+1;
    fnout=[ddd '-dag-asia' num2str(taill) '-' num2str(priori) '-' num2str(manqu) '-' scoring  '-' methode '-ROC'];
    eval(['print -depsc2 ' fnout]);    
    fprintf(' Sauvegarde de la courbe ROC : %s\n',fnout);

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

diary off

   end
  end %scor
 end %taille
end %manq
