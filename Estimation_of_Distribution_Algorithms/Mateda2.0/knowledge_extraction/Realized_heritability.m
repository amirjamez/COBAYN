function[b] = Realized_heritability(AllFunVals,AllSelFunVals) 
% [b] = Realized_heritability(AllFunVals,AllSelFunVals) 
% Response_to_selection: Computes the Realized heritability for every
%                        objective $b(t) = \frac{R(t)}{S(t)}$
%
% INPUT
% AllFunVals{maxgen} = FunVals(PopSize,n_objectives): Cell array that stores the evaluations of all the objectives
%                                                     for all the individuals in every generation
% AllSelFunVals{maxgen} = FunVals(PopSize,n_objectives): Cell array that stores the evaluations of all the objectives
%                                                     for the selected  individuals in every generation
%  OUTPUT
%  b: Realized heritability at each generation k>1
%  Example:
%  for i=1:ngen, auxr{1,i} = Cache{4,i}; auxs{1,i} = Cache{5,i}; end,
%  [b] = Realized_heritability(auxr,auxs)
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)

S = Amount_of_selection(AllFunVals,AllSelFunVals);
RS = Response_to_selection(AllFunVals);

k = size(AllFunVals,2);                % Number of generations

for i=2:k,
  b{i} = RS{i} ./ S{i}; 
end


