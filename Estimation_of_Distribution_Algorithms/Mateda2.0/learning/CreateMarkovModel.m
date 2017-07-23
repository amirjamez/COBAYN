function[Cliques] = CreateMarkovModel(NumbVar,dim)  
% [Cliques] = CreateMarkovModel(NumbVar,dim)  
% CreateMarkovModel:      Creates the structure of a Markov chain model where each variable
%                         depends on its dim previous variables 
% INPUTS
% NumbVar: Number of variables
% dim: Number of previous variables each variables depends on 
% OUTPUTS
% Cliques: Structure of the model in a list of cliques that defines the (chain shaped)  junction tree. 
%          Each row of Cliques is a clique. The first value is the number of overlapping variables. 
%          The second, is the number of new variables.
%          Then, overlapping variables are listed and  finally new variables are listed.
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)  

 
if(dim==0)
 for i=1:NumbVar
  Cliques(i,1) = 0;
  Cliques(i,2) = 1;
  Cliques(i,3) = i;
 end
else
  Cliques(1,1) = 0;
  Cliques(1,2) = dim;
  Cliques(1,3:dim+2) = 1:dim;

  for i=dim+1:NumbVar
    Cliques(i-dim+1,1) = dim;
    Cliques(i-dim+1,2) = 1;
    Cliques(i-dim+1,3:dim+2) = [i-dim:i-1];
    Cliques(i-dim+1,dim+3) = i;
  end

end


% Last version 9/26/2005. Roberto Santana (rsantana@si.ehu.es) 