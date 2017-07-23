function[Index]=ParetoRank_ordering(Pop,FunVal)
% [Index]=ParetoRank_ordering(Pop,FunVal)
% ParetoRank_ordering:        Individuals are firstly ordered according to the front they belong to. 
%                             Then, in each front, they are ordered according to the average rank of
%                             their fitness functions (see Pareto_ordering and fitness_ordering
%                             for details)
%                             The first front (non-dominated solutions) come first. Then individuals that are only
%                             dominated by those in the first front and so on. 
% INPUTS 
% Pop:                 Population
% FunVal:              A matrix of function evaluations, one vector of m objectives for each individual
% OUTPUTS
% Index: Ordered index of the individuals in the population
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       

   PopSize = size(Pop,1);
   number_objectives = size(FunVal,2);
   Ind = [1:PopSize];
   nfronts = 0;
  % First, Pareto_ordering is applied to identify the fronts
  
  while ~isempty(Ind) 
   last = size(Ind,2);
   DomPop = zeros(1,last);
   for i=1:last-1
    for j=i+1:last,
      if(sum(FunVal(Ind(i),:)>=FunVal(Ind(j),:))==number_objectives)
        DomPop(j) = DomPop(j) + 1;
      elseif(sum(FunVal(Ind(j),:)>=FunVal(Ind(i),:))==number_objectives)      
        DomPop(i) = DomPop(i) + 1;  
      end,
    end
   end
   NonDom = Ind(find(DomPop==0));
   nfronts = nfronts + 1;
   Front{nfronts} = NonDom;
   Ind = setdiff(Ind,NonDom);
  end,
  
  % Solution in each front are ordered according to the rank
  Index = [];
  for i=1:nfronts
   [AuxIndex]=fitness_ordering(Pop(Front{i},:),FunVal(Front{i},:));
   Index = [Index,Front{i}(AuxIndex)];
  end
   
 return
 
   
   
   