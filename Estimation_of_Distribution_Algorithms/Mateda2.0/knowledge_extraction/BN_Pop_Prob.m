function[Prob] =  BN_Pop_Prob(bnet,Pop)
% [Prob] =  BN_Pop_Prob(bnet,Pop):   
% BN_Pop_Prob:      Computes the probabilities given to the solutions in Pop by the
%                   networks 
% INPUTS 
% bnet:                Bayesian network
% Pop:                 Population
% OUTPUTS
% Prob: Vector with the probabilities given by Bayesian network to each of
% the solutions
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)  

PopSize = size(Pop,1);
 
engine = jtree_inf_engine(bnet, 'maximize', 1);
 
 for i=1:PopSize,
   vect = num2cell(Pop(i,:)+1);
   [eng, logprob] = enter_evidence(engine,vect);
   Prob(i,1) = exp(logprob);
 end