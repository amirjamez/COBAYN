function[Func_Models] =  Find_Fitness_Approx(AllModels,ParetoPop,ParetoVals)
%   [Func_Models] =  Find_Fitness_Approx(AllModels,ParetoPop,ParetoVals)
%   Find_Fitness_Approx:   Find the probabilistic model with the highest
%                          correlation for each of the objectives in the
%                          given Population (e.g. a Pareto set approximation)
%                       
% INPUTS 
% AllModels:           Cell array containing the Bayesian networks learned
%                      by EDAs b
% ParetoPop:           Population
% ParetoVals:          Evaluation of each of the objectives for all
%                      solutions.
% OUTPUTS
% Func_Models: Func_Models{i} is the model with the highest correlation for
%              objective i. 
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)  


nmodels = size(AllModels,2);
n_objectives = size(ParetoVals,2);

for i=1:nmodels,              % The correlations between the probabilities of each BN and each of 
  bnet = AllModels{i};        % the problem objectives are computed using the Pareto Set
  All_BN_Fit_Corr(i,:) =  BN_Fitness_Corr(bnet,ParetoPop,ParetoVals)
end

[BestCorr,BestCorrModelsIndex] = max(All_BN_Fit_Corr(i,:)); % The indices of the models with the best correlation are found

for i=1:n_objectives,   
  Func_Models{i} = AllModels{BestCorrModelsIndex(i)};
end,

