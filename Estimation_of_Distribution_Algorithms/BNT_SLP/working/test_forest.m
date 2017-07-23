% test_forest

close all

%alpha=0.05

N=8
m=2000

C=[];
node_sizes=4*ones(1,N);

dag=mk_rnd_dag(N,1);
edges=find(dag==1);
deleting=randperm(N-1);
dag(edges(deleting([1,2])))=0;
dag

discrete=1:N;
bnet = mk_bnet(dag, node_sizes);
for i=1:N
  bnet.CPD{i} = tabular_CPD(bnet, i, 'prior_type', 'dirichlet', 'dirichlet_type', 'unif');
  node_type{i} = 'tabular';
end
data=zeros(i,m);
for j=1:m,
  dat = sample_bnet(bnet);
  data(:,j)=bnt_to_mat(dat);
end

% alpha = 0.1
%  scoring_fn='mutual_info';
%  forest = learn_struct_fan(data, node_sizes, C, scoring_fn, alpha);
forest = learn_struct_fan(data, node_sizes, C, 'mutual_info');

%  scoring_fn='bic';
%  forest_bic = learn_struct_fan(data, node_sizes, C, scoring_fn, alpha);
forest_bic = learn_struct_fan(data, node_sizes, C, 'bic');

label = cell(1,N);
for i=1:N, label{i}=num2str(i); end
figure;
subplot(1,3,1);
[xx,yy]=draw_graph(dag,label,zeros(1,N));
title('Original')
subplot(1,3,2);
draw_graph(forest,label,zeros(1,N),xx,yy);
title('Mutual Info')
subplot(1,3,3);
draw_graph(forest_bic,label,zeros(1,N),xx,yy);
title('BIC')



