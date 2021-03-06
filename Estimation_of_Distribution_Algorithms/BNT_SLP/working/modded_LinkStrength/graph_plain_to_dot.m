function graph_plain_to_dot (bnet, filename, varargin)

% FUNCTIONALITY:
%
%   Writes the graph of any BNet to a file in dot-format (GraphViz format).
%
% REQUIRED PARAMETERS:
%
%   bnet: discrete bayesian network 
%
%   filename: name of output file
%
% OPTIONAL PARAMETERS:  
%     see below
%

% By Imme Ebert-Uphoff (2006)

   % Tell user where to find the file
   fprintf(1,'Writing PLAIN Graph to file ''%s''.\n', filename);
 
   % default arguments:
   use_node_names = true;    % Do you want to show node NAMES or node INDICES?
   shape1 = 'ellipse';       % Standard node shape
   shape2 = 'doubleoctagon'; % Currently only used for target node of MI graph 

   % Read optional arguments:
   for i = 1:2:nargin-2   
      switch varargin{i}
         case 'use_node_names', use_node_names = varargin{i+1};
         case 'shape1', shape1 = varargin{i+1};
         case 'shape2', shape2 = varargin{i+1};
      end
   end

   AUX_graph_main ( bnet, filename, 'plain', use_node_names, ...
			    shape1, shape2, false,'',0);

end  % end of function
