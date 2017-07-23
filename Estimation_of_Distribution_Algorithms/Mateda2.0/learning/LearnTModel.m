function [model] = LearnTModel(k,NumbVar,Card,AuxPop,AuxFunVal,learning_params)
% [model] = LearnTModel(k,NumbVar,Card,AuxPop,AuxFunVal,learning_params)
% LearnTModel:     Learns the correlation matrix from the data 
% INPUTS
% k: Current generation
% NumbVar: Number of variables
% Card: Vector with the range of values for all the variables. 
% AuxPop:  Population from which the model is learned  
% AuxFunVal: Evaluation of the data set (required for some learning algorithms, not for this one)
% OUTPUTS
% model: model{1} = mean of the variables
%        model{2} = covariance of the variables 
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)  
 
     model{1} =  mean(AuxPop); % Vector of means    
     model{2} =  corr(AuxPop);   % Matrix of correlation 
         
     return;
       
       
       