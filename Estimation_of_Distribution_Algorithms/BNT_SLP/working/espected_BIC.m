function [BIC, BICi] = espected_BIC(bnet, esc, m)
% [BIC, BICi] = espected_BIC(bnet, esc, m)
%
% INPUTS :
%   bnet - the current bayesian network
%   esc - the espected counts of the dataset
%   m - [optionnal] the number of examples in the dataset
%
% OUTPUTS :
%   BIC - the espected BIC score of the bnet given the dataset
%   BICi - the espected BIC score of the node i given the dataset
%

if nargin<3, m = esc{1}; while length(m)>1, m = sum(m); end, end
tiny = exp(-700);
CPT = CPT_from_bnet(bnet);
[D, d] = compute_bnet_nparams(bnet);
dag = bnet.dag;
ns = bnet.node_sizes;
N = size(ns,2);

cas = ones(1,N);
BICi = zeros(1,N);
continu = 1;
while continu
  [p, indice] = compute_prob(dag, ns, CPT, cas);
  for i=1:N
    BICi(i) = BICi(i) + esc{i}(indice(i))*log(CPT{i}(indice(i))+tiny);
  end
  [cas, continu] = next_case(cas, ns);  
end

BICi = BICi-d*log(m)/2;
BIC = sum(BICi);