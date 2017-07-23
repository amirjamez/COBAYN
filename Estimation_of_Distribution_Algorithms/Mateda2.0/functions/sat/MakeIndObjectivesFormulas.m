function[Formulas]=MakeIndObjectivesFormulas(n,m,c,cfixed,fixedvars) 
% [Formulas]=MakeIndObjectivesFormulas(n,m,c,cfixed,fixedvars) 
% MakeIndObjectivesFormulas: Creates a set of formulas (one correspond to each objective). 
%                            The first cfixed formulas are uniformly randomly selected. 
%                            The rest of formulas are constructed by
%                            randomly picked a previous generated formula
%                            and replacing some of the variables by other
%                            variables that are not in the formula. 
%                            The idea is to generate conditionally independent objectives given the variables
% INPUT
% n: Number of variables
% m: Number of formulas (objectives)
% c: Number of clauses in each formula 
% cfixed: Number of fixed formulas (the first clauses generated)
% fixedvars: Number of variables that form the fixed formulas
% OUTPUT
% Formulas{i,j}: Contains the clause j in the formula i. A clause is six
% component vector. The first three components are the numbers of the
% variables in the clause. The rest three component indicate whether the
% literal is negated (0) or not (1).
% EXAMPLE
%  [Formulas] = MakeRandomFormulas(20,10,20) 
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)

clear Formulas
triples = nchoosek([1:fixedvars],3);
ntriples = size(triples,1);

 val = ones(ntriples,1);

 matrix = zeros(n,n);
 val = cumsum(val/sum(val));


 
 for i=1:cfixed  % The initial formulas are randomly selected from the [1:fixedvars];
    Index = sus(c,val);  
   for j=1:c
     Formulas{i,j} = [triples(Index(j),:),fix(2*rand(1,3))];
   end 
 end
 
 
  for i=cfixed+1:m,           % The rest of formulas are found by replacing some of the variables in the previously generated formulas
   tochange = fix((fixedvars+1)*rand);   % Number of variables that will be changed (from 0 to fixedvar)
   prev = fix((i-1)*rand) + 1;  % Previous clause that will be used to construct the new one
   if tochange==0    
    for j=1:c,
     Formulas{i,j} = Formulas{prev,j}(:);
    end
   else
    auxvect = zeros(1,n);
    for j=1:c,
     auxvect(Formulas{prev,j}(1:3)) = 1;
    end 
    VarsIn = find(auxvect==1);
    InPerm = randperm(fixedvars);
    VarsOut = setdiff([1:n],VarsIn);
    OutPerm = randperm(n-fixedvars);
    VarsToTakeOut = VarsIn(InPerm(1:tochange));
    VarsToTakeIn =  VarsOut(OutPerm(1:tochange));
    for j=1:c
      for k=1:3
        found = find(VarsToTakeOut==Formulas{prev,j}(k));
        if isempty(found)
          Formulas{i,j}(k) = Formulas{prev,j}(k);
        else 
          Formulas{i,j}(k) = VarsToTakeIn(found);
        end         
      end  
      Formulas{i,j}(4:6) = Formulas{prev,j}(4:6);
    end      
   end
  end
  
   
 
 
   
 
 %matrix
 %sum(matrix(1:10,1:10))
 %sum(matrix(11:20,11:20))