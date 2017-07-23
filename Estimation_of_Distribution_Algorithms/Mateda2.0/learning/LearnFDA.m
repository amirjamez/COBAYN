function[model] = LearnFDA(k,NumbVar,Card,SelPop,AuxFunVal,learning_params)
% [model] = LearnFDA(k,NumbVar,Card,SelPop,AuxFunVal,learning_params)
% LearnFDA:  Creates a factorized model from the structure 
% k: Current generation
% NumbVar: Number of variables
% Card: Vector with the dimension of all the variables. 
% SelPop:  Population from which the model is learned 
% AuxFunVal: Evaluation of the data set (required for some learning algorithms, not for this one)
% learning_params{1}(1) = Cliques
%    Each row of Cliques is a clique. The first value is the number of neighbor for variable i. 
%    The second, is the number of new variables (one new variable, i).
%    Then, neighbor variables are listed and  finally new variables
%    (variable i) are listed
% OUTPUTS
% model: Markov network model containing the structure (model{1} = Cliques)
%        and the parameters (model{2} = Tables)
%        Cliques is the structure of the model in a list of cliques that defines the  
%        Tables: Probability tables for each variable conditioned on its neighbors
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       


Cliques =  cell2num(learning_params{1}(1)); 
Tables = LearnFDAParameters(Cliques,SelPop,NumbVar,Card);
 
model{1} = Cliques;
model{2} = Tables;
return;

