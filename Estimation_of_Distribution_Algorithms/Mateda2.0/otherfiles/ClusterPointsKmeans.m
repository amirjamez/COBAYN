function[index,nclusters] = ClusterPointsKmeans(data,distance,nclusters)
% [index,nclusters] = ClusterPointsKmeans(data,distance,nclusters)
% ClusterPointsKmeans:  Clusters a data set using Affinity propagation
%                         and a given distance. The number of clusters
%                         is given.
% INPUT
% data: A vector of data were rows are observations and columns are
% features
% distance: Distance used for clustering (e.g. 'euclidean', 'correlation', 'cosine' ... See help pdist for full list of
%                          possible metrics)
% nclusters: Number of  clusters.
% OUTPUT
% index: Cluster each solution belongs to
% nclusters: Number of clusters
%
% Example
% [index,nclusters] = ClusterPointsKmeans(rand(50,10),'sqEuclidean',5);
% 
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)  

[index,c,sumd,d] = kmeans(data,nclusters,'Distance',distance,'EmptyAction','drop');

nclusters = max(index);    
return 








