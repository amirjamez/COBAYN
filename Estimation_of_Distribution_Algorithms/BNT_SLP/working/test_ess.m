dbstop if error
load asia2000
data = asiab; clear asiab;
[N, m] = size(data);
node_sizes = max(data');
order = 1:N;
prior = 0;
for i=1:N
  node_type{i} = 'tabular';
  if prior, params{i} = {'prior_type', 'dirichlet', 'dirichlet_weight', 1}; else, params{i} = {'prior', 1}; end
end

%dagk = learn_struct_K2(data, node_sizes, order);
dagk = learn_struct_mwst(data, 1:N, node_sizes, node_type);
bnetk = mk_bnet(dagk, node_sizes);
for i=1:N
  if prior
    bnetk.CPD{i} = tabular_CPD(bnetk, i, 'prior_type', 'dirichlet', 'dirichlet_type', 'unif');
  else
    bnetk.CPD{i} = tabular_CPD(bnetk, i);
  end
end
bnetk = learn_params(bnetk, data);

enginek = jtree_inf_engine(bnetk);
ess = get_espected_counts(mat_to_bnt(data), enginek);
[CPT, counts, nsamples] = CPT_from_bnet(bnetk);

for i=1:N
  ess{i}
  counts{i}
end
