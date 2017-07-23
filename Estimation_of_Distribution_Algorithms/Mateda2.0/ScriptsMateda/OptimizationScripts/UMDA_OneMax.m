% Creating UMDA for OneMax.

PopSize = 300; 
n = 30; % Number of variables
cache  = [0,0,1,0,0]; % Save probabilistic models
Card = 2*ones(1,n);
maxgen = 10;
F = 'sum';% Onemax function;

% In order to achieve the desired factorization we use a junction tree. With 0 as parameter we have not overlappings. Therefore, the cliques have a unique variable and they are independent.
Cliques = CreateMarkovModel(n, 0);
edaparams{1} = {'learning_method','LearnFDA',{Cliques}};
edaparams{2} = {'sampling_method','SampleFDA',{PopSize}};
edaparams{3} = {'stop_cond_method','max_gen',{maxgen}};
% Launch EDA
[AllStat,Cache]=RunEDA(PopSize, n, F, Card, cache, edaparams) 
