function[] = ObjectiveDistribution(AllFunVals,objs,gens) 
% [] = ObjectiveDistribution(AllFunVals,objs,gens) 
% ObjectiveDistribution: Displays the fitness distribution for  given 
%                        subsets of objectives and generations
%
% INPUT
% AllFunVals{maxgen} = FunVals(PopSize,n_objectives): Cell array that stores the evaluations of all the objectives
%                                                     for all the individuals in every generation
% objs:    Selected objectives
% gens:    Selected generations, for all generations gens = [1:maxgen];
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)

k = size(AllFunVals,2);                % Number of generations
n_objectives = size(AllFunVals{1},2);  % Number of objectives
PopSize =  size(AllFunVals{1},1);      % Population size

for i=1:size(objs,2),
 for j=1:size(gens,2)
  figure
  hist(AllFunVals{i,j});
 end
end