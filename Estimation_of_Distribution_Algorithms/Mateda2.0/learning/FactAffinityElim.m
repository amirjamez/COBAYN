function [Cliques,deep]=FactAffinityElim(MI,vars,sizeconstraint,p,deep)
% [Cliques,deep]=FactAffinityElim(MI,vars,sizeconstraint,p,deep)
% FactAffinityElim:        Finds a set of cliques from a matrix of mutual information
%                          using affinity propagation. The application of
%                          the algorithm is recursive.
% INPUTS
% vars:              vars that will be involved in the factorization (initially all the
%                    variables
% sizeconstraint: Maximum size of the factors involved in the factorization
% p: Preference parameter for affinity propagation
% deep: Parameter to control the recursive calls
% OUTPUTS
% Cliques: Structure of the model in a list of cliques that defines the (chain shaped)  junction tree. 
%          Each row of Cliques is a clique. The first value is the number of overlapping variables. 
%          The second, is the number of new variables.
%          Then, overlapping variables are listed and  finally new variables are listed.
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)  


if deep>=10
   MI = MI + mean(MI(:))*rand(size(MI)); 
end


n = size(MI,1);
outvars = [];

[idx,netsim,dpsim,expref,unconverged]=apcluster(MI,p,'dampfact',0.5); %Find the clusters of the MI matrix
nconv = 0;
while(unconverged & nconv<10)
  [idx,netsim,dpsim,expref,unconverged]=apcluster(MI+min(MI(:))*rand(size(MI)),p,'dampfact',0.9);
  nconv = nconv+1
end

Cliques = [];
nclusters = length(unique(idx));
exemplars = unique(idx);
for i=1:nclusters
 clusters{i} = find(idx==exemplars(i));
 clustsize = size(clusters{i},1);

 if(clustsize>sizeconstraint)
    outvars = [outvars,clusters{i}'];
 else
   %vars(clusters{i}')'
   Cliq = [0,clustsize,vars(clusters{i}'),zeros(1,sizeconstraint-clustsize)];
   Cliques = [Cliques;Cliq];
 end
end
if(~isempty(outvars)) 
  if(isempty(Cliques))  
   deep = deep + 1;
  end,

  MI1 = MI(:,outvars);
  MI1 = MI1(outvars,:);
  p = median(MI1); %median(MI1(:));
  %p=  min(MI1(:))+(max(MI1(:))-min(MI1(:)))*rand();  % Set preference to median similarity
  [Cliques1,deep]=FactAffinityElim(MI1,vars(outvars),sizeconstraint,p,deep);
  Cliques = [Cliques;Cliques1];
end



