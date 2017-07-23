% learn the structure of "alarm" network. The learning time is so long!

rand('state', 0);
randn('state', 0);

bnet = mk_alarm_bnet;
dag = bnet.dag;
N = length(dag);
ns = bnet.node_sizes;

nsamples = 500;
samplesM = cell(N, nsamples);
for i=1:nsamples
  samplesM(:,i) = sample_bnet(bnet);
end

hide = rand(N, nsamples) > 0.9;
[I,J]=find(hide);
for k=1:length(I)
  samplesM{I(k), J(k)} = [];
end

engine = jtree_inf_engine(bnet);
[bnet, LL, engine] = learn_params_em(engine, samplesM, 1);
LL

G0 = zeros(N,N);
for i=1: N-1
   G0(i, i+1) = 1;
end
figure(1);
draw_graph(G0);

B0 = mk_bnet(G0, ns);
% use random params
for i=1:N
  B0.CPD{i} = tabular_CPD(B0, i, 'prior_type', 'dirichlet', 'dirichlet_weight', 0);
end

max_loop = 30;
%profile on -detail mmex
[B0, order, best_score] = learn_struct_EM(B0, samplesM, max_loop);
%profile report
G1 = B0.dag;

G0 = G1(order, order);

