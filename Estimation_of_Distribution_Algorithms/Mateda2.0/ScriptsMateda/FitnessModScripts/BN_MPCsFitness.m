 % EXAMPLE 5:  
 % An EDA based on Bayesian networks is used for the solution of the evalfuncntrap function
 % The algorithm stops after a maxgen number of generations is reached.
 % The fitness values of the most probable explanations the computation of the probabilities given by the model to
 % the best solutions found by the algorithm are computed.
 
 
  PopSize = 500; n = 30; cache  = [1,1,1,1,1]; Card = 2*ones(1,n); maxgen = 10;
  F = 'evalfunctrapn'; % Trap function of parameter k=5;
  global ntrapparam;
  ntrapparam = 5;           % The parameter of the function is passed as a global variable 
  
 edaparams{1} = {'replacement_method','elitism',{10,'fitness_ordering'}};
 selparams(1:2) = {0.3,'ParetoRank_ordering'};
 edaparams{2} = {'selection_method','truncation_selection',selparams};
 BN_params(1:6) = {'k2',10,0.05,'pearson','bayesian','no'};
 edaparams{3} = {'learning_method','LearnBN',BN_params};
 edaparams{4} = {'stop_cond_method','max_gen',{maxgen}};
 [AllStat,Cache]=RunEDA(PopSize,n,F,Card,cache,edaparams)
  
  
 for i=1:maxgen
   bnets{i}=Cache{3,i};            % The Bayesian networks are extracted from the Cache
 end
 [MPEs] = Most_probable_explanations(bnets, F); % Most probable explanations are found

 % The most probable explanation given by the Bayesian network in
 % each generation is computed and the function values at each generation for the most probable
 % explanations are plotted.
 
 for i=1:maxgen
   fo_mpes(i)=MPEs{3,i};           % The fitness values of the most probable explanations are displayed
 end
 X=[1:maxgen];
 plot(X,fo_mpes);

 %%%  The best point reached by the algorithm is found and the probabilities given by the models 
 %%%  to this point are computed and ploted

 optimal_point = AllStat{maxgen,2};  %The best point reached by the algorithm is found
 [P] = Probability_monitor(bnets, optimal_point); % The probabilities given by the models to this point are computed.
                                                  % and ploted
 figure 
 plot(X,P);
 
