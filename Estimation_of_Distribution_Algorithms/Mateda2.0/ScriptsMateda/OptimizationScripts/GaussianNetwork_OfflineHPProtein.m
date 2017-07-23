 % EXAMPLE 8:  Gaussian network for  the Offline HP Model continuous function 
 % For reference on the Offline HP model see:
  
 Fibbonacci_n = 7; % Fibbonacci_n: Value n for the construction of the Fibbonacci sequence. NumbVar = F(n)
 global HPInitConf;
 HPInitConf = CreateFibbInitConf(Fibbonacci_n); % HP Fibbonacci configuration 
 NumbVar = size(HPInitConf,2);
 PopSize = 200; 
 F = 'EvaluateOffHPProtein';
 cache = [1,1,1,1,1]; Card = [zeros(1,NumbVar);2*pi*ones(1,NumbVar)];
 BN_params(1:6) = {'k2',10,0.05,'pearson','bic','no'};
 edaparams{1} = {'learning_method','LearnGaussianNetwork',BN_params};
 edaparams{2} = {'sampling_method','SampleBN',{PopSize,1}};
 edaparams{3} = {'repairing_method','SetInBounds_repairing',{}};
 edaparams{4} = {'stop_cond_method','max_gen',{50}};
  [AllStat,Cache]=RunEDA(PopSize,NumbVar,F,Card,cache,edaparams); 
 % To draw the resulting solution use function OffPrintProtein(vector),
 % where vector is the best solution found.
 OffPrintProtein(AllStat{maxgen,2})