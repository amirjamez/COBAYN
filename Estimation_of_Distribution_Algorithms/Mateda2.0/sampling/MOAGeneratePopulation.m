function [NewPop] = MOAGeneratePopulation(NumbVar,model,Card,AuxPop,AuxFunVal,sampling_params)
%  [NewPop] =  MOAGeneratePopulation(NumbVar,model,AuxPop,AuxFunVal,Card,sampling_params)
% MOAGeneratePopulation:         Samples a population of individuals from a Markov network
%                                usin Gibbs Sampling 
% INPUTS
% NumbVar: Number of variables
% model: Markov network model containing the structure (model{1} = Cliques)
%        and the parameters (model{2} = Tables)
% Card: Vector with the dimension of all the variables. 
% AuxPop: Auxiliary (selected) population (May be use for partial sampling or resampling)
% AuxFunVal: Evaluation of the data set (required for some sampling algorithms, not for this one)
% sampling_params{1}(1) = PopSize: Number of generated individuals 
% sampling_params{1}(2) = GibbSteps: Number of Gibbs sampling steps 
% OUTPUTS
% NewPop: Sampled individuals
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)    

PopSize = cell2num(sampling_params{1}(1)); 
GibbSteps = cell2num(sampling_params{1}(2)); 

Cliques = model{1};
Tables = model{2};

for i=1:PopSize
 RandomInd = (fix(rand(1,NumbVar).*Card));
 NewPop(i,:) = MOAGenerateIndividual(RandomInd,Cliques,Tables,Card,GibbSteps);
end,



