function H_gens = Generations_entropy(inds_gens,Card,laplace)
% function H_gens = Generations_entropy(inds_gens,Card,laplace)
%
% Generations_entropy: Calculates the entropy accumulated by a
%                      set of individuals (population or selected individual) 
%                      at each generation of the EDA.
% INPUT
% inds_gens{maxgen} = A cell array with the population or the selected
%                     individual at each generation. It is obtained from
%                     Cache{1,:} or Cache{2,:}
% Card: Cardinalities of the variables
% laplace: Determines wether or not Laplace correction is used in the computation
% of the probabilities. Laplace=1 (It is used), otherwise  it is not.
%
% OUTPUT
% H_gens: It is an array with the calculated entropies at each generation.
% 
%
% Example:
% for i=1:maxgen
%   inds_gens{i}=Cache{1,i};
% end
% H_gens = Generations_entropy(inds_gens,Card,0);
% X = [1,maxgen]
% plot(X,H_gens);
%
% Last version 5/11/08. Carlos Echegoyen (carlos.echegoyen@ehu.es)

max_gen = size(inds_gens,2);

for i=1:max_gen
    H_gens(i) = Individuals_entropy(inds_gens{i},Card,laplace);
end
