function [NewPop] =  SampleGaussianUnivModel(NumbVar,model,RangeValues,AuxPop,AuxFunVal,sampling_params)
%  [NewPop] =  SampleGaussianUnivModel(NumbVar,model,RangeValues,AuxPop,AuxFunVal,sampling_params)
% SampleGaussianUnivModel:         Samples a population of individuals from a Gaussian
%                                  univariate model
% INPUTS
% NumbVar: Number of variables
% model: model{1} = mean of the variables
%        model{2} =variances of the variables 
% RangeValues: Matrix of two vectors with the minimum and maximum real values 
%              each variable can take 
% AuxPop: Auxiliary (selected) population (May be use for partial sampling or resampling)
% AuxFunVal: Evaluation of the data set (required for some sampling algorithms, not for this one)
% sampling_params{1,1} = N: Number of generated individuals 
% OUTPUTS
% NewPop: Sampled individuals
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)  


PopSize = cell2num(sampling_params{1}(1)); 

vars_means = model{1};
vars_sigmas = model{2};

 % Generate the new population
 NewPop =  normrnd(repmat(vars_means,PopSize,1),repmat(vars_sigmas,PopSize,1));	 
 
 
return;