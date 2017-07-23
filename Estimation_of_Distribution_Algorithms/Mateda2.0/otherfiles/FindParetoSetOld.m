function[Index]=FindParetoSetOld(Pop,FunVal)
% [Index]=FindParetoSetOld(Pop,FunVal)
% FindParetoSet:             Identify the set of non-dominated solutions 
% INPUTS 
% Pop:                 Population
% FunVal:              A matrix of function evaluations, one vector of m objectives for each individual
% OUTPUTS
% Index: Index of non-dominated solutions in Pop
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       

   PopSize = size(Pop,1);
   number_objectives = size(FunVal,2);
  
   last = size(FunVal,1);
   DomPop = zeros(1,last);
   
   i = 1;
 while i<last-1,    
   while DomPop(i)>0 && i<last
     i = i + 1;
   end,  
   j = i + 1;
   while j<last 
    while DomPop(j)>0 && j<last
     j = j + 1;
    end,
      if(sum(FunVal(i,:)>=FunVal(j,:))==number_objectives)
        DomPop(j) = DomPop(j) + 1;
      elseif(sum(FunVal(j,:)>=FunVal(i,:))==number_objectives)      
        DomPop(i) = DomPop(i) + 1;  
        j = last;     
      end,
    j = j + 1;
   end
   i = i + 1; 
 end


 Index = find(DomPop==0); %Non dominated solutions
   
 return
 
   last = size(FunVal,1);
   DomPop = zeros(1,last);
   for i=1:last-1
    for j=i+1:last
      if(sum(FunVal(i,:)>=FunVal(j,:))==number_objectives)
        DomPop(j) = DomPop(j) + 1;
      elseif(sum(FunVal(j,:)>=FunVal(i,:))==number_objectives)      
        DomPop(i) = DomPop(i) + 1;  
      end,
    end
   end
   Index = find(DomPop==0); %Non dominated solutions
   
   
   