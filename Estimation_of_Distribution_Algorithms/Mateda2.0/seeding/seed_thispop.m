function [NewPop] = seed_thispop(NumbVar,PopSize,Card,sampling_params)
% [NewPop] = seed_thispop(NumbVar,PopSize,Card,sampling_params)
% seed_thispop:         Starts the algorithm from the seeded population
% INPUTS
% NumbVar: Number of variables
% Card: For discrete variables:    Vector with the dimension of all the variables. 
%       For continuous variables:  Matrix of two vectors with the minimum and maximum real values 
%                                  each variable can take 
% sampling_params{1}(1) = Pop: Initial population 
% OUTPUTS
% NewPop: Sampled individuals
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       

NewPop = cell2num(sampling_params{1}(1));
