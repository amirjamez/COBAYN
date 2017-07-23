
%%%%%%%%%%%%%%%%  COMPUTATION OF FITNESS RELATED MEASURES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXAMPLE 1: From the results of an EDA run with default parameters, different measures describing
%            the behavior of the algorithm are computed and graphs are
%            displayed

  PopSize = 300; n = 45; cache  = [1,1,1,1,1]; Card = 2*ones(1,n); edaparams = {};
  F = 'sum'; % Onemax function;
  ngen = 10;
  edaparams{1} = {'stop_cond_method','max_gen',{ngen}};
  [AllStat,Cache]=RunEDA(PopSize,n,F,Card,cache,edaparams) 
   for i=1:ngen,
     auxr{1,i} = Cache{4,i};
     auxs{1,i} = Cache{5,i};
   end,
   
  [mean_obj,var_obj] = Mean_Var_Objectives(auxr); % Mean and variance of objectives
  [RS] = Response_to_selection(auxr);             % Response to selection
  [S] = Amount_of_selection(auxr,auxs);           % Amount of selection
  [b] = Realized_heritability(auxr,auxs);         % Realized heritability
  ObjectiveDistribution(auxr,1,[1:ngen]);         % Histogram of the objective distribution
 
  
 Inds = Cache{1,1}; 
 Inds_sel = Cache{2,1}; 
 S_H_pop = Individuals_entropy(Inds,Card,1);      % Accumulated entropy of variables in the first population 
 S_H_sel = Individuals_entropy(Inds_sel,Card,1);  % Accumulated entropy of variables in the first selected population 
 for i=1:ngen
   inds_gens{i}=Cache{1,i};
 end
 H_gens = Generations_entropy(inds_gens,Card,1);  % Accumulated entropy of variables at each generation 

 X = [1:ngen]
 plot(X,H_gens);