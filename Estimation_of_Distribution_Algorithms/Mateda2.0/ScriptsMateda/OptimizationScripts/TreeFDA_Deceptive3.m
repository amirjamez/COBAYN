% EXAMPLE 17: Goldberg's deceptive function; Tree EDA algorithm
%            Proportional selection

 PopSize = 500; n = 60; cache  = [0,0,0,0,0]; Card = 2*ones(1,n);
 F = 'evalfuncdec3'; 
 edaparams{1} = {'replacement_method','elitism',{10,'fitness_ordering'}};
 edaparams{2} = {'selection_method','prop_selection',[]};
 edaparams{3} = {'learning_method','LearnTreeModel',{}};
 edaparams{4} = {'sampling_method','SampleFDA',{PopSize}}; 
 
 [AllStat,Cache]=RunEDA(PopSize,n,F,Card,cache,edaparams) 
