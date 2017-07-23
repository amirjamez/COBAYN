function AUX_graph_write_header (bnet,fid,graph_format,want_names,is_percentage,formula,target_node)

% Writes header file for BNet to a dot file (GraphViz format)
%
% format:         Aan be 'plain', 'entropy', 'MI', 'LS' 
% is_percentage:  Applies only for MI, LS. Is this percentage or not?
% formula:        Applies only for LS.  Which formula is used?
%                 Currently only two formulas 'True' or 'Blind' average.

% By Imme Ebert-Uphoff

   fprintf(fid, 'digraph G {\n');

   % If printing with entropy, link strengths or connection strengths, 
   % add label for graph indicating which formula is used, etc.

   switch graph_format 
      case 'entropy'  
         % ========= Label for Entropy graph ===========
         fprintf(fid, ' label = \"Entropy\";\n');

      case 'LS'  
         % ========= Label for Link Strength graph ===========
         %fprintf(fid, ' label = \"Link Strengths using ');
         switch formula
         case 'TrueAverage'
            %fprintf(fid, 'True Average');
         case 'BlindAverage'  
            %fprintf(fid,'Blind Average');
         end
         if (is_percentage) %fprintf(fid,' Percentage');
         end
         %fprintf(fid, '\";\n');

       case 'MI'
          % ========= Label for Mutual Information graph ==========
          fprintf(fid, ' label = \"Mutual Information');
          if (is_percentage) fprintf(fid,' Percentage');
          end
          fprintf(fid, ' for all nodes relative to node ');
          % Construct node name: get name if desired, use index otherwise
          if (want_names && ~isempty(bnet.names) ) 
             node_name = get_key(bnet.names, target_node);
          else
	     node_name = int2str([target_node]); 
          end    
          fprintf(fid, '%s\";\n',node_name);
    end
       
   fprintf(fid,'\n');

end  % end of function

