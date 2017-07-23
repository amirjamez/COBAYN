disp('Jouet4');
N=5;
dag = zeros(N);
dag(1,[5 4])=1;
dag(2,[3 4])=1;
dag(3,5)=1;
%[XX YY] = make_layout(dag);
%XX = XX+0.9*(XX-.5); YY = 1.4*(YY-.5)+.5;
%XX(3)=.45;
%names = {'1','2','3','4','5','6','7','8'};
%carre = zeros(1,N);
%draw_graph(dag, names, carre, XX, YY);

%ns=2*ones(1,N);
ns = [3 4 3 4 3];
bnet = mk_bnet(dag, ns);
bnet.CPD{1} = tabular_CPD(bnet, 1, [0.2 0.5 0.3]);
bnet.CPD{2} = tabular_CPD(bnet, 2, [0.1 0.2 0.3 0.4]);
bnet.CPD{3} = tabular_CPD(bnet, 3, [0.3 0.3 0.05    0.45 0.2 0.05    0.4 0.2 0.5   0.75 0.65 0.35]);
bnet.CPD{4} = tabular_CPD(bnet, 4, [0.5 0.2 0.05 0.2   0.10 0.75 0.25 0.1   0.25 0.40 0.1 0.5   0.3 0.15 0.35 0.9   0.05 0.75 0.85 0.2   0.7 0.4 0.1 0.4   0.3 0.15 0.6 0.05   0.4 0.3 0.5 0.1   0.5 0.5 0.5 0.3   0.7 0.2 0.1 0.4   0.6 0.9 0.1 0.8   0.05 0.75 0.85 0.2]);
bnet.CPD{5} = tabular_CPD(bnet, 5, [0.25 0.15 0.05   0.60 0.75 0.85   0.95 0.40 0.1   0.25 0.15 0.05   0.60 0.75 0.85   0.95 0.40 0.1   0.5 0.2 0.05   0.6 0.2 0.8   0.3 0.8 0.6]);


%load -ascii J4A
%data = J4A; clear J4A
%load -ascii J4T
%test = J4T; clear J4T
%score_ref = score_dags(test, ns, {bnet.dag}, 'bic')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% creation de la base de test
%  Ntest = 1000
%  test = cell(N,Ntest);
%  rand('state',0); randn('state',0);
%  for l=1:Ntest, test(:,l) = sample_bnet(bnet); end
%  
%  test = bnt_to_mat(test);
%  save -ascii J4T test


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% creation de la base d apprentissage
%  Napp = 1000
%  data = cell(N,Napp);
%  %rand('state',0); randn('state',0);
%  for l=1:Napp, data(:,l) = sample_bnet(bnet); end
%  
%  data = bnt_to_mat(data);
%  save -ascii J4A data
