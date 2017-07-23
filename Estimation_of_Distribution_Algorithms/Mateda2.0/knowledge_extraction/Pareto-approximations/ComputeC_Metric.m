function[CA,CB] = ComputeC_Metric(PopA,PopB) 
% [CA,CB] = ComputeC_Metric(PopA,PopB) 
% ComputeC_Metric: Computes the C metric between two Pareto set
% approximations
% INPUTS
% PopA: First population, Each row corresponds to a vector
% PopB: Second population, Each row corresponds to a vector
% OUTPUTS
% CA: C(A,B) Proportion of vectors in PopB which are dominated by at leat
% one vector in PopA
% CB: C(B,A) 
%
% Last version 2/26/2009. Roberto Santana (roberto.santana@ehu.es)

 psizeA = size(PopA,1);
 psizeB = size(PopB,1);
 
 Index = FindParetoSet([PopA;PopB],[PopA;PopB]);
 CA = (psizeB-sum(Index>psizeA))/psizeB; 
 
  Index = FindParetoSet([PopB;PopA],[PopB;PopA]);
 CB = (psizeA-sum(Index>psizeB))/psizeA; 
 