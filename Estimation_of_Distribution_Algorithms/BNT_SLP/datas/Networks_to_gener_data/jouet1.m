disp('Jouet 1');
N=5;
dag=zeros(N);
dag(1,2)=1;
dag(2,[3 4])=1;
dag(4,5)=1;
%draw_graph(dag);

node_sizes= [2 3 4 5 2]; ns = node_sizes;
bnet = mk_bnet(dag, node_sizes);
bnet.CPD{1} = tabular_CPD(bnet, 1, [0.2 0.8]);
bnet.CPD{2} = tabular_CPD(bnet, 2, [0.1 0.6 0.3 0.9 0.4 0.7]);
bnet.CPD{3} = tabular_CPD(bnet, 3, [0.3 0.5 0.7 0.2   0.2 0.1 0.05 0.5   0.5 0.4 0.25 0.3]);
bnet.CPD{4} = tabular_CPD(bnet, 4, [0.35 0.05 0.65 0.15 0.25  0.15 0.15 0.10 0.25 0.45  0.5 0.8 0.25 0.6 0.3]);
bnet.CPD{5} = tabular_CPD(bnet, 5, [0.25 0.15  0.15 0.25  0.10 0.15  0.2 0.05  0.3 0.4]);

%load -ascii J1A
%data = J1A; clear J1A
%load -ascii J1T
%test = J1T; clear J1T
%score_ref = score_dags(test, ns, {bnet.dag}, 'bic')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% creation de la base de test
%  Ntest = 500
%  test = cell(N,Ntest);
%  rand('state',0); randn('state',0);
%  for l=1:Ntest, test(:,l) = sample_bnet(bnet); end
%  
%  test = bnt_to_mat(test);
%  save -ascii J1T test


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% creation de la base d apprentissage
%  Napp = 300
%  data = cell(N,Napp);
%  %rand('state',0); randn('state',0);
%  for l=1:Napp, data(:,l) = sample_bnet(bnet); end
%  
%  data = bnt_to_mat(data);
%  save -ascii J1A data
