function S_H = Individuals_entropy(Inds,Card,laplace)
%
% function S_H = Individuals_entropy(Inds,Card,laplace)
%
% Population_entropy: This function calculates the accumulated entropy  for all
%                     the variables in a given set of individual. It can be
%                     the whole population or the selected individuals.
%
% INPUT
% Inds: Population or selected individuals. It is obtained from Cache{1,gen}
%       or Cache{2,gen} respectively
% Card: Cardinalities of the variables
% laplace: Determines wether or not Laplace correction is used in the computation
% of the probabilities. laplace=1 (It is used), otherwise  it is not.
%
% OUTPUT
% S_H: The accumulate entropy value.
%
% Example:
% Pop = Cache{1,1};
% Inds_sel = Cache{2,1}; 
% S_H_pop = Individuals_entropy(Inds,Card,1);
% S_H_sel = Individuals_entropy(Inds_sel,Card,1);
%
% Last version 5/11/08. Carlos Echegoyen (carlos.echegoyen@ehu.es) 

num_vars = size(Inds,2);

S_H = 0;

for i=1:num_vars
    min = 0;
    max = Card(i)-1;
    S_H = S_H + entropy(Inds(:,i),min,max,laplace);
end
