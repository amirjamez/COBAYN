function[Formulas]=MakeRandomFormulas(n,m,c) 
% [Formulas]=MakeRandomFormulas(n,m,c) 
% MakeVarDepFormulas: Creates a set of formulas (one correspond to each objective). Clauses are uniformly randomly selected. 
% INPUT
% n: Number of variables
% m: Number of formulas (objectives)
% c: Number of clauses in each formula 
% OUTPUT
% Formulas: An array of matrices, each matrix has a row for each clause,
%           In the row, first the variables involved are shown, then
%           whether they are negated (0 value) or not (1 value)
% EXAMPLE
%  [Formulas] = MakeRandomFormulas(20,10,20) 
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)

triples = nchoosek([1:n],3);
ntriples = size(triples,1);

 val = ones(ntriples,1);

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