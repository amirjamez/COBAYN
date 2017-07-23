function [Cliques] = FindNeighborhood(MI,sizeconstraint,MIthreshold)
% [Cliques] = FindNeighborhood(MI,sizeconstraint,MIthreshold)
% FindNeighborhood:   Find the neighborhood of each variable using the values of the mutual
%                     information
%                     Neighbors are those variables whose interaction is above the MIthreshold 
%                     Each variable neighborhood is constrained to be at most of size sizeconstraint
% INPUTS:  
% T: Truncation parameter (when T=0, proportional selection is used)
% F: Name of the function that has as an argument a vector or NumbVar variables
% CantGen: Maximum number of generations 
% MaximumFunction:  Maximum of the function that can be used as stop condition when it is known 
% Card: Vector with the dimension of all the variables. 
% Elitism: Number of the current population individuals that pass to the next one.  
%---Elistism=-1: The whole selected population (only for truncation) passes to the next generation  
% OUTPUTS
%    Cliques: Structure of the model in a list of cliques that defines the neighborhood 
%    Each row of Cliques is a clique. The first value is the number of neighbors for variable i. 
%    The second, is the number of new variables (one new variable, i).
%    Then, neighbor variables are listed and  finally new variables (variable i) are listed
%    When Cliques is empty, the model is learned from the data
%
% Last version 8/26/2008. Roberto Santana and Siddarta Shakya (roberto.santana@ehu.es)    

NumbVars = size(MI,1);
epsilon = 1e-200; % It is used to avoid bias when the mutual information is equal

%for i=2:3:29,
% Cliques(i-1,:) = [2,1,i,i+1,i-1];   
% Cliques(i,:) = [2,1,i-1,i+1,i];
% Cliques(i+1,:) = [2,1,i-1,i,i+1];
%end,
%return

for i=1:NumbVars,   
    candidates = find(MI(i,:)>MIthreshold);
    ncandidates = size(candidates,2);   
    if(ncandidates > sizeconstraint)
      [MIvals,VarOrder] = sort(MI(i,candidates)+rand(1,ncandidates)*epsilon,'descend');
      %shuffle = randperm(ncandidates);
      Cliques(i,1:sizeconstraint+3) = [sizeconstraint,1,candidates(VarOrder(1:sizeconstraint)),i];
    elseif(ncandidates > 0)
      Cliques(i,1:ncandidates+3) = [ncandidates,1,candidates,i];
    else % No neighbor for variable i
     Cliques(i,1:3) = [0,1,i];
    end,
end,    
    
