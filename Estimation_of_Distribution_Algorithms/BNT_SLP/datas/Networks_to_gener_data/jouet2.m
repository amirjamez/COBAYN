disp('Jouet2');
N=6;
dag = zeros(N);
dag(1,[2,3])=1;
dag(2,4)=1;
dag(3,[5 6])=1;
%[XX YY] = make_layout(dag);
%XX = XX+0.5*(XX-.5); YY = 1.3*(YY-.5)+.5;
%names = {'1','2','3','4','5','6','7','8'};
%carre = zeros(1,N);
%draw_graph(dag, names, carre, XX, YY);

%ns=2*ones(1,N);
ns = [2 3 4 5 6 4];
bnet = mk_bnet(dag, ns);
bnet.CPD{1} = tabular_CPD(bnet, 1, [0.2 0.8]);
bnet.CPD{2} = tabular_CPD(bnet, 2, [0.1 0.3 0.6   0.9 0.7 0.4]);
bnet.CPD{3} = tabular_CPD(bnet, 3, [0.2 0.7 0.5 0.9   0.8 0.3 0.05 0.9]);
bnet.CPD{4} = tabular_CPD(bnet, 4, [0.35 0.05 0.2 0.4 0.7    0.25 0.45 0.5 0.2 0.1   0.4 0.5 0.3 0.4 0.2]);
bnet.CPD{5} = tabular_CPD(bnet, 5, [0.25 0.15 0.4 0.6 0.8 0.2    0.15 0.35 0.2 0.1 0.05 0.3  0.4 0.1 0.1 0.2 0.1 0.4  0.2 0.4 0.3 0.1 0.05 0.1]);
bnet.CPD{6} = tabular_CPD(bnet, 6, [0.2 0.3 0.1 0.6   0.1 0.4 0.2 0.1    0.0 0.1 0.6 0.2    0.7 0.2 0.1 0.1]);

%load -ascii J2A
%data = J2A; clear J2A
%load -ascii J2T
%test = J2T; clear J2T
%score_ref = score_dags(test, ns, {bnet.dag}, 'bic')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% creation de la base de test
%  Ntest = 500
%  test = cell(N,Ntest);
%  rand('state',0); randn('state',0);
%  for l=1:Ntest, test(:,l) = sample_bnet(bnet); end
%  
%  test = bnt_to_mat(test);
%  save -ascii J2T test


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% creation de la base d apprentissage
%  Napp = 300
%  data = cell(N,Napp);
%  %rand('state',0); randn('state',0);
%  for l=1:Napp, data(:,l) = sample_bnet(bnet); end
%  
%  data = bnt_to_mat(data);
%  save -ascii J2A data
