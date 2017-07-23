function[Table] = LaplaceEstimator(totcliq,NPoints,Table)
% LaplaceEstimator(totcliq,NPoints,Table)
% LaplaceEstimator modifies the probability tables using the Laplace estimator  
% INPUTS:
% totcliq: Number of cliques
% NPoints: Number of elements in the original (or desired) data set
% Table: Cell array storing the probability tables for each of the cliques.
% 
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)  
for i=1:totcliq,
      cardcliq = size(Table{i},1);      
      Table{i} =  (Table{i} * NPoints + 1) / (NPoints+ cardcliq);
    end
  

