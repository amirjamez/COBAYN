function[results] = ClusterUsingDist(data,distance)
% [results] = ClusterUsingDist(data,distance)
% ClusterUsingDist:     Orders a set of features (or variables) according
%                       their pdist distance
%                       Features with strong similarity will be clustered together
%                       Affinity propagation is used to cluster the
%                       features. Accordingly, the exemplars are also given as an output.
%                       Ordering may help to reduce cluttering in parallel coordinates displaying, improving
%                       visualization.
% INPUT
% data: A vector of data were rows are observations and columns are
% features
% OUTPUT
% results{1} =  A new ordering of the features, were subsequent features
% are suppossed to be more related
% results{2} =  Original clustering (idx) given by the affinity propagation
% algorithm
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)    

nedges = size(data,2);
y = pdist(data', distance);
rho = max(max(y)) - squareform(y); %Affinity propagation maximizes similarity = minimizes distance

s = mean(rho);     % The self-similarity measure is the mean of correlations for each variable
 
[idx,netsim,dpsim,expref]=apcluster(rho,s); % affinity propagation is done to identify clusters of correlated variables

[val,index] = sort(idx); % The variables are ordered according to their exemplar and the new ordering is output

results{1} = index';
results{2} = idx;

return 
