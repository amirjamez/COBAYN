disp('asia');
bnet = mk_asia_bnet;
ns = bnet.node_sizes;

N = length(bnet.dag)

%load -ascii asiaA
%data = asiaA; clear asiaA
%load -ascii asiaT
%test = asiaT; clear asiaT
%score_ref = score_dags(test, ns, {bnet.dag}, 'bic')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% creation de la base de test
%  Ntest = 1000
%  test = cell(N,Ntest);
%  rand('state',0); randn('state',0);
%  for l=1:Ntest, test(:,l) = sample_bnet(bnet); end
%  
%  test = bnt_to_mat(test);
%  save -ascii asiaT test


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% creation de la base d apprentissage
%  Napp = 2000
%  data = cell(N,Napp);
%  %rand('state',0); randn('state',0);
%  for l=1:Napp, data(:,l) = sample_bnet(bnet); end
%  
%  data = bnt_to_mat(data);
%  save -ascii asiaA data
