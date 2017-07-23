% test_forest_EM

close all

%alpha=0.05

N=6
m=4000

proba = 0.2;
class=[];
Tmp=mysetdiff(1:N,class);
root=randperm(length(Tmp));
root=Tmp(root(1));
prior = 0;
nbloopmax = 6;
thresh = 1e-3;

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
data=cell(N,m);
for j=1:m,
  dat = sample_bnet(bnet);
  for i=1:N
    if rand>proba, data(i,j)=dat(i); end % else we leave it empty/missing
  end
end

forest = learn_struct_fan_EM(data, class, node_sizes, root, prior, nbloopmax, thresh)

label = cell(1,N);
for i=1:N, label{i}=num2str(i); end
figure;
subplot(1,2,1);
[xx,yy]=draw_graph(dag,label,zeros(1,N));
title('Original')
subplot(1,2,2);
draw_graph(forest,label,zeros(1,N),xx,yy);
title('BIC-EM')



