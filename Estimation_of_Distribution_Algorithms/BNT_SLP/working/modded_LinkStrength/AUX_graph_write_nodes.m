function AUX_graph_write_nodes (bnet,fid,graph_format,want_names,shape1,shape2,is_percentage,target_node)

% Writes all nodes for bnet to a dot file (GraphViz format)
%
% graph_format:   Can be 'plain', 'entropy', 'MI', 'LS' 
% is_percentage:  Only relevant here for MI. Is this percentage or not?

% By Imme Ebert-Uphoff

%   shape1 = 'ellipse';  % standard node shape
%   shape2 = 'doubleoctagon'; % node shape to indicate target node for MI
   adj = bnet.dag;
   Nnds = length(adj);

   % Create inference engine - only needed for Mutual Information:
   if (strcmp(graph_format,'MI'))
      engine = var_elim_inf_engine(bnet); % not optimal, but works
      % engine = jtree_inf_engine(bnet);  % does not work for all node pairs
      % engine = global_joint_inf_engine(bnet); % works, but grows exponentially
      % engine = enumerative_inf_engine(bnet);  % works, but extremely slow

      evidence = cell(1,Nnds);  % create empty evidence vector
      engine = enter_evidence(engine,evidence);
   end

   if (strcmp(graph_format,'MI') && ~is_percentage)
      scale_factor = AUX_graph_gray_scale_factor(bnet);
   else 
      scale_factor = 1.0;
   end

   for node = 1:Nnds  
      % Construct node name: get name if desired, use index otherwise
      if want_names && ~isempty(bnet.names) 
         node_name = get_key(bnet.names, node);
      else
	 node_name = int2str([node]); 
      end    

      switch graph_format
      case {'plain','LS'}
         % For Plain Graph and for Link Strength Graph: 
         % Write single node with only its name
         % Format:  "nodeName" [shape1]
         fprintf(fid, ' \"%s\" [shape=%s];\n', node_name, shape1);

      case 'entropy'
         % For Entropy Graph and for target_node of Mutual Information Graph:
         % Write single node with entropy value underneath its name
         % Format: "node_name [shape=shape1,label="nodename\n(Entropy=value)"];"
	 entropy = calc_entropy(bnet,node);
         fprintf(fid, ' \"%s\" [shape=%s,',node_name, shape1);
         fprintf(fid, ' label=\"%s\\n(Entropy=%.2f)\"];\n',node_name,entropy);

      case 'MI'
         % For Mutual Information Graph

         if (node == target_node)
         % for target_node: write entropy value and use 2nd node shape
   	    entropy = calc_entropy(bnet,node);
            fprintf(fid, ' \"%s\" [shape=%s,',node_name,shape2);
            fprintf(fid, ' label=\"%s\\n(Entropy=%.3f)\"];\n',node_name,entropy);
	 else
         % for all other nodes: write MI value underneath and color 
         % node in gray scale

	      % Step 1:calculate mutual information and assign gray value
              %[MI,MI_perc] = calc_mutual_information( bnet, node, target_node );
              [MI,MI_perc] = calc_mutual_information( bnet, node, target_node, engine);

              if (is_percentage)  % want percentage_value
                 % Set gray value:  percentage is between 0 and 100
		 gray_value = 100.0-abs(MI_perc);  
              else
                 % Set gray value: (MI / scale_factor)  is between 0 and 1
		 gray_value = 100*(1.0-MI/scale_factor);
              end
              % to make sure you can still read node label: 
              % set gray to at least 30
	      if (gray_value < 30)  gray_value = 30; end 

	      % Write to file something like this:
	      % "Y" [shape=ellipse,style=filled,fillcolor=gray50,
	      %      label="Y\n(0.543)"];
	      % or:  "Y" [shape=ellipse,style=filled,fillcolor=gray50,
	      %      label="Y\n(5.4%)"];

              fprintf(fid,' \"%s\"',node_name);
              fprintf(fid,' [shape=%s,style=filled,fillcolor=gray%02.0f,',...
		      shape1,gray_value);
              if (is_percentage)
	         if (MI_perc < -99)  % degenerate case
                    fprintf(fid,' label=\"%s\\n(Undefined)\"]\n',node_name);
		 else
                    fprintf(fid,' label=\"%s\\n(%2.1f%%)\"]\n',node_name,MI_perc);
	         end
              else  % not a percentage
                 fprintf(fid,' label=\"%s\\n(%.3f)\"]\n',node_name,MI);
              end
         end % end of if

      case 'LS2'           % added by francois.olivier.c.h@gmail.com
         % For LinkStrengh Graph

         if (node == target_node)
         % for target_node: write entropy value and use 2nd node shape
%   	    entropy = calc_entropy(bnet,node);
            fprintf(fid, ' \"%s\" [shape=%s,',node_name,shape2);
            fprintf(fid, ' label=\"%s\\n\"];\n',node_name);
	 else
         % for all other nodes: write LS value underneath and color 
         % node in gray scale

	      % Step 1:calculate link strenght and assign gray value
              [MI,MI_perc] = calc_link_strength(bnet, target_node, node,'BlindAverage');

              if (is_percentage)  % want percentage_value
                 % Set gray value:  percentage is between 0 and 100
		 gray_value = 100.0-min(abs(MI_perc),66);  
              else
                 % Set gray value: (MI / scale_factor)  is between 0 and 1
		 gray_value = 100*(1.0-MI/scale_factor);
              end
	      if (gray_value < 30)  gray_value = 30; end 

              fprintf(fid,' \"%s\"',node_name);
              fprintf(fid,' [shape=%s,style=filled,fillcolor=gray%02.0f,',...
		      shape1,gray_value);
              if (is_percentage)
	         if (MI_perc < -99)  % degenerate case
                    fprintf(fid,' label=\"%s\\n(Undefined)\"]\n',node_name);
		 else
                    fprintf(fid,' label=\"%s\\n(%2.1f%%)\"]\n',node_name,MI_perc);
	         end
              else  % not a percentage
                 fprintf(fid,' label=\"%s\\n(%.3f)\"]\n',node_name,MI);
              end

       end % end of switch
   end % end of for loop

   fprintf(fid,'\n');

end  % end of function
