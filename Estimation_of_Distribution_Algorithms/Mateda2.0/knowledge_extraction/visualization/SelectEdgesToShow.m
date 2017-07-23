function[sel_edges] = SelectEdgesToShow(run_structures,const_edg)
% [sel_edges] = SelectEdgesToShow(run_structures,const_edg)
% SelectEdgesToShow:    From the set of all the structures learned in all
%                       runs, extracts those edges (the indices) that were
%                       learned at least const_edg times
% INPUT
% run_structures: Contain the data structures with all the structures
% learned by the probability models in every run and generation (see
% program ReadStructures.m for details.
% const_edg: Number of times that an edge has to be in the learned
% structures to be selected.
% OUTPUT
% sel_edges: Indices of the edges that will be extracted
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)

AllSumMatrices = run_structures{3};

sel_edges = find(sum(AllSumMatrices')> const_edg); 
    
    