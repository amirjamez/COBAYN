 % EXAMPLE 9:  Bayesian tree for a multiobjective function of the NK random
 % landscape (cicular neighbors)
 PopSize = 500; n = 50; cache = [1,1,1,1,1]; Card = 2*ones(1,n); 
 global FunctionTables;
 global FunctionStructure;
 global FunctionAccCard;
 
 %[FunctionStructure]    = ReadFactorGraphFromData('testNK_str_N50_k4Inst_1.txt');
 [FunctionStructure] =  CreateListFactorsCircularNK(n,4); % The circular structure is created
 [FunctionTables] = ReadFunctionsFromData('testNK_fnt_N50_k4Inst_1.txt',FunctionStructure,Card); % Values are read from a file
 [FunctionAccCard] = FindListCard(FunctionStructure,Card); % Auxiliary structure for function evaluation
 F = 'EvaluateGeneralFunction';  % General function that uses global variables FunctionTables, FunctionStructure and FunctionAccCard.
 selparams(1:2) = {0.5,'ParetoRank_ordering'};
 edaparams{1} = {'selection_method','truncation_selection',selparams};
 edaparams{2} = {'replacement_method','best_elitism',{'ParetoRank_ordering'}};
 edaparams{3} = {'stop_cond_method','max_gen',{5}};
 [AllStat,Cache]=RunEDA(PopSize,n,F,Card,cache,edaparams); 