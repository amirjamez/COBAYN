function [Table] = CreateRandomFunctions(ListFactors,Card)
% [Table] = CreateRandomFunctions(ListFactors,Card)
% CreateRandomFunctions:    Generates random values for the table entries of the structure defined in ListFactors 
% INPUTS
% ListFactors: Each  row i stores the variables in the factor
% Card: Cardinalities of the variables
% OUTPUTS
% Tables{i}: Contains the values for each of the configurations of factor i 
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es) 

totfactors = size(ListFactors,2);

for i=1:totfactors
 sizeTable = 1;
 for j=1:size(ListFactors{i},2)
  sizeTable = sizeTable * Card(ListFactors{i}(j)); 
  Table{i} = rand(1,sizeTable); %Random between 0 and 1 values are assigned to the entries 
 end,
end,