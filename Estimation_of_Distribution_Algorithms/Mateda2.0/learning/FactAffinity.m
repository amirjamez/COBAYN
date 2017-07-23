function [Cliques,deep]=FactAffinity(MI,vars,sizeconstraint,p,deep)
% [Cliques,deep]=FactAffinity(MI,vars,sizeconstraint,p,deep)
% FactAffinity:   Finds a set of cliques from a matrix of mutual information
%                using affinity propagation
% INPUTS:
% NumbVar: Number of variables
% dim: Number of previous variables each variables depends on 
% OUTPUTS:
% Cliques: Structure of the model in a list of cliques that defines the (chain shaped)  junction tree. 
%          Each row of Cliques is a clique. The first value is the number of overlapping variables. 
%          The second, is the number of new variables.
%          Then, overlapping variables are listed and  finally new variables are listed.
% Last version 8/26/2008. Roberto Santana and Siddarta Shakya (roberto.santana@ehu.es)    


if deep>=10
   MI = MI + rand(size(MI)); 
end
deep = deep + 1;
n = size(MI,1);
 vars
[idx,netsim,dpsim,expref]=apcluster(MI,p); %Find the clusters of the MI matrix
Cliques = [];
nclusters = length(unique(idx));
exemplars = unique(idx);
for i=1:nclusters
 clusters{i} = find(idx==exemplars(i));
 clustsize = size(clusters{i},1);
 if(clustsize>sizeconstraint)
    MI1 = MI(:,clusters{i});
    MI1 = MI1(clusters{i},:);
    p=  (max(MI1(:))-min(MI1(:)))*rand();  % Set preference to median similarity
    olddeep = deep;
    [Cliques1,deep]=FactAffinity(MI1,vars(clusters{i}'),sizeconstraint,p,deep);
    deep = olddeep;
   Cliques = [Cliques;Cliques1];
 else
   %vars(clusters{i}')'
   Cliq = [0,clustsize,vars(clusters{i}'),zeros(1,sizeconstraint+2-clustsize)];
   Cliques = [Cliques;Cliq];
 end
end 










