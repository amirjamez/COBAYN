function [FAN] = learn_struct_fan(data, node_sizes, class_node, scoring_fn, alpha, node_types)
% LEARN_STRUCT_FAN Learn the structure of the forest augmented naive bayesian network 
% dag = learn_struct_fan(data, node_sizes, class_node, scoring_fn , alpha)
%
% Input :
%       data(i,m) is the value of node i in case m
%       node_sizes = 1 if gaussian node,
%       class_node is the class node, if class_node=[] then searching a forest (default [])
%       scoring_fn = 'bic' or 'mutual_info' (default 'bic')
%       0 < alpha < 0.1 is the limit confidence value (default 0.05 or 0.001 if all nodes are binary)
%           `-> to perform early stop in the Kruskal's algorithm
%       node_types (default all 'tabular' nodes)
%
% Output :
%	dag = adjacency matrix of the dag
%
% V1.0 : 12 october 2006, (francois.olivier.c.h@gmail.com)

N=size(data,1);

if nargin<6, for i=1:N, node_type{i}='tabular'; end, end
if nargin<5, alpha=0.05; if mean(node_sizes)==2, alpha=0.001; end, end
if nargin<4, scoring_fn='bic'; end
if nargin<3, class_node=[]; end

NC=mysetdiff(1:N,class_node);
discrete=1:N;
if isempty(class_node), N=N+1; end

score_mat=zeros(N-1,N-1);

switch scoring_fn
case 'bic',
    for i=1:(N-2)
            score21 = score_family(NC(i), [class_node], node_type{NC(i)}, scoring_fn, node_sizes, discrete, data,[]);
        for j=(i+1):(N-1)
%              score22 = score_family(NC(j), [class_node], node_type{NC(j)}, scoring_fn, node_sizes, discrete, data,[]);
            score11 = score_family(NC(i), [NC(j),class_node], node_type{NC(i)}, scoring_fn, node_sizes, discrete, data,[]);
%              score12 = score_family(NC(j), [NC(i),class_node], node_type{NC(j)}, scoring_fn, node_sizes, discrete, data,[]);
            score_mat(j,i) = score11-score21;
%              score_mat(i,j) = score12-score22;
            score_mat(i,j) = score_mat(j,i);
        end
    end
case 'mutual_info',         % ONLY for tabular nodes 
    for i=1:(N-2)
      score_mat(i,i)=0;
      for j=(i+1):(N-1)
        if ~isempty(class_node),
          score_mat(i,j) = cond_mutual_info_score(NC(i),node_sizes(NC(i)),NC(j),node_sizes(NC(j)),class_node,node_sizes(class_node),data);
%            score_mat(j,i) = cond_mutual_info_score(NC(j),node_sizes(NC(j)),NC(i),node_sizes(NC(i)),class_node,node_sizes(class_node),data);
            score_mat(j,i) = score_mat(i,j);
        else
          score_mat(i,j) = mutual_info_score(NC(i),node_sizes(NC(i)),NC(j),node_sizes(NC(j)),data);
%            score_mat(j,i) = mutual_info_score(NC(j),node_sizes(NC(j)),NC(i),node_sizes(NC(i)),data);
            score_mat(j,i) = score_mat(i,j);
        end
      end
    end
otherwise,
    error(['unrecognized scoring fn ' scoring_fn]);
end
weight_mat=-score_mat;
weight_mat(find(weight_mat>=0))=Inf;
shift=-min(weight_mat(:));
weight_mat=weight_mat+shift;

switch scoring_fn
case 'bic',
  limit=shift-max(weight_mat(find(weight_mat~=Inf)))*alpha;
  forest = minimum_spanning_forest(weight_mat, limit);
case 'mutual_info',
  limit = shift-alpha;
  forest = minimum_spanning_forest(weight_mat, limit);
otherwise,
    error(['unrecognized scoring fn ' scoring_fn]);
end

if ~isempty(class_node),
  FAN=zeros(N);
  FAN(NC,NC)=pdag_to_dag(forest);
  FAN(class_node,NC)=1;
else
  FAN=pdag_to_dag(forest);
end

