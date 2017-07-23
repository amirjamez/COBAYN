disp('S2');
N=13;
dag=zeros(N);
dag(1,[4])=1;
dag(2,[1 3])=1;
dag(3,4)=1;
dag(4,7)=1;
dag(5,[4 6])=1;
dag(6, 7)=1;
dag(7,10)=1;
dag(8,[7 9])=1;
dag(9,[10])=1;
dag(10,[13])=1;
dag(11,[10 12])=1;
dag(12,[13])=1;

%draw_graph(dag);

node_sizes=0;
for i=1:N
 ss = rand;
 node_sizes(i)= 2+(ss>0.50)+(ss>0.85)+(ss>0.97);
end

%node_sizes = 2*ones(1,N)

ns = node_sizes;
bnet = mk_bnet(dag, node_sizes);
for i=1:N
  bnet.CPD{i} = tabular_CPD(bnet, i);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% creation de la base de test
%  if iterat==1
%  Ntest = 2000
%  test = cell(N,Ntest);
%  rand('state',0); randn('state',0);
%  for l=1:Ntest, test(:,l) = sample_bnet(bnet); end
%  
%  test = bnt_to_mat(test);
%  save -ascii J1T test
%  end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% creation de la base d apprentissage
%  Napp = sizeBD(ex)
%  data = cell(N,Napp);
%  for l=1:Napp, data(:,l) = sample_bnet(bnet); end
%  
%  data = bnt_to_mat(data);
%  save -ascii J1A data

