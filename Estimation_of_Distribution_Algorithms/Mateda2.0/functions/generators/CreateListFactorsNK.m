function [ListFactors] =  CreateListFactorsNK(NumberVar,k)
% [ListFactors] =  CreateListFactorsNK(NumberVar,k)
% CreateListFactorsNK:   Creates the structure of an instance of the NK random landscape 
%                        The neihbors for each of the variables are
%                        randomly selected
% INPUTS
% NumbVar: Number of variables 
% k: Number of neighbors (0<k<NumbVar)
% OUTPUTS
% ListFactors: Each  cell {i} stores the current variable (i), and its k neighbors
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       

for i=1:NumberVar,
 PotentialNeighbors = randperm(NumberVar-1);
 aux = [[1:i-1],[i+1:NumberVar]];
 PotentialNeighbors = aux(PotentialNeighbors);
 ActualNeighbors = PotentialNeighbors(1:k);
 ListFactors{i} = [i,ActualNeighbors];
end,
