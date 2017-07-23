function[] = simple_verbose(k,AllStat,verbose_params,auxedaparams)
% [] = simple_verbose(k,AllStat,verbose_params,auxedaparams)
% simple_verbose:      Prints a number of statistics (depending on verbose_params) about generation k of the EDA
% INPUTS 
% k:                   Current generation
% AllStat:             Array containing the statistics of the populations.
%                      It is updated by the method
%                      AllStat{k,1}= matrix of 5 rows and number_objectives
%                      columns. Each row shows information about
%                      max,mean,median,min, and variance values of the
%                      corresponding objective in the current population
%                      AllStat{k,2}= Stores the best individual
%                      AllStat{k,3}= Number of different individuals
%                      AllStat{k,4}= matrix of 5 rows and n
%                      columns. Each row shows information about
%                      max,mean,median,min, and variance values of the
%                      corresponding variable in the current population
%                      AllStat{k,5} = time_operations(k,:) Matrix with the time in seconds spent at the main
%                      EDA steps at each generation, each of the 6 column stores the times for the
%                      following steps {sampling,evaluation,replacement,selection,learning and
%                      total (which consider the time by the previous
%                      5 and other EDA operations)}
%                      AllStat{k,6} =   Vector with the number of evaluations up to each generation
% verbose__params{1}: find_bestinds_method: Name of the procedure for selecting the  best individuals 
%                                                 from a population (by default is 'fitness_ordering')
% auxedaparams:      Contains the description of all EDA methods and
%                    parameters
% OUTPUTS
% AllStat: Array containing the statistics of the population
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       


 if(k==1)    
    PopSize = cell2num(auxedaparams{1}(1));
    n = cell2num(auxedaparams{1}(2));
    F = char(cellstr(auxedaparams{1}(3)));
    Card = cell2num(auxedaparams{1}(4));    
    disp([sprintf('PopSize: %d',PopSize)]);
    disp([sprintf('Number of variables: %d',n)]);
    disp([sprintf('Function: %s',F)]);
    %disp([sprintf('Range of the values for the variables: ')]);
    %disp(Card);
    
   for i=2:size(auxedaparams,1)    
     auxstr1 =  [char(cellstr(auxedaparams{i}(1)))];
     auxstr2 =  [char(cellstr(auxedaparams{i}(2)))];
     disp([sprintf('%s:  %s',auxstr1,auxstr2)]);     
     auxparams = auxedaparams{i}(3);
     for j=1:size(auxparams,1)
       if(iscell(auxparams{j}))
        disp([sprintf('Params: '),auxparams{j}{:}]);  
       else      
        disp([sprintf('Params: '),auxparams{j}]);  
       end
     end  
   end
 end

 disp([sprintf('*****************  Generation %d ********************** \n',k)]);

 disp([sprintf('Max objective values: '), sprintf('%d ',AllStat{k,1}(1,:))]);
 disp([sprintf('Sum of max objective values: '), sprintf('%d ',sum(AllStat{k,1}(1,:)))]);
 disp([sprintf('Mean objective values: '), sprintf('%d ',AllStat{k,1}(2,:))]);
 disp([sprintf('Sum of mean objective values: '), sprintf('%d ',sum(AllStat{k,1}(2,:)))]);
 disp([sprintf('Median objective values: '), sprintf('%d ',AllStat{k,1}(3,:))]);
 disp([sprintf('Sum of median objective values: '), sprintf('%d ',sum(AllStat{k,1}(3,:)))]);
 disp([sprintf('Min objective values: '),    sprintf('%d ',AllStat{k,1}(4,:))]);
  disp([sprintf('Sum of min objective values: '), sprintf('%d ',sum(AllStat{k,1}(4,:)))]);
  disp([sprintf('Variance of the objective values: '), sprintf('%d ',AllStat{k,1}(5,:))]);

 disp([sprintf('Best individual: '), sprintf('%d ',AllStat{k,2})]);
 disp([sprintf('Number of different individuals: '), sprintf('%d ',AllStat{k,3})]);
 
 disp([sprintf('Max values of the variables: '), sprintf('%d ',AllStat{k,4}(1,:))]);
 disp([sprintf('Mean values of the variables: '), sprintf('%d ',AllStat{k,4}(2,:))]);
 disp([sprintf('Median values of the variables: '), sprintf('%d ',AllStat{k,4}(3,:))]);
 disp([sprintf('Min values of the variables: '), sprintf('%d ',AllStat{k,4}(4,:))]);
 disp([sprintf('Variance of the variables: '), sprintf('%d ',AllStat{k,4}(5,:))]);
    
 disp([sprintf('number of evaluations: '), sprintf('%d ',AllStat{k,5})]);

 disp([sprintf('Time: sampling %d, repairing %d, evaluation %d, local_opt %d, replacement %d, selection %d, learning %d, and total %d \n ',AllStat{k,6})]);
        
            
return;        
        