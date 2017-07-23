function forest = minimum_spanning_forest(weight_mat, limit)
% Find the minimum spanning forest using Kruskal's algorithm.
% weight_mat(i,j) is the cost of connecting i to j, MUST BE POSITIVE
% We assume that absent edges have (Inf) cost.
% To find the maximum spanning tree, used -weight_mat.

if nargin<2, limit=Inf; end

N=length(weight_mat);
forest=zeros(N);
costs = reshape(weight_mat,1,N*N);
[ascend_costs, ascend_edges] = sort(costs);
endsearch=min(find(ascend_costs>limit))-1;

for i=1:endsearch
  forest(ascend_edges(i))=1;
  if ~acyclic(forest,0), forest(ascend_edges(i))=0; end
end
