function[index,nclusters] = ClusterPointsAffinity(data,distance,min_size_cluster)
% [index,nclusters] = ClusterPointsAffinity(data,distance,min_size_cluster)
% ClusterPointsAffinity:  Clusters a data set using Affinity propagation and a given similarity
%                         measure (the opposite of the given distance)
%                         Features with strong similarity will be clustered together
%                         It is guaranteed that all clusters have at least a
%                         minimum number of points. The number of clusters
%                         is automaticly computed by the algorithm. If
%                         affinity propagation does not converge, only one
%                         cluster is given.
% INPUT
% data: A vector of data were rows are observations and columns are
% features
% distance: Distance used for clustering (e.g. 'euclidean', 'correlation', 'cosine' ... See help pdist for full list of
%                          possible metrics)
% min_size_cluster: Minimum number of solutions in each cluster.
% OUTPUT
% index: Cluster each solution belongs to
% nclusters: Number of clusters
%
% Example
% [index,nclusters] = ClusterPointsAffinity(rand(50,10),'euclidean',5);
% 
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)  

npoints = size(data,1);

y = pdist(data, distance);
rho = max(max(y)) - squareform(y); %Affinity propagation maximizes similarity = minimizes distance

s = median(rho);     % The self-similarity measure is the median of correlations for each variable
 
[idx,netsim,dpsim,expref,unconverged]=apcluster(rho,s); % affinity propagation is done to identify clusters of correlated variables

if unconverged
   nclusters = 1;
   index = ones(1,npoints);
else
auxvect = unique(idx);
nclusters = 0;
bigcluster = [];

for i=1:size(auxvect,1),
    members_cluster = find(idx==auxvect(i))';
    sizecluster = size(members_cluster,2);
 if sizecluster >= min_size_cluster
   nclusters = nclusters + 1;
   index(members_cluster) = nclusters;
 else
   bigcluster = [bigcluster,members_cluster];
 end,
end,

if ~isempty(bigcluster)
   nclusters = nclusters+1;
   index(bigcluster) = nclusters;
end,

end
    
index = index';
return 








