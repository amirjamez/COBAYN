function[Formulas]=MakeVarDepFormulas(n,m,c,relatedvars,ratio) 
% [Formulas]=MakeVarDepFormulas(n,m,c,relatedvars,ratio) 
% MakeVarDepFormulas: Creates a set of formulas (one corresponds to each objective) where some clauses have a higher
%                     probability to appear in the formula in accordance to
%                     the variables appear in them
% INPUT
% n: Number of variables
% m: Number of formulas (objectives)
% c: Number of clauses in each formula 
% relatedvars: Vector of variables that will be more frequent in each formula
% ratio: Determines how often a clause appear in a formula. ratio=1 implies
%        that all variables have the same likelihood. The weight of a
%        clause is the sum of variables in relatedvars multiplied by the
%        ratio. The probability of each clauses is computed normalizing its weight by
%        the total weight
% OUTPUT
% Formulas: An array of matrices, each matrix has a row for each clause,
%           In the row, first the variables involved are shown, then
%           whether they are negated (0 value) or not (1 value)
% EXAMPLE
%  [Formulas] = MakeVarDepFormulas(20,10,20,[1:10],5) 
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)

triples = nchoosek([1:n],3);
ntriples = size(triples,1);

 for i=1:ntriples,
  common = intersect(relatedvars,triples(i,:));
  ncommon = size(common,2);
  if(ncommon>1) 
      val(i) = ratio*ncommon;
  else
      val(i) = 1;
  end
 end
 

 matrix = zeros(n,n);
 val = cumsum(val/sum(val));


 
 for i=1:m
    Index = sus(c,val);
  
   for j=1:c
     Formulas{i,j} = [triples(Index(j),:),fix(2*rand(1,3))];
     matrix(triples(Index(j),1),triples(Index(j),2)) = matrix(triples(Index(j),1),triples(Index(j),2)) + 1;
     matrix(triples(Index(j),1),triples(Index(j),3)) = matrix(triples(Index(j),1),triples(Index(j),3)) + 1;
     matrix(triples(Index(j),2),triples(Index(j),3)) = matrix(triples(Index(j),2),triples(Index(j),3)) + 1;
     matrix(triples(Index(j),2),triples(Index(j),1)) = matrix(triples(Index(j),2),triples(Index(j),1)) + 1;
     matrix(triples(Index(j),3),triples(Index(j),1)) = matrix(triples(Index(j),3),triples(Index(j),1)) + 1;
     matrix(triples(Index(j),3),triples(Index(j),2)) = matrix(triples(Index(j),3),triples(Index(j),2)) + 1;
   end 
 end
 
 %matrix
 %sum(matrix(1:10,1:10))
 %sum(matrix(11:20,11:20))