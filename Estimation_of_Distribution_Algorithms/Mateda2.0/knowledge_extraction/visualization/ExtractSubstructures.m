function[AllRepVectors] = ExtractSubstructures(run_structures,RepEdges,NumbRep)
% [AllRepVectors] = ExtractSubstructures(run_structures,RepEdges,NumbRep)
% ExtractSubstructures: From the set of all the structures learned in all
%                       runs, extracts those substructures corresponding to
%                       the edges passed in viewparams{1}.
%                       One substructure is extracted if it contains at least
%                       viewparams{2}>0 edges.
% INPUT
% run_structures: Contain the data structures with all the structures
% learned by the probability models in every run and generation (see
% program ReadStructures.m for details.
% RepEdges: Indices of the edges that will be extracted
% NumbRep: Minimal number of edges (of those in viewparams{1}) that have
%                to be in the structure to extracted.
% OUTPUT
% AllRepVectors: Subset of structures selected for visualization
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)    


AllBigMatrices = run_structures{2};

nruns = size(AllBigMatrices,2);
maxgen = size(AllBigMatrices{1},2);

AllRepVectors = [];

for i=1:nruns,
  for j=1:maxgen,
   AuxVector = [AllBigMatrices{i}(RepEdges,j)];
   if sum(AuxVector)> NumbRep
      AllRepVectors = [AllRepVectors;[j*AuxVector]'];
   end
  end, 
end,  


