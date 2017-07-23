function graph_with_link_strength_to_dot2(bnet, filename, is_percentage, target_node, varargin)
%(bnet, filename, target_node, is_percentage, varargin )
%(bnet, filename, formula, is_percentage, varargin )
% FUNCTIONALITY:
%
%  Writes the graph of a DISCRETE BNet to a file in dot-format (GraphViz format)
%  including Link Strength.
%
%  For each arrow in the graph: 
%    Calculate link strength according to 'formula' and 'is_percentage'
%    and write its value underneath the arrow.
%
%  Gray scale:
%     Use gray scale for arrows to emphasize results 
%     (dark = strong connection).
%     If arrow would be too light to see, use dashed line (and light gray)
%     for arrow instead.  
%
% REQUIRED PARAMETERS:
%
%   bnet: discrete bayesian network 
%
%   filename: name of output file
%
%   formula:  
%     if 'TrueAverage'  - Use True Average Link Strength
%     if 'BlindAverage' - Use Blind Average Link Strength
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
   fprintf(1,'Writing LINK STRENGTH '); 
   if (is_percentage)
      fprintf(1,'PERCENTAGE ');
   end
   fprintf(1,'Graph (%s) to file ''%s''.\n', ...
        'TrueAverage', filename);


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
 
   AUX_graph_main ( bnet, filename, 'LS2', use_node_names, ...
			    shape1, shape2, is_percentage, 'TrueAverage' ,target_node);

end  % end of function
