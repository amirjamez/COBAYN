 % EXAMPLE 4:  Aff_EDA with proportional selection and elitism 1
 PopSize = 500; n = 30; cache  = [0,0,0,0,0]; Card = 2*ones(1,n); 
 F = 'evalfuncdec3'; 
 edaparams{1} = {'replacement_method','elitism',{1,'fitness_ordering'}};
 edaparams{2} = {'selection_method','prop_selection',{2}};
 Aff_params(1) = {8};
 edaparams{3} = {'learning_method','LearnMargProdModel',Aff_params};
 edaparams{4} = {'sampling_method','SampleFDA',{PopSize}};
[AllStat,Cache]=RunEDA(PopSize,n,F,Card,cache,edaparams) 
 