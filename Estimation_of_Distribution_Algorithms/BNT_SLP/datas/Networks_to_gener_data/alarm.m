disp('alarm');
bnet = mk_alarm_bnet;
ns = bnet.node_sizes;

N = length(bnet.dag)

load -ascii alarmA
data = alarmA; clear alarmA
load -ascii alarmT
test = alarmT; clear alarmT
score_ref = score_dags(test, ns, {bnet.dag}, 'bic')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% creation de la base de test
%  Ntest = 3000
%  test = cell(N,Ntest);
%  rand('state',0); randn('state',0);
%  for l=1:Ntest, test(:,l) = sample_bnet(bnet); end
%  
%  test = bnt_to_mat(test);
%  save -ascii alarmT test


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% creation de la base de test
%  Napp = 6000
%  data = cell(N,Napp);
%  %rand('state',0); randn('state',0);
%  for l=1:Napp, data(:,l) = sample_bnet(bnet); end
%  
%  data = bnt_to_mat(data);
%  save -ascii alarmA data
