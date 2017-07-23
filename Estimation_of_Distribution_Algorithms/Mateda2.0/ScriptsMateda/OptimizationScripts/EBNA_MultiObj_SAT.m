%% EXAMPLE 2: MULTIO-OBJECTIVE MAXSAT
%Bayesian network based EDA  for multi-objective 3-SAT
%For details on the EDA application to the multi-objective 3-SAT problem, see (Santana_et_al:2009) 

PopSize = 1000; n = 20;
cache  = [0,0,1,1,1];
Card = 2*ones(1, n);
maxgen = 15;

global Formulas; 
Formulas = LoadRandom3SAT(n, 1, Formulas); 
Formulas = LoadRandom3SAT(n, 2, Formulas);
Formulas = LoadRandom3SAT(n, 3, Formulas);
F = 'EvaluateSAT'; % 3-SAT function
selparams(1:2) = {0.5,'ParetoRank_ordering'};
BN_params(1:6) = {'k2',3,0.05,'pearson','bayesian','no'};
edaparams{1} = {'stop_cond_method','max_gen',{maxgen}};
edaparams{2} = {'learning_method','LearnBN',BN_params};
edaparams{3} = {'selection_method','truncation_selection',selparams};
edaparams{4} = {'replacement_method','best_elitism',{'ParetoRank_ordering'}};
% Launch EDA
[AllStat,Cache]=RunEDA(PopSize,n,F,Card,cache,edaparams)
