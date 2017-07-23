function [ListFactorsCard] = FindListCard(ListFactors,Card)
% [ListFactorsCard] = FindListCard(ListFactors,Card)
% FindListCard:  For each factor of variables gives the corresponding
%                accumulate cardinality 
% INPUT:
% ListFactors: Each  cell  {i} stores the variables in the factor
% Card: Cardinality of the variables
% OUTPUT: 
% ListFactorsCard: For each factor of variables stores the corresponding
%                  accumulate cardinality 
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       


for i=1:size(ListFactors,2)
 ListFactorsCard{i} = FindAccCard(size(ListFactors{i},2),Card(ListFactors{i}));
end
     