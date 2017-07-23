function[Pop]=seeding_unitation_constraint(n,PopSize,Card,seeding_pop_params)
% [Pop]=seeding_unitation_constraint(n,PopSize,Card,seeding_pop_params)
% seeding_unitation_constraint:  generates a population of binary vectors 
%                               where all vectors have the same number of
%                               ones passed in seeding_pop_params{1}
% INPUTS 
% n:                   Number of Variables
% PopSize:             Population size
% Card:                Cardinality of the variables
% seeding_pop_params{1} = Number_of_Ones \in [1,n-1]:  Number of ones in each binary solution 
% OUTPUTS
% Pop:                 Seeded population

 Number_of_Ones = seeding_pop_params{1};
 Pop = zeros(PopSize,n);
 
 for i=1:PopSize
  auxperm = randperm(n);  
  Pop(i,auxperm(1:Number_of_Ones)) = 1;   
 end
 
return
 
 
 