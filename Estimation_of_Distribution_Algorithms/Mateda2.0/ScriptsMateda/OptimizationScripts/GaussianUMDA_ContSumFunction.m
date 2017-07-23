% EXAMPLE 5:  Gaussian UMDA for the continuous sum function in the interval [0,5] 
 PopSize = 500; n = 30; Card(1,:) = zeros(1,n); Card(2,:) = 5*ones(1,n); 
 F = 'sum'; 
 edaparams{1} = {'learning_method','LearnGaussianUnivModel',{}};
 edaparams{2} = {'sampling_method','SampleGaussianUnivModel',{PopSize,1}};
 edaparams{3} = {'replacement_method','elitism',{1,'fitness_ordering'}};
 edaparams{4} = {'selection_method','prop_selection',{2}};
 [AllStat,Cache]=RunEDA(PopSize,n,F,Card,cache,edaparams) 
