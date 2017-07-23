function[mean_objs,var_objs] = Mean_Var_Objectives(AllFunVals) 
% [mean_objs,var_objs] = Mean_Var_Objectives(AllFunVals) 
% Mean_Var_Objectives: Computes the mean and variance for all the objectives 
%                   
%
% INPUT
% AllFunVals{maxgen} = FunVals(PopSize,n_objectives): Cell array that stores the evaluations of all the objectives
%                                                     for all the individuals in every generation
% mean_objs:   Mean of the objectives
% var_objs:    Variance of the objectives
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)

k = size(AllFunVals,2);                % Number of generations
n_objectives = size(AllFunVals{1},2);  % Number of objectives
PopSize =  size(AllFunVals{1},1);      % Population size

for i=1:k,
 mean_objs{i} = mean(AllFunVals{i});
 var_objs{i} = var(AllFunVals{i});
end