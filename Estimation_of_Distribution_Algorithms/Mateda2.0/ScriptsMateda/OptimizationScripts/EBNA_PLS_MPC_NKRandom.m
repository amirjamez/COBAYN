 % EXAMPLE 16:  
 % Compares a Bayesian network based EDA that uses Probabilistic Logic Sampling
 % with a Bayesian network based EDA that adds the Most Probable Configuration (i.e.
 % the most probable individual from the net is added to the population
 % during sampling) on a set of Number_Inst random instances of the NK circular
 % model
 
 
 n = 50; cache = [1,1,1,1,1]; Card = 2*ones(1,n); 
 global FunctionTables;
 global FunctionStructure;
 global FunctionAccCard;
 Number_Inst = 50;  k = 4;  nam = 'TestMPE';  NumberVar = 50;
 
 % First the structure of the NK function is generated
 [FunctionStructure] =  CreateListFactorsCircularNK(n,4); % The circular structure is created
 
 % The Number_Inst instaces  of the problem are created and saved on files
 % with prefix "nam" (see above).
 
 for i=1:Number_Inst,
  filename = [nam,num2str(i),'.txt'];   
  [Table] = CreateRandomFunctions(FunctionStructure,Card);
  SaveFunctionValues(filename,NumberVar,FunctionStructure,Table);
 end,

% The function is the sum of the values for each definition set of NK circular function

F = 'SumEvaluateGeneralFunction';  % General function that uses global variables FunctionTables, FunctionStructure and FunctionAccCard.
MaxGen = 100; PopSize = 500; n = 50; cache = [1,1,1,1,1]; Card = 2*ones(1,n); 

% The parameters of the Bayesian network based EDA are defined.
 stop_cond_params = {MaxGen};
 BN_params(1:6) = {'k2',10,0.05,'pearson','bic','no'};
 selparams(1:2) = {0.5,'ParetoRank_ordering'};
 edaparams{1} = {'selection_method','truncation_selection',selparams};
 edaparams{2} = {'replacement_method','best_elitism',{'ParetoRank_ordering'}};
 edaparams{3} = {'learning_method','LearnBN',BN_params};
 edaparams{4} = {'stop_cond_method','max_gen',stop_cond_params};
 
%The initial population for each of the instances is fixed in order to
%compare algorithms on a common ground.

InitPop = fix(2*rand(Number_Inst*PopSize,n));
nruns = 30;  % Number of runs

% The Number_Inst*nruns*2 runs are executed within the following nested loops
% and their results are saved in the file ResultsTest.mat

for i=1:Number_Inst,
   edaparams{6} = {'seeding_pop_method','seed_thispop',{InitPop((i-1)*PopSize+1:i*PopSize,:)}};   
   filename = [nam,num2str(i),'.txt'];
  [FunctionTables] = ReadFunctionsFromData(filename,FunctionStructure,Card); % Values are read from a file
  [FunctionAccCard] = FindListCard(FunctionStructure,Card); % Auxiliary structure for function evaluation
 
  for j=1:2,
    if j==1
      edaparams{5} = {'sampling_method','SampleBN',{PopSize}};
    else
      edaparams{5} = {'sampling_method',' SampleMPE_BN',{PopSize}};
    end
    for k=1:nruns,
     [i,j,k] % To show the current run
     [AllStat,Cache]=RunEDA(PopSize,n,F,Card,cache,edaparams);
     ResultsTestsAllStat{i,j,k} = AllStat;
     ResultsTestsCache{i,j,k} = AllStat;
     save ResultsTest.mat InitPop ResultsTestsAllStat ResultsTestsCache
    end
  end, 
end 