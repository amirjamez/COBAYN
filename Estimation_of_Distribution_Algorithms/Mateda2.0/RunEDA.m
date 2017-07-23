function[AllStat,Cache]=RunEDA(PopSize,n,F,Card,cache,edaparams) 
% [AllStat,Cache]=RunEDA(PopSize,n,F,Card,cache,edaparams) 
% RUNEDA:  Calls an EDA defined by the operators and parameters given by the
%          user. A number of predefined operators (e.g. learning and sampling
%          algorithms) have been implemented. 
% Different BN structure learning algorithms are used 
% INPUTS
% PopSize: Population size
% n: Number of variables
% F: Name of the function that has as an argument a vector or NumbVar
% variables. For multivariate functions the output of F is a vector with
% the number_of_objectives values.
% cache: Is a vector that determines which structures of the EDA will be
%        stored.
%        cache(1) = 1 : The whole population at each generation k will be saved in Cache{1,k};
%        cache(2) = 1 : The selected population at each generation k will be saved in Cache{2,k};
%        cache(3) = 1 : The probability model at each generation k will be  saved in Cache{3,k};    
%        cache(4) = 1 : The evaluation of the Population at each generation k will be  saved in Cache{4,k};    
%        cache(5) = 1 : The evaluation of the Population at each generation  k will be  saved in Cache{4,k};    
% edaparams: Array where each row includes three columns: 1) the 'type' of
% EDA operator method, 2) the 'name' of the EDA operator method, which is a
% matlab program defined by the user or could be one of the given implementations(see below) and 3) the
% parameters used by the implementation of the method.
% e.g. edaparams{1}(1) = 'sampling_method'; edaparams{1}(2) = 'PLS'; edaparams{1}(3) = {1000};
%      edaparams{2}(1) = 'selection_method; edaparams{2}(2) = 'truncation_selection';   edaparams{2}(3) = {0.15};
% edaparams can appear in any order and there are a number of default of default values for all the operators (see below)
%
% The following are the different types of operators, given implementations and parameters. They are displayed
%
% type_of_method(fixed parameters, user defined parameters (method_params))
%
% seeding_pop_method(n,PopSize,Card,seeding_pop_params):
%                       seeding_pop_method keeps the name of the matlab program that  implements the seeding
%                       procedure.   seeding_pop_method = 'RandomInit'(default) corresponds to random initialization
%                       Current implementations include:
%                       'seeding_unitation_constraint': Generates a population of binary vectors  where all vectors have the same number of ones
% seeding_pop_params:   Depends on seeding method defined by the user. For seeding_pop_method='seeding_unitation_constraint',  seeding_pop_params{1}
%                       = Number of ones in each solution
% sampling_method(n,PopSize,model,SelPop,SelFunVal,Card,sampling_params):
%                         Sampling methods implemented: 
%                         'SampleBN': Samples a BN of discrete variables using probabilistic logic sampling (PLS) 
%                         'MOAGeneratePopulation': Samples a Markov network  using Gibbs Sampling
%                         'SampleFDA': Samples a population of individuals from a factorized model using PLS
%                         'SampleGaussianUnivModel': Samples a univariate Gaussian model
% sampling_params:     sampling_params{1} = NewPopSize: Number of
%                         sampled individuals. By default sambpling_params{1} = PopSize, but it
%                         may change according to the replacement strategy.
%                         Additional params might be required by each sampling algorithm
% repairing_method(Pop,Card,reparing_params):
%                         Implements a repairing procedure. The whole population is received and all or some of the
%                         individuals are repaired
% repairing_params:     Those needed to implement the repairing procedure
% local_opt_method(Pop,FunVal,local_opt_params):
%                         Implements a given local optimization procedure. The whole population is received and all or some of the
%                         individuals are optimized. The algorithm outputs
%                         the optimized population, with the new fitness values and number of evaluations done in the local
%                         optimization.
% local_opt_params:     Those needed to implement the repairing procedure
% replacement_method(Pop,SelPop,NewPop,FunVal,SelFunVal,NewPopFunVal,replacement_params)
%                         Allows the implementation of replacement method that creates a  new population from a set of three other
%                         populations (Current Pop, Sampled Pop, and Selected Pop)
%                         Current implementation includes replacement_method = {'elitism','best_elitism','pop_agregation'}
%                          'elitism' adds the k best individuals of the previous population to the current pop. 
%                          'best_elitism' joins the selected individuals with the sampled individuals to form the next population.
%                         in this case, it should be enforced that SampledPopSize = PopSize - SelPopSize
%                         'pop_aggregation' joins the current population with the new and select the best PopSize
%                         individuals as the new population.
%                         replacement_method = 'none' for Pop = NewPop.
%  replacement_params:     Depends on implementation. For replacement_metho
%                         For 'elitism': replacement_params{1} = k: number of elistist solutions
%                         and replacement_params{2} = find_bestids_method: method that implements a criterion to select the
%                         best individuals from a population. This is an important  user-defined method. Currently
%                         find_bestids_method = 'fitness_ordering' which take into account fitness ordering (see help
%                         'fitness_ordering' for details.
%                         For 'pop_agregation': replacement_params{1} = find_bestids_method.
% selection_method(Pop,FunVal,selection_params):   'selection_method' name of the matlab program selection method. Current   implementations include: 
%                     'truncation_selection' (default), 'prop_selection' and 'exp_selection'
% selection_params:    depends on the user implemented selection method  
%                      (e.g) selection_params{1}  =     T: Truncation parameter T \in (0,1) for truncation selection 
% learning_method(k,n,Card,SelPop,SelFunVal,learning_params):  
%                        'LearnBN': Bayesian network learning algorithms (see Help of the method for learning parameters)
%                        'LearnMOAModel': Markov network learning algorithms (see Help of the method for learning parameters)
%                        
% statistics_method(k,Pop,FunVal,time_operations,number_evaluations,AllStat ,statistics_params):
%                         Implements the computation of the statistics about the EDA behavior. 
%                         The statistics are stored in AllStat which may be used later for displaying information.
%                         Currently implemented is the method:  'simple_pop_statistics'
% statistics_params:      Use for passing information necessary in the
%                         computation of the statistics (see 'simple_pop_statistics' for an  example)
% verbose_method(k,AllStat,verbose_params):
%                          Defines the program used to display information about the EDA during the evolution
%                          Currently implemented is 'simple_verbose' which prints a number of statistics 
%                          (depending on verbose_params) about generation k of the EDA
% verbose_params:
% stop_cond_method(currentgen,currentPop,currentFunVal,stop_cond_params): 
%                         Implements the stop conditions of the algorithm. By default, the algorithm
%                         stops when reaching a maximum number of generations (1000). This is
%                         stop_cond_method = 'max_gen'. Current implementations include stop_cond_method =
%                         'maxgen_maxval' which stops either when a maximum number of iterations has been reached or give
%                         value of the function has been reached stop_cond_params{1} = 1000; 
%                         NOTE: the parameters currentPop and currentFunValallow the implementation of stop cond. methods
%                         based on the homogeneity of the population
% stop_cond_params:       Depend on the stop_cond_method. For
%                         stop_cond_method = {'max_gen','maxgen_maxval'} stop_cond_params{1} = CantGen: Maximum number of generations 
%                         stop_cond_method = 'maxgen_maxval', stop_cond_params{2} = MaximumFunction:  Maximum of the function that can be used as stop
%                         condition when it is known 
% OUTPUTS
% AllStat:             Array containing the statistics of the populations.
%                      It is updated by the method
%                      AllStat{k,1}= matrix of 7 rows and number_objectives
%                      columns. Each row shows information about
%                      max,mean,median,min, and variance values of the
%                      corresponding objective in the current population
%                      AllStat{k,2}= Stores the best individual
%                      AllStat{k,3}= Number of different individuals
%                      AllStat{k,4}= matrix of 5 rows and n
%                      columns. Each row shows information about
%                      max,mean,median,min, and variance values of the
%                      corresponding variable in the current population
%                      AllStat{k,5} =  Vector with the number of evaluations in each generation
%                      AllStat{k,6} = Matrix with the time in seconds spent at the main
%                      EDA steps, each of the 8 column stores the times for the
%                      following steps {sampling,repairing, evaluation,local optimization, ,replacement, selection,learning and
%                      total (which consider the time by the previous 7 and
%                      other EDA operations
%                         
% number_evaluations(1:k): 
% Cache:
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       


% Default operators and parameters

seeding_pop_method = 'RandomInit';
seeding_pop_params = [];
sampling_method = 'SampleBN';
sampling_params{1}(1) = {PopSize};
repairing_method  = 'none';
repairing_params  = [];
local_opt_method  = 'none';
local_opt_params  = [];
replacement_method = 'best_elitism';
replacement_params{1,1} = 'fitness_ordering';
selection_method =   'truncation_selection';
selection_params{1}(1) = {0.5};
selection_params{1}(2)=  {'fitness_ordering'};
learning_method = 'LearnBN';
learning_params{1,1} = {'tree'};
learning_params{1}(2) = {10};
learning_params{1}(3) = {0.05};
learning_params{1}(4) = {'pearson'};
learning_params{1}(5) = {'bic'};
learning_params{1}(6) = {'no'};
statistics_method =  'simple_pop_statistics';
statistics_params{1}(1)=  {'fitness_ordering'};
verbose_method = 'simple_verbose';
verbose_params{1,1} = [];
stop_cond_method =   'max_gen';
stop_cond_params{1}(1) = {50}; % Number of generations
Cache = {};

nparams = size(edaparams,2);

    	for i = 1:nparams
            auxstr = char(cellstr(edaparams{i}(1)));
            auxstr2 = char(cellstr(edaparams{i}(2)));

            
    	  switch auxstr
            case 'seeding_pop_method', seeding_pop_method = auxstr2;, seeding_pop_params = edaparams{i}(3);
            case 'sampling_method', sampling_method = auxstr2;, sampling_params = edaparams{i}(3); 
            case 'repairing_method',   repairing_method  = auxstr2;, repairing_params = edaparams{i}(3);
            case 'local_opt_method',   local_opt_method  = auxstr2;, local_opt_params = edaparams{i}(3);
            case 'replacement_method', replacement_method = auxstr2;, replacement_params = edaparams{i}(3);
            case 'selection_method',   selection_method = auxstr2;, selection_params = edaparams{i}(3);
            case 'learning_method', learning_method = auxstr2;, learning_params = edaparams{i}(3); 
            case 'statistics_method',  statistics_method  = auxstr2;, statistics_params = edaparams{i}(3);
            case 'verbose_method',     verbose_method  = auxstr2;,    verbose_params = edaparams{i}(3);
            case 'stop_cond_method',   stop_cond_method  = auxstr2;,  stop_cond_params = edaparams{i}(3);           
            end;
    	end;

auxedaparams{1,:} = {PopSize,n,F,Card};    
auxedaparams{2,:} = {'seeding_pop_method', seeding_pop_method, seeding_pop_params};
auxedaparams{3,:} = {'sampling_method', sampling_method, sampling_params}; 
auxedaparams{4,:} = { 'repairing_method',   repairing_method , repairing_params };
auxedaparams{5,:} = { 'local_opt_method',   local_opt_method , local_opt_params };
auxedaparams{6,:} = { 'replacement_method', replacement_method , replacement_params };
auxedaparams{7,:} = { 'selection_method',   selection_method , selection_params};
auxedaparams{8,:} = { 'learning_method', learning_method , learning_params}; 
auxedaparams{9,:} = { 'statistics_method',  statistics_method  , statistics_params};
auxedaparams{10,:} = { 'verbose_method',     verbose_method,    verbose_params };
auxedaparams{11,:} = { 'stop_cond_method',   stop_cond_method  ,  stop_cond_params };


continue_evolution = 1;
k = 1;
AllStat = {};
number_objectives = size(F,1);
NewPopSize = cell2num(sampling_params{1}(1));
CantGen = cell2num(stop_cond_params{1}(1));

previous_t = cputime;

while(continue_evolution==1)
   
 t = cputime;    
   if(k==1)
     % Initialization of the population .
     % Random by default. Alternatively, seeding procedure seeding_pop_method.
        Pop = eval([seeding_pop_method,'(n,PopSize,Card,seeding_pop_params)']);   
   else     
       % The new population is sampled from the learned model
        NewPop  = eval([sampling_method,'(n,model,Card,SelPop,SelFunVal,sampling_params)']);        
   end
   
  time_operations(k,1) = cputime-t;   % Time spent in sampling
  
   
  t = cputime; 
  
  if(~strcmp(repairing_method,'none') == 1)    
   if(k==1)
     [Pop] =  eval([repairing_method,'(Pop,Card,repairing_params)']); % Repairing method is applied
   else
     [NewPop] =  eval([repairing_method,'(NewPop,Card,repairing_params)']); % Repairing method is applied
   end
  end
   
 time_operations(k,2) = cputime-t;   % Time spent in repairing
   
 
 t = cputime;    
     % The sampled population is evaluated   
     
     if k==1
%       for i=1:PopSize,
           FunVal(:,:) = feval(F,Pop(:,:));  
%       end
       number_evaluations(k) = PopSize ;
       % FunVal'
     else
%      for i=1:NewPopSize,
           NewPopFunVal = feval(F,NewPop(:,:));  
%      end
%      number_evaluations(k) = number_evaluations(k-1) + NewPopSize ;
      % NewPopFunVal'
     end

  time_operations(k,3) = cputime-t;   % Time spent in evaluation
    
  
  t = cputime; 
  
  if(~strcmp(local_opt_method,'none') == 1)  % Local optimization method is applied
   if k==1   
     [Pop,FunVal,NumbEvals] =  eval([local_opt_method,'(k,Pop,FunVal,local_opt_params)']); 
     number_evaluations(k) = number_evaluations(k) + NumbEvals;
     %aux = FunVal'
   else
     [NewPop,NewPopFunVal,NumbEvals] =  eval([local_opt_method,'(k,NewPop,NewPopFunVal,local_opt_params)']); 
     number_evaluations(k) = number_evaluations(k) + NumbEvals;
     % aux = NewPopFunVal'
   end
  end
  
 time_operations(k,4) = cputime-t;   % Time spent in local optimization
 
  
     t = cputime;  
     if k>1           % In the first generation, the generated population is just the current population
                      % Replacement algorithm (e.g. elitism). The new population is formed using the previous population, the
                      % selected population and the sampled population.
       if(strcmp(replacement_method,'none') == 1)
          Pop = NewPop;                               % By default, the new population in the one just generated  
          FunVal = NewPopFunVal;
       else                                          % Alternatively another
         [Pop,FunVal]  = eval([replacement_method,'(Pop,SelPop,NewPop,FunVal,SelFunVal,NewPopFunVal,replacement_params)']); 
         
       end       
     end
     
     
     
     if (cache(1)==1)
       Cache{1,k} = Pop;
     end
     if (cache(4)==1)
       Cache{4,k} = FunVal;
     end
     
    time_operations(k,5) = cputime-t;   % Time spent in replacement
     
  
  t = cputime;       
  
      % Selection is applied
         [SelPop,SelFunVal]  = eval([selection_method,'(Pop,FunVal,selection_params)']);
     if (cache(2)==1)
       Cache{2,k} = SelPop;
     end
     if (cache(5)==1)
       Cache{5,k} = SelFunVal;
     end
       
  time_operations(k,6) = cputime-t;   % Time spent in selection
  

  t = cputime;          
      % The model is learned using one of the predefined learning algorithms
      
          [model] = eval([learning_method,'(k,n,Card,SelPop,SelFunVal,learning_params)']);
     if (cache(3)==1)
       Cache{3,k} = model;
     end
          
  time_operations(k,7) = cputime-t;   % Time spent in learning
  
  
    
     if(strcmp(stop_cond_method,'max_gen') == 1)  % Default stop condition: maximum number of generations
        continue_evolution = (k<CantGen);
     else                                         % Alternatively, a given stop condition method that uses current
                                                  % information about the EDA evolution plus external inf. (e.g. 
                                                  % known maximum value)
      continue_evolution = eval([stop_cond_method,'(k,Pop,FunVal,stop_cond_params)']);
     end

     
    time_operations(k,8) = cputime - previous_t;  % Time spent in the whole generation 
    previous_t = cputime;
    % Statistics are computed 
    [AllStat] = eval([statistics_method,'(k,Pop,FunVal,time_operations,number_evaluations,AllStat,statistics_params)']);
  
 
    if(strcmp(verbose_method,'none') ~= 1)  %  Statistics information about the run is printed
      eval([verbose_method,'(k,AllStat,verbose_params,auxedaparams)']);
    end  
     
     k=k+1;
end


return
    



