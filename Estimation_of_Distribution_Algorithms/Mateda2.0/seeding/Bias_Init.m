function[Pop]=Bias_Init(n,PopSize,Card,seeding_pop_params)
% [Pop]=Bias_Init(n,PopSize,Card,seeding_pop_params)
% Bias_Init:  Biased initialization of a population of binary vectors,    
%             where the probability of generating 1 is p  and the probability of generating 0 
%             is  1-p.
% INPUTS 
% n:                   Number of Variables
% PopSize:             Population size
% Card:                Cardinality of the variables
% seeding_pop_params{1} = p:  Probability of generating 1 
% OUTPUTS
% Pop:                 Seeded population
% EXAMPLE
% [Pop]=Bias_Init(10,15,2*ones(1,10),{0.8});
%
% Last version 11/10/2008. Ruben Armananzas and Roberto Santana (roberto.santana@ehu.es)     

 p = seeding_pop_params{1};
 
 Pop = rand(PopSize,n) <= p;
 
return
 
 
 