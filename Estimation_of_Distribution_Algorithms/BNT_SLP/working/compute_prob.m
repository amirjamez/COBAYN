function [p, indice] = compute_prob(dag, node_sizes, CPT, cas)
% Compute P(X1=a,...,Xn=z) for the sub-jacente law from the pair <dag, CPT>
%
%   p = compute_prob(dag, node_sizes, CPT, cas)
%

N = size(dag,1);
p = 1;
indice = ones(1,N);
for n = 1:N
  fam = find(dag(:,n))';
  pred = [];
  for c = fam
    if isempty(pred)
      indice(n) = cas(c);
    else
      indice(n) = indice(n) + (cas(c)-1)*prod(node_sizes(pred));
    end
    pred = myunion(pred,c);
  end  
  indice(n) = indice(n) + (cas(n)-1)*prod(node_sizes(pred));
  p = p*CPT{n}(indice(n));
end
