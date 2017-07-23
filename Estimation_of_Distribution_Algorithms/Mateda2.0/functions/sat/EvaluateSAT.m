function[valfun] = EvaluateSAT(solution) 
% [valfun] = EvaluateSAT(solution)  
% EvaluateSAT: Evaluates a solution on a set of 3-SAT formulas contained in the
%              global variable Formulas. The output is a multi-objective
%              solution, one component corresponds to the evaluation of one
%              formula.
%
% INPUTS
% solution: Binary vector
% Formulas{i,j}: Contains the clause j in the formula i. A clause is six
%                component vector. The first three components are the numbers of the
%                variables in the clause. The rest three component indicate whether the
%                literal is negated (0) or not (1).
% OUTPUTS
% valfun: A vector of m components. valfun(i) is the number of clauses
% satisfied in formula i.
%
% Last version 2/17/2009. Roberto Santana (roberto.santana@ehu.es)

 global Formulas;
 
  n = size(solution,2);   % number of variables
  m = size(Formulas,1);   % number of formulas (objectives)
  c = size(Formulas,2);   % number of clauses 
  valfun = zeros(1,m);
  
  for i=1:m,
    for j=1:c,
      auxclause(1:3) = solution(Formulas{i,j}(1:3)); 
      auxclause(4:6) = Formulas{i,j}(4:6);
      valfun(i) = valfun(i) + ( xor(auxclause(1),auxclause(4)) + xor(auxclause(2),auxclause(5)) + xor(auxclause(3),auxclause(6)) <3);      
    end,
  end,

