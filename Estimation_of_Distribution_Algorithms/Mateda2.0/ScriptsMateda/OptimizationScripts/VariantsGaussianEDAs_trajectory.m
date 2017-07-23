 % EXAMPLE 13:  Different variants of continuous EDAs for a spacecraft
 % trajectory problem.
 % For a description of the spacecraft trajectory problem and links
 % to the problem instances see:
 % Benchmarking different global optimisation techniques for preliminary 
 % space trajectory design (2007). Tamas Vinko and Dario Izzo and Claudio 
 % Bombardelli. Proceedings of 58th International Astronautical Congress

 global MGADSMproblem
 cd ../trajectory
 load EdEdJ  % This instance can be downloaded for ESA web page
 cd ../Mateda2.0
 
 NumbVar = 12;
 PopSize = 1000; 
 F = 'EvalSaga'; % The function should be modified to enforce maximization, i.e g(x) = -1*f(x)
 Card(1,:) = [7000,0,0,0,50,300,0.01,0.01,1.05,8,-1*pi,-1*pi];
 Card(2,:) = [9100,7,1,1,2000,2000,0.90,0.90,7.00,500,pi,pi]; 
 cache  = [0,0,0,0,0]; 
 edaparams{1} = {'learning_method','LearnGaussianUnivModel',{}};
 %edaparams{1} = {'learning_method','LearnGaussianFullModel',{}};
 % edaparams{1} = {'learning_method','LearnGaussianNetwork',BN_params};
 edaparams{2} = {'sampling_method','SampleGaussianUnivModel',{PopSize,1}};
 % edaparams{2} = {'sampling_method','SampleGaussianFullModel',{PopSize,2}};
 % BN_params(1:6) = {'k2',10,0.05,'pearson','bic','no'};
 % edaparams{2} = {'sampling_method','SampleBN',{PopSize,1}};
 edaparams{3} = {'replacement_method','best_elitism',{'fitness_ordering'}};
 selparams(1:2) = {0.1,'fitness_ordering'};
 edaparams{4} = {'selection_method','truncation_selection',selparams};
 edaparams{5} = {'repairing_method','SetWithinBounds_repairing',{}};
 edaparams{6} = {'stop_cond_method','max_gen',{5000}};
 [AllStat,Cache]=RunEDA(PopSize,NumbVar,F,Card,cache,edaparams) 