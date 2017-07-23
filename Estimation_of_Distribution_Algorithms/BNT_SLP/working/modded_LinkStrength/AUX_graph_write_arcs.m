function AUX_graph_write_arcs (bnet,fid,graph_format,want_names,is_percentage,formula)

% Writes all arcs for bnet to a dot file (GraphViz format)
%
% graph_format:   Can be 'plain', 'entropy', 'MI', 'LS' 
% is_percentage:  Only relevant here for MI. Is this percentage or not?

% By Imme Ebert-Uphoff

   adj = bnet.dag;
   Nnds = length(adj);

%   % Create inference engine - only needed for Mutual Information:
%   if (strcmp(graph_format,'MI'))
%      engine = var_elim_inf_engine(bnet); % not optimal, but works
%      % engine = jtree_inf_engine(bnet);  % does not work for all node pairs
%      % engine = global_joint_inf_engine(bnet); % works, but grows exponentially
%      % engine = enumerative_inf_engine(bnet);  % works, but extremely slow
%
%      evidence = cell(1,Nnds);  % create empty evidence vector
%      engine = enter_evidence(engine,evidence);
%   end

   if ( strcmp(graph_format,'LS') && ~is_percentage)
      scale_factor = AUX_graph_gray_scale_factor(bnet);
   else 
      scale_factor = 1.0;
   end

   for parent = 1:Nnds  
      % Construct parent node name: get name if desired, use index otherwise
      if (want_names && ~isempty(bnet.names) )
         parent_name = get_key(bnet.names, parent);
      else
	 parent_name = int2str([parent]); 
      end

      children = find(adj(parent,:));         % find indices of all children
      for child = children
         % Construct child name: get name if desired, use index otherwise
         if want_names && ~isempty(bnet.names) 
            child_name = get_key(bnet.names, child);
         else
	    child_name = int2str([child]); 
         end

         switch graph_format
         case {'plain','entropy','MI'}
            % For Plain, Entropy and Mutual Information Graph: 
		 % Write arcs without labels:
		 %  Example:  "Rain" -> "Wet";
	    fprintf(fid, ' \"%s\" -> \"%s\";\n', parent_name, child_name); 

         case {'LS'}
	    % For Link Strength Graph: write link strength on each arrow
            % and use appropriate gray scale for line of arrow.
	    [LS,LS_perc] = calc_link_strength(bnet, parent, child, formula);

            % calculate gray value between 0 (black) and 100 (white)
            if (is_percentage)
		    % Percentage is already in [0,100], just invert
	       %gray_value = 100.0-abs(LS_perc);   
	       gray_value = 100.0-min(abs(25*LS_perc),90);   
            else
		    % LS/scale_factor is within [0,1]
	       gray_value = 100*(1.0-LS/scale_factor);
            end 

            % if gray_scale too light to see, make darker (i.e. cap at 90) 
            % and use dashed line instead to indicate the change
            % weak_link indicates whether dashed or solid line
            if (gray_value > 90)  
               gray_value = 90; 
               weak_link = false; 
	    else 
	       weak_link = false;
            end
 
            % write expression    "parentName" -> "nodeName"        to file
	    fprintf(fid, ' \"%s\" -> \"%s\"', parent_name, child_name); 
            % write label and gray_scale for arc. 
            % Ex: ``[label="0.4",color=gray60];'' or ``[label="60.1%", ...]''
            if (is_percentage)
               if (LS_perc < -99)  % degenerate case
	          fprintf(fid, ' [label=\"Undefined\",color=gray%02.0f', ...
                       gray_value);
               else
	          fprintf(fid, ' [label=\"%2.1f%%\",color=gray%02.0f', ...
                       LS_perc,gray_value);
	       end
            else
	       fprintf(fid, ' [label=\"%.3f\",color=gray%02.0f', ...
                       LS,gray_value);
            end
	    if (weak_link)
		    fprintf(fid,',style=dashed];\n');
            else 
		    fprintf(fid,'];\n');
            end

         end % of switch graph_format
      end % of for child loop
   end % of for parent loop

   fprintf(fid,'\n');

end  % end of function
