disp('Jouet5');
N=7;
dag = zeros(N);
dag(1,4)=1;
dag(2,[5 4])=1;
dag(3,5)=1;
dag(5,7)=1;
dag(6,[5 7])=1;
%[XX YY] = make_layout(dag);
%XX = XX+0.35*(XX-.5); YY = 1.4*(YY-.5)+.5;
%names = {'1','2','3','4','5','6','7','8'};
%carre = zeros(1,N);
%draw_graph(dag, names, carre, XX, YY);

ns=4*ones(1,N);
bnet = mk_bnet(dag, ns);
bnet.CPD{1} = tabular_CPD(bnet, 1, [0.2 0.8 0.1 0.7]);
bnet.CPD{2} = tabular_CPD(bnet, 2, [0.6 0.4 0.1 0.3]);
bnet.CPD{3} = tabular_CPD(bnet, 3, [0.3 0.7 0.1 0.4]);
bnet.CPD{6} = tabular_CPD(bnet, 6, [0.75 0.25 0.3 0.1]);
bnet.CPD{4} = tabular_CPD(bnet, 4, [ ...
0.25 0.15 0.25 0.15 0.05 0.60 0.75 0.85  ...
0.15 0.05 0.60 0.75 0.85 0.95 0.75 0.85  ...
0.95 0.40 0.25 0.15 0.95 0.05 0.60 0.25  ...
0.05 0.60 0.75 0.85 0.95 0.10 0.25 0.15  ...
0.25 0.15 0.05 0.60 0.75 0.85 0.95 0.05  ...
0.60 0.25 0.15 0.05 0.60 0.75 0.85 0.95  ...
0.75 0.85 0.95 0.40 0.25 0.15 0.05 0.60  ...
0.40 0.60 0.95 0.10 0.75 0.20 0.25 0.10]);
bnet.CPD{7} = tabular_CPD(bnet, 7, [ ...
0.25 0.15 0.25 0.15 0.05 0.60 0.75 0.85  ...
0.15 0.20 0.60 0.50 0.15 0.30 0.60 0.75  ...
0.85 0.95 0.75 0.85 0.95 0.40 0.25 0.15  ...
0.05 0.60 0.75 0.85 0.95 0.10 0.25 0.15  ...
0.25 0.15 0.05 0.60 0.75 0.85 0.95 0.05  ...
0.60 0.25 0.15 0.85 0.95 0.05 0.60 0.75  ...
0.15 0.25 0.40 0.40 0.25 0.15 0.05 0.60  ...
0.75 0.85 0.95 0.10 0.75 0.85 0.50 0.10]);
bnet.CPD{5} = tabular_CPD(bnet, 5, [ ...
0.25 0.15 0.25 0.15 0.05 0.60 0.75 0.85 0.95 0.05 0.60 0.25 0.15 0.05 0.60 0.75  ...
0.85 0.05 0.75 0.85 0.95 0.40 0.25 0.15 0.05 0.60 0.75 0.85 0.95 0.10 0.25 0.15  ...
0.25 0.15 0.05 0.60 0.75 0.85 0.95 0.05 0.60 0.25 0.15 0.05 0.60 0.75 0.85 0.95  ...
0.75 0.85 0.95 0.40 0.25 0.15 0.05 0.60 0.75 0.85 0.95 0.10 0.75 0.85 0.95 0.10  ...
0.25 0.15 0.25 0.15 0.05 0.60 0.75 0.85 0.95 0.05 0.60 0.25 0.15 0.05 0.60 0.75  ...
0.85 0.95 0.75 0.85 0.95 0.40 0.25 0.15 0.05 0.60 0.75 0.85 0.95 0.10 0.25 0.15  ...
0.25 0.15 0.05 0.60 0.75 0.85 0.05 0.05 0.60 0.25 0.15 0.05 0.60 0.75 0.85 0.95  ...
0.75 0.85 0.95 0.80 0.25 0.15 0.05 0.60 0.75 0.85 0.95 0.10 0.75 0.85 0.95 0.10  ...
0.25 0.15 0.25 0.15 0.05 0.60 0.75 0.85 0.95 0.05 0.60 0.25 0.15 0.05 0.60 0.75  ...
0.85 0.95 0.75 0.85 0.95 0.40 0.25 0.15 0.05 0.60 0.75 0.85 0.95 0.10 0.25 0.15  ...
0.25 0.15 0.05 0.60 0.75 0.85 0.95 0.05 0.60 0.25 0.15 0.05 0.60 0.75 0.85 0.95  ...
0.75 0.85 0.95 0.40 0.25 0.15 0.05 0.60 0.75 0.25 0.95 0.10 0.75 0.85 0.95 0.10  ...
0.25 0.15 0.25 0.15 0.05 0.60 0.75 0.85 0.95 0.05 0.60 0.25 0.15 0.05 0.60 0.75  ...
0.85 0.95 0.75 0.85 0.95 0.40 0.25 0.15 0.05 0.60 0.45 0.85 0.95 0.10 0.25 0.15  ...
0.25 0.15 0.05 0.60 0.75 0.15 0.95 0.05 0.60 0.25 0.15 0.05 0.60 0.75 0.85 0.95  ...
0.75 0.85 0.95 0.40 0.25 0.15 0.05 0.60 0.75 0.85 0.95 0.10 0.75 0.85 0.95 0.10  ...
]);


%load -ascii J5A
%data = J5A; clear J5A
%load -ascii J5T
%test = J5T; clear J5T
%score_ref = score_dags(test, ns, {bnet.dag}, 'bic')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% creation de la base de test
%  Ntest = 1000
%  test = cell(N,Ntest);
%  rand('state',0); randn('state',0);
%  for l=1:Ntest, test(:,l) = sample_bnet(bnet); end
%  
%  test = bnt_to_mat(test);
%  save -ascii J5T test


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% creation de la base d apprentissage
%  Napp = 1000
%  data = cell(N,Napp);
%  %rand('state',0); randn('state',0);
%  for l=1:Napp, data(:,l) = sample_bnet(bnet); end
%  
%  data = bnt_to_mat(data);
%  save -ascii J5A data
