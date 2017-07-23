function[bn_fit_corr] =  BN_Fitness_Corr(bnet,Pop,FunVal)
% [bn_fit_corr] =  BN_Fitness_Corr(bnet,Pop,FunVal):   
% BN_Fitness_Corr:          Computes the correlation between the probabilities given to the solutions by the
%                           networks and the fitness values of the  solutions
% INPUTS 
% bnet:                Bayesian network
% Pop:                 Population
% FunVal:             Evaluation vector for each of the objectives
% OUTPUTS
% bn_fit_corr: Vector of correlations for each of the objectives.
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)  


 [Prob] =  BN_Pop_Prob(bnet,Pop);
 
 number_objectives = size(FunVal,2);
 
 for i=1:number_objectives,
  bn_fit_corr(i) = corr(Prob,FunVal(:,i));
 end,
 

 
 