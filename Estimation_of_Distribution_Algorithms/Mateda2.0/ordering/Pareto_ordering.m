function[Index]=Pareto_ordering(Pop,FunVal)
% [Index]=Pareto_ordering(Pop,FunVal)
% Pareto_ordering:            Individuals are ordered according according to the front they belong to. Individuals in
%                             the first front (non-dominated solutions) come first. Then individuals that are only
%                             dominated by those in the first front and so on. There is no ordering criteria for
%                             individuals in the same front (see ParetoRank_ordering for more refined order.
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


   while ~isempty(Ind) 
   last = size(Ind,2)
   DomPop = zeros(1,last);
   for i=1:last-1
    for j=i+1:last
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
  
  
  
  Index = [];
  for i=1:nfronts
   Index = [Index,Front{i}];
  end
   
 return
 
   
   
   