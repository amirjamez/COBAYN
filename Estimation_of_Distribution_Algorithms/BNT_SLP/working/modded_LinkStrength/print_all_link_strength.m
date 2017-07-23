function print_all_link_strength(bnet)

% By Imme Ebert-Uphoff (2006)
                   
adj = bnet.dag;
Nnds = length(adj);

fprintf(1,'\nPrint Link Strength and Percentage for all edges:\n');
fprintf(1,'  LSTA = Link Strength using TrueAverage  formula\n');
fprintf(1,'  LSBA = Link Strength using BlindAverage formula\n\n');

for parent = 1:Nnds  
  children = find(adj(parent,:));         % children(adj, node);
  for child = children   
      fprintf(1, '  Edge ');    
      if isempty(bnet.names)
         fprintf(1, ' %d -> %d\n', parent, child);    
      else
         parent_name = get_key(bnet.names, parent);        
         child_name = get_key(bnet.names, child);        
         fprintf(1, ' %d -> %d  %s -> %s\n', parent, child, ...
		 parent_name, child_name);    
      end
      [LSTA,LSTA_perc] = calc_link_strength(bnet, parent, child, 'TrueAverage');
      if (LSTA_perc < -99)  % degenerate case indicated by value -100
         fprintf(1, '     LSTA = %.3f     LSTA%% = Undefined\n' , LSTA ); 
      else
         fprintf(1, '     LSTA = %.3f     LSTA%% = %2.1f%%\n' ,LSTA,LSTA_perc);
      end
      [LSBA,LSBA_perc] = calc_link_strength(bnet, parent, child,'BlindAverage');
      if (LSBA_perc < -99)  % degenerate case indicated by value -100
         fprintf(1, '     LSBA = %.3f     LSBA%% = Undefined\n\n' , LSBA ); 
      else
        fprintf(1, '     LSBA = %.3f     LSBA%% = %2.1f%%\n\n', LSBA,LSBA_perc);
      end
    end    
  end

fprintf(1,'\n');

end  % end of function
