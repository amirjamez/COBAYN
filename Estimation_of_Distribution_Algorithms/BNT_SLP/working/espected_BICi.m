function BICi = espected_BICi(bnet, i, esc, m, d)
% BICi = espected_BIC(bnet, esc, m, nparams)
%
% INPUTS :
%   bnet - the current bayesian network
%   esc - the espected counts of the dataset
%   m - [optionnal] the number of examples in the dataset
%   nparams - dimension of the family of the node i
%
% OUTPUTS :
%   BICi - the espected BIC score of the node i given the dataset
%

if nargin<4, m = esc{1}; while length(m)>1, m = sum(m); end, end
if nargin<5, [D, d] = compute_bnet_nparams(bnet); d = d(i); end
tiny = exp(-700);
CPT = CPT_from_bnet(bnet);
dag = bnet.dag;
ns = bnet.node_sizes;
N = size(ns,2);
cas = ones(1,N);
continu = 1;
BICi=0;
while continu
  [p, indice] = compute_prob(dag, ns, CPT, cas);
  BICi = BICi + esc{i}(indice(i))*log(CPT{i}(indice(i))+tiny);
  [cas, continu] = next_case(cas, ns);  
end
BICi = BICi-d*log(m)/2;
