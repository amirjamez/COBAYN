disp('Jouet33');
N=5;
dag = zeros(N);
dag(1,2)=1;
dag(2,[3 4])=1;
dag(4,5)=1;
dag(3,5)=1;
%[XX YY] = make_layout(dag);
%XX = XX+0.8*(XX-.5); YY = 1.3*(YY-.5)+.5;
%names = {'1','2','3','4','5','6','7','8'};
%carre = zeros(1,N);
%draw_graph(dag, names, carre, XX, YY);

%ns=2*ones(1,N);
ns = [3 4 5 3 6];
bnet = mk_bnet(dag, ns);
bnet.CPD{1} = tabular_CPD(bnet, 1, [0.2 0.1 0.7]);
bnet.CPD{2} = tabular_CPD(bnet, 2, [0.1 0.3 0.2 0.5    0.6 0.1 0.2 0.3    0.3 0.6 0.6 0.2]);
bnet.CPD{3} = tabular_CPD(bnet, 3, [0.1 0.2 0.3 0.4 0.5   0.05 0.4 0.1 0.1 0.2   0.7 0.05 0.1 0.3 0.1   0.15 0.35 0.5 0.15 0.2]);
bnet.CPD{4} = tabular_CPD(bnet, 4, [0.35 0.6 0.1   0.05 0.2 0.6   0.5 0.1 0.1   0.1 0.1 0.2]);
bnet.CPD{5} = tabular_CPD(bnet, 5, [0.05 0.15 0.05 0.20 0.4 0.01     0.15 0.10 0.20 0.01 0.02 0.04     0.01 0.00 0.05 0.10 0.01 0.15     0.04 0.20 0.10 0.04 0.07 0.20     0.25 0.05 0.30 0.15 0.15 0.05    0.09 0.10 0.01 0.10 0.35 0.15     0.01 0.30 0.05 0.30 0.8 0.10     0.40 0.10 0.25 0.10 0.15 0.30    0.15 0.10 0.20 0.01 0.02 0.4    0.01 0.00 0.05 0.10 0.01 0.15     0.04 0.20 0.10 0.04 0.07 0.20    0.25 0.05 0.30 0.15 0.15 0.05     0.09 0.10 0.5 0.10 0.35 0.5    0.01 0.30 0.9 0.30 0.2 0.10     0.40 0.10 0.25 0.3 0.15 0.30 ]);


%load -ascii J3A
%data = J3A; clear J3A
%load -ascii J3T
%test = J3T; clear J3T
%score_ref = score_dags(test, ns, {bnet.dag}, 'bic')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% creation de la base de test
%  Ntest = 1000
%  test = cell(N,Ntest);
%  rand('state',0); randn('state',0);
%  for l=1:Ntest, test(:,l) = sample_bnet(bnet); end
%  
%  test = bnt_to_mat(test);
%  save -ascii J3T test


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% creation de la base d apprentissage
%  Napp = 500
%  data = cell(N,Napp);
%  %rand('state',0); randn('state',0);
%  for l=1:Napp, data(:,l) = sample_bnet(bnet); end
%  
%  data = bnt_to_mat(data);
%  save -ascii J3A data
