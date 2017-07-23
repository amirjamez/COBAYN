function[ListFactors] = ReadFactorGraphFromData(filename)
% [ListFactors] = ReadFactorGraphFromData(filename)
% ReadFactorGraphFromData:    Reads the  structure  of a given function from a file 
% INPUTS
% filename:  file of name 'filename' with the following format:
%
%    Total number of nodes
%    Total number of variable  nodes
%    for i=1 to Total number of variables nodes
%      Variable node (for C compatibility i-1 instead of i is printed to the file) 
%      Cardinality of variable node i
%    end
%    Number of edges in the factor graph
%    for i=1 to Total number of edges
%      variable node incident to  edge i
%      factor node incident to  edge i
%    end
% OUTPUTS
% ListFactors: Each  cell  {i} stores the variables in the factor
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es) 

fid = fopen(filename,'r');

AllEntries = fscanf(fid,'%d');
fclose(fid);

NumberVar = AllEntries(2);  % Number of variable nodes
 

totfactors = AllEntries(1) - NumberVar; % Number of factor nodes

for i=1:totfactors,
 ListFactors{i} = [];
end,

Card = AllEntries([4:2:2*NumberVar+2]);
firstfact = 2*NumberVar+3;
NumberEdges = AllEntries(firstfact);
 
edges = AllEntries(firstfact+1:end);

for i=1:2:size(edges,1)
 aux = ListFactors{edges(i+1)-totfactors+1};
 aux = [aux,edges(i)+1];
 ListFactors{edges(i+1)-totfactors+1} = aux;
end


