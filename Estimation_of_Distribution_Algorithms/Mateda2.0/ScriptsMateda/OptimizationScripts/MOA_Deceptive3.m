 % EXAMPLE 3: MOA algorithm with exponential selection for Goldberg's deceptive function  
 PopSize = 500; n = 30; cache  = [0,0,0,0,0]; Card = 2*ones(1,n); Temp = 1.0;
 F = 'evalfuncdec3'; 
 edaparams{1} = {'replacement_method','elitism',{10,'fitness_ordering'}};
 edaparams{2} = {'selection_method','exp_selection',{2}};
 MK_params(1:5) = {{},8,1.5,'Boltzman_linear',1.0};
 edaparams{3} = {'learning_method','LearnMOAModel',MK_params};
 edaparams{4} = {'sampling_method','MOAGeneratePopulation',{PopSize,10}};
 [AllStat,Cache]=RunEDA(PopSize,n,F,Card,cache,edaparams) 