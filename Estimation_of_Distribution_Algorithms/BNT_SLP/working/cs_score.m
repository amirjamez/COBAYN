function [PDG, PD2G, PD2Gtheta, PDGtheta] = cs_score(data, dag, ns, data_mat)
%  [PDG, PD2G, PD2Gtheta, PDGtheta] = cs_score(data, dag, node_sizes, data_mat)
%
% Compute ln P(D|G) = ln P(D'|G) - ln P(D'|G,^Theta) + ln P(D|G,^Theta)
%
% where D' is a completion of the cell array data
%  that respect the essential statistics in data
%
% INPUTS :
%   - data{i,m},    node i in case m (cell array)
%   - dag,          adjacent graph to score
%   - node_sizes,   vector containing sizes of nodes
%   - data_mat,     a completion of data that respect the essential statistics in data (optionnal)
%               --> not to recompute this all of time
%
% OUTPUTS :
%   - PDG       = ln P(D|G)         --> MAP approximation of Cheesement and Stuntz formula
%   - PD2G      = ln P(D'|G)        --> compute using Heckerman
%   - PD2Gtheta = ln P(D'|G,^theta) --> sum of logs of thetas
%   - PDGtheta  = ln P(D|G,^theta)  --> sum of logs of sum of marginals
% 
% for discretes variables
%
% francois.olivier.c.h@gmail.com

[N, m]=size(data);
verbose = 1;
max_iter = 8;
thresh = 2e-3;
%test = 'LRT'; % 'pearson'

mm=0;
PM=1;

if nargin < 3 | mm==1,
  misv = -9999;
  data_m = bnt_to_mat(data,misv);
  ns=max(data_m');
  %clear data_m misv
  long = size(data_m,2);
end

% -> apprentissage des params

bnet = mk_bnet(dag, ns);
for i = 1:N
  bnet.CPD{i}=tabular_CPD(bnet, i, 'prior_type', 'dirichlet', 'dirichlet_type', 'unif');
end
engine = jtree_inf_engine(bnet);
[bnet, LLtrace, engine] = learn_params_em(engine, data, max_iter, thresh);

% -> faire data2
if nargin < 4,
  [data_mat, LLik, logP] = fill_in_by_inference(data, engine);
end

bnet2 = mk_bnet(dag, ns);
for i = 1:N
  bnet2.CPD{i}=tabular_CPD(bnet, i, 'prior_type', 'dirichlet', 'dirichlet_type', 'unif');
end
bnet2 = learn_params(bnet, data_mat);

[CPT, counts, nsamples] = CPT_from_bnet(bnet, verbose);
[CPT2, counts2, nsamples] = CPT_from_bnet(bnet, verbose);

% POUR V�RIFIER QUE L'ON A BIEN LES MM STATISTIQUES ESSENTIELLES
if 0,
  res=1;
  for i =1:N
    res=res*(prod(counts{i}==counts2{i}));
  end
  if res == 0, error('ca deconne ... ??'); end
end

% -> CALCUL DU SCORE
% ln P(D|G) = ln P(D'|G) - ln P(D'|G,^Theta) + ln P(D|G,^Theta)

%ln P(D'|G)
PD2G = 0;
% Utilisation de Heckerman
PD2G = score_dags(data_mat, ns, {dag}); % see log_marg_prob_node.m

% ln P(D'|G,^Theta)
PD2Gtheta = 0;
% incorpore dans la boucle suivante
%for l = 1:m
%  evidence2 = data_mat(:,l)';
%  P2 = compute_prob(bnet2.dag, ns, CPT2, evidence2);
%  PD2Gtheta = PD2Gtheta + log(P2);
%end

%ln P(D|G,^Theta)
PDGtheta = 0;    % fill_in_by_inference ??
for l = 1:m
  evidence = data(:,l)';
  evidence2 = data_mat(:,l)';
  hidden = find(isemptycell(evidence));
  if ~isempty(hidden)
    continu = 1;
    cas = ones(size(hidden));
    P = 0;
    while continu
      if iscell(evidence)
	evidence = bnt_to_mat(evidence);
      end
      evidence(hidden) = cas;
      P = P + compute_prob(bnet.dag, ns, CPT, evidence);
      [cas, continu] = next_case(cas, ns(hidden));
    end

    if mm,
      tmp = 1:long;
      for nh = hidden
	tmp2 = find(data_m(nh,:)==misv);
	tmp = intersect(tmp, tmp2);
      end
      clear tmp2
      PM = length(tmp)/long;
    end
    PDGtheta = PDGtheta + log(P) + log(PM);

    P2 = compute_prob(bnet2.dag, ns, CPT2, evidence2);
    PD2Gtheta = PD2Gtheta + log(P2);
  else
    P = compute_prob(bnet.dag, ns, CPT, evidence);
    PDGtheta = PDGtheta + log(P);

    if 0,
      P2 = compute_prob(bnet2.dag, ns, CPT2, evidence2);
      if P~=P2, error('P different de P2 !!!'); end
    end
    PD2Gtheta = PD2Gtheta + log(P);
  end
end

if verbose, PD2G, PD2Gtheta, logP, PDGtheta,LLik, end,
PDG = PD2G - PD2Gtheta + PDGtheta;
