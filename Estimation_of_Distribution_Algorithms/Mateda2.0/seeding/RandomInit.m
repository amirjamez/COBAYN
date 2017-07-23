function [NewPop] = RandomInit(NumbVar,PopSize,Card,sampling_params)
% [NewPop] = RandomInit(NumbVar,PopSize,Card,sampling_params)
% RandomInit:         Random Initialization of the population
% INPUTS
% NumbVar: Number of variables
% Card: For discrete variables:    Vector with the dimension of all the variables. 
%       For continuous variables:  Matrix of two vectors with the minimum and maximum real values 
%                                  each variable can take 
% sampling_params{1}(1) = N: Number of generated individuals 
% OUTPUTS
% NewPop: Sampled individuals
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       

if size(Card,1)==1  % Discrete case
  NewPop = fix(repmat(Card,PopSize,1).*[rand(PopSize,NumbVar)]);  
else
  auxvector = Card(2,:) - Card(1,:);
  NewPop = repmat(Card(1,:),PopSize,1) + (repmat(auxvector,PopSize,1).*[rand(PopSize,NumbVar)]);
end
 
