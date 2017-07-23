function graph_with_mutual_info_to_dot (bnet, filename, target_node, is_percentage, varargin )

% FUNCTIONALITY:
%
%  Writes the graph of a DISCRETE BNet to a file in dot-format (GraphViz format)
%  including Mutual Information.
%
%  For each node (other than target_node): 
%     Calculate mutual information relative to target_node.
%     and write its value underneath the node name
%
%  For target node:
%     Use different shape (shape2) for target node,
%     calculate entropy value and write its value underneath node name.
%	
%  Gray scale:
%     Use gray scale for nodes to emphasize results 
%     (dark = strong connection to target node).
%     Cap darkness to a maximal value if node name would otherwise be 
%     impossible to read.
%
%
% REQUIRED PARAMETERS:
%
%   bnet: discrete bayesian network 
%
%   filename: name of output file
%
%   target_node: index of node relative to which to calculate mutual information
%
%   is_percentage:
%     if 'false' - Use Standard Mutual Information Value
%     if 'true'  - Use Percentage Value
%
% OPTIONAL PARAMETERS:  
%     see below
%

% By Imme Ebert-Uphoff (2006)

   % Tell user where to find the file
   fprintf(1,'Writing MUTUAL INFORMATION ');
   if (is_percentage)
      fprintf(1,'PERCENTAGE ');
   end
   fprintf(1,'Graph for target node %d to file ''%s''.\n', ...
	target_node, filename);

   % default arguments:
   use_node_names = true;    % Do you want to show node NAMES or node INDICES?
   shape1 = 'ellipse';       % Standard node shape
   shape2 = 'doubleoctagon'; % Currently only used for target node of MI graph 

   % Read optional arguments:
   for i = 1:2:nargin-4   
      switch varargin{i}
         case 'use_node_names', use_node_names = varargin{i+1};
         case 'shape1', shape1 = varargin{i+1};
         case 'shape2', shape2 = varargin{i+1};
      end
   end

   AUX_graph_main ( bnet, filename, 'MI', use_node_names, ...
			    shape1, shape2, is_percentage, '' ,target_node);

end  % end of function
