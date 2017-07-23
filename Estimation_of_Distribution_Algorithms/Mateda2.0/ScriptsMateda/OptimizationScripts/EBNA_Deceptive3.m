% EXAMPLE 2: Goldberg's deceptive function; BN K2 algorithm with BIC metric
%            Proportional selection
 PopSize = 500; n = 60; cache  = [0,0,0,0,0]; Card = 2*ones(1,n);
 F = 'evalfuncdec3'; 
 edaparams{1} = {'replacement_method','elitism',{10,'fitness_ordering'}};
 edaparams{2} = {'selection_method','prop_selection',[]};
 BN_params(1:6) = {'k2',10,0.05,'pearson','bic','no'};
 edaparams{3} = {'learning_method','LearnBN',BN_params};
 [AllStat,Cache]=RunEDA(PopSize,n,F,Card,cache,edaparams) 

