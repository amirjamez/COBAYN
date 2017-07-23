function[RS] = Response_to_selection(AllFunVals) 
% [RS] = Response_to_selection(AllFunVals) 
% Response_to_selection: Computes the response to selection for every
%                        objective. $R(t) = \bar{f}(t+1) -\bar{f}(t)$.
%
% INPUT
% AllFunVals{maxgen} = FunVals(PopSize,n_objectives): Cell array that stores the evaluations of all the objectives
%                                                     for all the individuals in every generation
%  OUTPUT
%  RS: Response to selection at each generation k>1
%  Example:
%  for i=1:ngen, auxr{1,i} = Cache{4,i}; end,
%  [RS] = Response_to_selection(auxr)
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)

k = size(AllFunVals,2);                % Number of generations
n_objectives = size(AllFunVals{1},2);  % Number of objectives
PopSize =  size(AllFunVals{1},1);      % Population size

for i=2:k,
  RS{i} = mean(AllFunVals{i}) - mean(AllFunVals{i-1});
end