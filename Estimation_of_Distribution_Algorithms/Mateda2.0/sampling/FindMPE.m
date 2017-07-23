 function[mpe_solution,prob_value] =  FindMPE(bnet)
% [mpe_solution,prob_value] =  FindMPE(bnet):   
%                           Computes the most probable explanation given the Bayesian network
% INPUTS 
% bnet:                Bayesian network
% OUTPUTS
% mpe_solution: Most probable explanation
% prob_value:  Its corresponding probability value
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)  

 n = size(bnet.dag,1); % number of nodes
 
 engine = jtree_inf_engine(bnet, 'maximize', 1);
 for i=1:n,
  auxvar{i} = [];           %      All variables are hidden
 end,
 mpe_solution = find_mpe(engine,auxvar);
 [eng, logprob] = enter_evidence(engine, mpe_solution);
 prob_value = exp(logprob);
 