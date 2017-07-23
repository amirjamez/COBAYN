function[AllStat] = simple_pop_statistics(k,Pop,FunVal,time_operations,number_evaluations,AllStat,statistics_params)
% [AllStat] = simple_pop_statistics(k,Pop,FunVal,time_operations,number_evaluations,AllStat,statistics_params)
% simple_pop_statistics:  Computes relevant statistics about EDA in each
%                         generation and stores it in AllStat
%
%
%
%
% INPUTS 
% k:                   Current generation
% Pop:                 Current population
% FunVal:              A matrix of function evaluations, one vector of m objectives for each individual
% time_operations(1:k,1:6):  Matrix with the time in seconds spent at the main
%                      EDA steps, each of the 8 column stores the times for the
%                      following steps {sampling, repairing, evaluation, local optimization, replacement, selection,learning and
%                      total (which consider the time by the previous 7 and
%                      other EDA operations)
%                         
% number_evaluations(1:k):  Vector with the number of evaluations in each generation
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
%                      AllStat{k,5} = number_evaluations(k,:) (see inputs)
%                      AllStat{k,6} = time_operations(k,:) (see inputs)
% statistics_params(1): find_bestinds_method: Name of the procedure for selecting the  best individuals 
%                                                 from a population (by default is 'fitness_ordering')
% OUTPUTS
% AllStat: Array containing the statistics of the population
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       

find_bestinds_method = char(cellstr(statistics_params{1}(1)));

         AllStat{k,1} =  [max(FunVal);  % Statistics of the fitness objectives
                          mean(FunVal);
                          median(FunVal);
                          min(FunVal);
                          var(FunVal)];          
              
        [Ind]  = eval([find_bestinds_method,'(Pop,FunVal)']);  % The  best individual is found
        
        AllStat{k,2} = Pop(Ind(1),:);                                % Best individual                 
        AllStat{k,3} = size(unique(Pop,'rows'),1);                % Number of different individuals
       
        
        AllStat{k,4} =   [max(Pop);              % Statistics of the population
                          mean(Pop);
                          median(Pop);
                          min(Pop);
                          var(Pop)];
      
       AllStat{k,5} = NaN;                    
       AllStat{k,6} = time_operations(k,:);       

        
            
return;        
        