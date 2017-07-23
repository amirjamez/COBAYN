 % EXAMPLE 2: Evaluation of the prediction capability of the models 
 %            learned during the evolution of an EDA for a multiobjective function
 %            The prediction is measured using the correlation between the probability
 %            given by the models to the solutions and its fitness values
 
 %%%%% First, the EDA is defined
 clear edaparams;  
 PopSize = 1000; n = 50; cache = [1,1,1,1,1]; Card = 2*ones(1,n); MaxGen = 30;
 global FunctionTables;
 global FunctionStructure;
 global FunctionAccCard;
 global SelectedObjectives;
 
 [FunctionStructure] =  CreateListFactorsCircularNK(n,4); % The circular structure is created
 [FunctionTables] = ReadFunctionsFromData('testNK_fnt_N50_k4Inst_1.txt',FunctionStructure,Card); % Values are read from a file
 [FunctionAccCard] = FindListCard(FunctionStructure,Card); % Auxiliary structure for function evaluation
 SelectedObjectives = [1:4:48];
 
 F = 'PartialEvaluateGeneralFunction';  % General function that uses global variables FunctionTables, FunctionStructure and FunctionAccCard.
 selparams(1:2) = {0.5,'ParetoRank_ordering'};
 edaparams{1} = {'selection_method','truncation_selection',selparams};
 edaparams{2} = {'replacement_method','best_elitism',{'ParetoRank_ordering'}};
 edaparams{3} = {'stop_cond_method','max_gen',{MaxGen}};
 
 %%%%% Second, the EDA is executed and all the information is saved in Cache
 
 [AllStat,Cache]=RunEDA(PopSize,n,F,Card,cache,edaparams); 
 
 
 %%%%% Third the information is extracted and analyzed
 
 AllSols = []; AllVals = [];
 for i=1:MaxGen,
  AllSols = [AllSols;Cache{1,i}];   % All the populations
  AllVals = [AllVals;Cache{4,i}];   % All the evaluations
 end
 
 Index = FindParetoSet(AllSols,AllVals); % The set of Pareto solutions found by the EDA is extracted
 ParetoPop = AllSols(Index,:);
 ParetoVals = AllVals(Index,:);
 
 parallelcoords(ParetoVals); % The Pareto set is shown using parallel coordinates
 ObjectivesCorr = corr(ParetoVals); % The correlations between the objectives are computed.
 [idx,netsim,dpsim,expref]=apcluster(ObjectivesCorr,mean(ObjectivesCorr)); % Affinity propagation is used
                                                                           % to reduce the number of objectives
                                                                           % by selecting correlated variables
 
 for i=1:MaxGen,              % The correlations between the probabilities of each BN and each of 
  bnet = Cache{3,i};          % the problem objectives are computed using the Pareto Set
  All_BN_Fit_Corr(i,:) =  BN_Fitness_Corr(bnet,ParetoPop,ParetoVals)
 end
 