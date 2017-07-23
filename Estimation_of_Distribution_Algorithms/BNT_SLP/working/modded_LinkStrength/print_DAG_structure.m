function print_DAG_structure(bnet)
% print_DAG_structure prints number of nodes, their names and all edges

% By Imme Ebert-Uphoff (2006)
                   
adj = bnet.dag;
Nnds = length(adj);

if isempty(bnet.names)
   fprintf(1, '\nThere are %d nodes\n', Nnds);
else 
   fprintf(1,'\nNodes:\n');
   for node = 1:Nnds
       node_name = get_key(bnet.names, node); 
       fprintf(1,'  Node %d: %s\n', node, node_name );
   end
end

fprintf(1,'\nEdges:\n');
for parent = 1:Nnds  
  children = find(adj(parent,:));    % find all children of parent
  for child = children   
      if isempty(bnet.names)
         fprintf(1, '  %d -> %d\n', parent, child);    
      else
         parent_name = get_key(bnet.names, parent);        
         child_name = get_key(bnet.names, child);        
         fprintf(1, '  %d -> %d     %s -> %s\n', parent, child, parent_name, child_name);    
      end
    end    
  end

fprintf(1,'\n');

end  % end of function
