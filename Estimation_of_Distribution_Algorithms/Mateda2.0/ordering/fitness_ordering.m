function[Index]=fitness_ordering(Pop,FunVal)
% [Index]=fitness_ordering(Pop,FunVal)
% fitness_ordering:            Individuals are ordered according to the
%                              ranking of its fitness values (best is the maximum)                          
%                              For multiobjetive functions, individuals are ordered according 
%                              average ranking for all the objectives. (i.e. for each objective an ordering 
%                              is done, and they are averaged later. 
% INPUTS 
% Pop:                 Population
% FunVal:              A matrix of function evaluations, one vector of m objectives for each individual
% OUTPUTS
% Index: Ordered index of the individuals in the population
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       

   number_objectives = size(FunVal,2);
   PopSize = size(Pop,1);
   
   if number_objectives==1
     [Val,Ind]= sort(FunVal(:,1));  
     Index = Ind(PopSize:-1:1);
   else
     Rank = zeros(1,PopSize);
     for i=1:number_objectives
      [Val,Ind]= sort(FunVal(:,i));  
      Rank(Ind) = Rank(Ind) + [1:PopSize];
     end
     [Val,FinalInd] = sort(Rank);
     Index = FinalInd(PopSize:-1:1);
   end

   
   return
 
   
   
   