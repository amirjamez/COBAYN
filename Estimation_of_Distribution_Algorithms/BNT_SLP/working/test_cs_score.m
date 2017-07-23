clear all;
close all;

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
%A=1;S=2;T=3;L=4;B=5;E=6;X=7;D=8;

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

root = node.smoking;
scoring = 'bic';

BD0 = asiab;
ns = max(BD0');
ns.*(ns == node_sizes);


[N, m]=size(BD0);

    disp(' Apprentissage de la structure avec l''algorithme MSWT.');
    tmp=cputime;
    dag=learn_struct_mwst(BD0, ones(n,1), node_sizes, node_type, scoring, root);
    tmp=cputime-tmp
    dag
    fprintf('\tL''algorithme MSWT a duré %3.2f secondes\n',tmp);
    editing_d=editing_dist(dag,bnet0.dag)
    score = score_dags(asia20000, ns, {dag})
    
    bnet=mk_bnet(dag, 2*ones(1,N))
    
    for j=1:N
       bnet.CPD{j}=tabular_CPD(bnet, j, 'prior_type', 'dirichlet', 'dirichlet_type', 'unif');
    end
    bnet = learn_params(bnet,BD0);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rand('state',0); randn('state',0);

DM = 0.2;

vide = rand(size(BD0))<(1-DM);
BD=BD0.*vide;

taille = 200;
BD = BD(:, 1:taille);
BD = mat_to_bnt(BD,0);

data = BD;
clear asiab asia20000 vide

score = cs_score(data, dag, ns)