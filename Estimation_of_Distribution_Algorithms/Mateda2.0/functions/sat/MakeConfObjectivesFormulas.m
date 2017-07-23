function[Formulas]=MakeConfObjectivesFormulas(n,m,c,cfixed) 
% [Formulas]=MakeConfObjectivesFormulas(n,m,c,cfixed) 
% MakeConfObjectivesFormulas: Creates a set of formulas (one correspond to each objective). 
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
% OUTPUT
% Formulas{i,j}: Contains the clause j in the formula i. A clause is six
%                component vector. The first three components are the numbers of the
%                variables in the clause. The rest three component indicate whether the
%                literal is negated (0) or not (1).
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)

clear Formulas
triples = nchoosek([1:n],3);
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
 
 
  for i=cfixed+1:m,           % The rest of formulas are found by replacing some the literals in some of the previously generated formulas
    prev = fix((i-1)*rand) + 1;  % Previous clause that will be used to construct the new one
    auxvect = zeros(1,n);
    for j=1:c,
     auxvect(Formulas{prev,j}(1:3)) = 1;
    end 
    VarsIn = find(auxvect==1);
    totIn = size(VarsIn,2);
    
    InPerm = randperm(totIn);
    tochange = fix((totIn)*rand)+1;   % Number of variables that will change their literals
    VarsToChange = VarsIn(InPerm(1:tochange));

    for j=1:c
      for k=1:3
        found = find(VarsToChange==Formulas{prev,j}(k));
        if isempty(found)
          Formulas{i,j}(k+3) = Formulas{prev,j}(k+3);
        else 
          Formulas{i,j}(k+3) = 1-Formulas{prev,j}(k+3);
        end         
      end  
      Formulas{i,j}(1:3) = Formulas{prev,j}(1:3);
    end      
  end
  
   
 
 
   
 
 %matrix
 %sum(matrix(1:10,1:10))
 %sum(matrix(11:20,11:20))