function [NewIndividual] = MOAGenerateIndividual(OldIndividual,Cliques,Tables,Card,GibbSteps)
% [NewIndividual] = MOAGenerateIndividual(OldIndividual,Cliques,Tables,Card,GibbSteps)
% MOASampleIndividual samples one individual using Gibbs Sampling 
% INPUTS
% OldIndividual: Starting configuration for sampling (By default it is
% random)
% Cliques: Structure of the model in a list of cliques that defines the
%          neighborhood of the variable.  Each row of Cliques is a clique. The first value is the number of overlapping variables (neighbors of 
%          variable i). The second, is the number of new variables (Variable i, but it could be extended to blocks of variables).
%          Then, neighbor  variables are listed and  finally variable i is listed.
% NumbVar: Number of variables
% Card: Vector with the dimension of all the variables. 
% OUTPUTS
% NewIndividual: Generated individual
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)     

NumbVar = size(OldIndividual,2);

NewIndividual = OldIndividual;
a = 0;
while a<GibbSteps
  
 for kk=1:NumbVar
     
  VarToChange = kk; %fix(NumbVar*rand)+1; % Var to be changed is selected. This allows  the possibility of generalizing
                                   % to blocks of variables by doing
                                   % BlockToChange = fix(size(Cliques,1)*rand)+1;
  
  i = VarToChange; % Just for simplicity 
  sizeCliqOther = Cliques(i,2);
  sizeCliqSolap = Cliques(i,1);
  

  if(sizeCliqSolap > 0) 
    CliqSolap = Cliques(i,3:Cliques(i,1)+2);
    AccCardSolap = FindAccCard(sizeCliqSolap,Card(CliqSolap));
    IndexInTableNeighbors =   NumconvertCard(NewIndividual(CliqSolap),sizeCliqSolap,AccCardSolap)+1;
  else   % The var has no neighbors, use univariate probabilities
    CliqSolap = [];
    AccCardSolap = [];
    dimSolap = 1;
    IndexInTableNeighbors = 1;  %The table has an entry for each value of the variable
  end
  
  auxcumvector = cumsum(Tables{i}(IndexInTableNeighbors,:));
  auxrand = rand;
  auxvect = find(auxrand < auxcumvector);  % The new value is selected according to conditional probabilities
  NewIndividual(i) =  auxvect(1)-1;
 end, 
  a = a+1;
end,




