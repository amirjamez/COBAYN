function [NewPop] =  SampleGaussianFullModel(NumbVar,model,RangeValues,AuxPop,AuxFunVal,sampling_params)
% [NewPop] = SampleGaussianFullModel(NumbVar,model,RangeValues,AuxPop,AuxFunVal,sampling_params)
% SampleGaussianFullModel:         Samples a population of individuals from
%                                  a full multivariate Gaussian  model
% INPUTS
% NumbVar: Number of variables
% model: model{1} = mean of the variables
%        model{2} = matrix of covariances between the variables 
% RangeValues: Matrix of two vectors with the minimum and maximum real values 
%              each variable can take 
% AuxPop: Auxiliary (selected) population (May be use for partial sampling or resampling)
% AuxFunVal: Evaluation of the data set (required for some sampling algorithms, not for this one)
% sampling_params{1,1} = N: Number of generated individuals 
% sampling_params{1,2} = var_scaling: Scaling for the covariance values. A
%                        very low variance tends to move the algorith to stagnation. Scaling is a partial 
%                        solution to this problem. Dynamic scaling should
%                        be implemented as a more robust solution
% OUTPUTS
% NewPop: Sampled individuals
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)  

PopSize = cell2num(sampling_params{1}(1)); 
var_scaling = cell2num(sampling_params{1}(2)); 

vars_means = model{1};
vars_cov = model{2}*var_scaling;

 % Generate the new population

  NewPop = mvnrnd(vars_means,vars_cov,PopSize); 
  
     
return;