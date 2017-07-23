function [model] = LearnGaussianUnivModel(k,NumbVar,Card,AuxPop,AuxFunVal,learning_params)
% [model] = LearnGaussianUnivModel(k,NumbVar,Card,AuxPop,AuxFunVal,learning_params)
% LearnMargProdModel:     Learns a Gaussian univariate marginal product model 
% INPUTS
% k: Current generation
% NumbVar: Number of variables
% Card: Vector with the dimension of all the variables. 
% AuxPop:  Population from which the model is learned  the factorization 
% AuxFunVal: Evaluation of the data set (required for some learning algorithms, not for this one)
% OUTPUTS
% model: model{1} = mean of the variables
%        model{2} = variances of the variables 
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)  
 
       
     model{1} =  mean(AuxPop);   % Vector of means 
     model{2} =  std(AuxPop);    % Vector of variances
      
     return;
       
       
       