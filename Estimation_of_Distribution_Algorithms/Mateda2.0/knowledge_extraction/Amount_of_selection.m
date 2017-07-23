function[S] = Amount_of_selection(AllFunVals,AllSelFunVals) 
% [S] = Amount_of_selection(AllFunVals,AllSelFunVals) 
% Response_to_selection: Computes the amount of selection for every
%                        objective $S(t) = \bar{f}_{s}(t) -\bar{f}(t+1)$.
%
% INPUT
% AllFunVals{maxgen} = FunVals(PopSize,n_objectives): Cell array that stores the evaluations of all the objectives
%                                                     for all the individuals in every generation
% AllSelFunVals{maxgen} = FunVals(PopSize,n_objectives): Cell array that stores the evaluations of all the objectives
%                                                     for the selected  individuals in every generation
%  OUTPUT
%  S: Amount of selection at each generation k>1
%  Example:
%  for i=1:ngen, auxr{1,i} = Cache{4,i}; auxs{1,i} = Cache{5,i}; end,
%  [S] = Amount_of_selection(auxr,auxs)
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)

k = size(AllFunVals,2);                % Number of generations
n_objectives = size(AllFunVals{1},2);  % Number of objectives
PopSize =  size(AllFunVals{1},1);      % Population size

for i=2:k,
  S{i} = mean(AllFunVals{i}) - mean(AllSelFunVals{i-1});
end