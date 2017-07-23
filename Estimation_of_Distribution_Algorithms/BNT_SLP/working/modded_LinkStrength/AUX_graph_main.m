function AUX_graph_main (bnet,filename,graph_format,want_names,shape1,shape2,is_percentage,formula,target_node)

% Writes the graph of a BNet to a dot file (GraphViz format)
%
% This is an internal function called by all 'graph_..._to_dot' functions. 
% Do NOT call this function directly.

% By Imme Ebert-Uphoff (2006)

   fid = fopen(filename, 'w');

   switch graph_format
   case 'plain'
      AUX_graph_write_header(bnet, fid, 'plain', want_names, false, '', 0 );
      AUX_graph_write_nodes (bnet, fid, 'plain', want_names,shape1,shape2,false,0);
      AUX_graph_write_arcs  (bnet, fid, 'plain', want_names, false,'');

   case 'entropy'
      AUX_graph_write_header(bnet, fid,'entropy',want_names, false, '', 0 );
      AUX_graph_write_nodes (bnet, fid,'entropy',want_names,shape1,shape2,false,0);
      AUX_graph_write_arcs  (bnet, fid,'entropy',want_names, false,'');

   case 'MI'
      AUX_graph_write_header(bnet, fid,'MI',want_names, is_percentage, '', ...
               target_node );
      AUX_graph_write_nodes (bnet, fid,'MI',want_names,shape1,shape2, ...
               is_percentage,target_node);
      AUX_graph_write_arcs  (bnet, fid,'MI',want_names, is_percentage,'');

   case 'LS'
      AUX_graph_write_header(bnet, fid,'LS',want_names, is_percentage, formula, 0);
      AUX_graph_write_nodes (bnet, fid,'LS',want_names,shape1,shape2, ...
               is_percentage,0);
      AUX_graph_write_arcs  (bnet, fid,'LS',want_names, is_percentage,formula);

   case 'LS2'           % added by francois.olivier.c.h@gmail.com
      AUX_graph_write_header(bnet, fid,'LS',want_names, is_percentage, formula, 0);
      AUX_graph_write_nodes (bnet, fid,'LS2',want_names,shape1,shape2, ...
               is_percentage,target_node);
      AUX_graph_write_arcs  (bnet, fid,'MI',want_names, is_percentage,formula);

   end

   fprintf(fid,'} \n');  % finish up dot-file
   fclose(fid);

end  % end of function
