function [ListFactors] =  CreateListFactorsCircularNK(NumberVar,k)
% [ListFactors] =  CreateListFactorsCircularNK(NumberVar,k)
% CreateListFactorsCircularNK:   Creates the structure of an instance of the NK landscape 
%                                where each variable depends on its k/2
%                                previous and k/2 subsequent neighbors in a
%                                circular way
% INPUTS
% NumbVar: Number of variables 
% k: Number of neighbors (0<k<NumbVar)
% OUTPUTS
% ListFactors: Each  cell {i} stores the current variable (i), and its k neighbors
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       
for i=1:NumberVar,
 ActualNeighbors = [i-k/2:i-1,i+1:i+k/2];
 ind = find(ActualNeighbors<=0);
 if ~isempty(ind)
  ActualNeighbors(ind) = ActualNeighbors(ind) + NumberVar;
 end
 ind = find(ActualNeighbors>NumberVar);
 if ~isempty(ind)
  ActualNeighbors(ind) = ActualNeighbors(ind) - NumberVar;
 end
 ListFactors{i} = [i,ActualNeighbors];
end,
