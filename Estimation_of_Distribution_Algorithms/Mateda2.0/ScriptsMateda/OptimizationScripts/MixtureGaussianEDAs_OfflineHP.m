 % EXAMPLE 14:   Mixtures of full Gaussian distributions
 %               for  the Offline HP Model continuous function (see
 %               previous examples for explanation on the Offline HP Model)
 
 
 Fibbonacci_n = 9; % Fibbonacci_n: Value n for the construction of the Fibbonacci sequence. NumbVar = F(n)
 global HPInitConf;
 HPInitConf = CreateFibbInitConf(Fibbonacci_n); % HP Fibbonacci configuration 
 NumbVar = size(HPInitConf,2);
 PopSize = 200; 
 F = 'EvaluateOffHPProtein';
 cache  = [1,1,1,1,1]; Card = [zeros(1,NumbVar);2*pi*ones(1,NumbVar)];
 learning_params(1:5) = {'vars','ClusterPointsKmeans',5,'sqEuclidean',1};
 edaparams{1} = {'learning_method','LearnMixtureofFullGaussianModels',learning_params};
 edaparams{2} = {'sampling_method','SampleMixtureofFullGaussianModels',{PopSize,1}};
 edaparams{3} = {'replacement_method','best_elitism',{'fitness_ordering'}};
 selparams(1:2) = {0.5,'fitness_ordering'};
 edaparams{4} = {'selection_method','truncation_selection',selparams};
 edaparams{5} = {'repairing_method',' Trigom_repairing',{}};
 edaparams{6} = {'stop_cond_method','max_gen',{100}};
 edaparams{7} = {'local_opt_method','local_search_OffHP',{}};
  [AllStat,Cache]=RunEDA(PopSize,NumbVar,F,Card,cache,edaparams) 
 % To draw the resulting solution use function OffPrintProtein(vector),
 % where vector is the best solution found.
