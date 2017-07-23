function [Table] = CreateNKFunctions(ListFactors)
% [Table] = CreateNKFunctions(ListFactors)
% CreateNKFunctions:    Generates random values for the table entries of the NK landscape  
% INPUTS
% ListFactors: Each  row i stores the numb variables in the factor (k+1), the
%              current variable (i), and its k neighbors
% OUTPUTS
% Tables{i}: Contains the values for each of the 2^k configurations of
%            factor 
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es) 

totfactors = size(ListFactors,1);

for i=1:totfactors
 Table{i} = rand(1,2^ListFactors(i,1)); %We assume variables have binary cardinality 
end,