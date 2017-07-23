function print_all_mutual_information(bnet)

% print_all_mutual_information(bnet) takes bnet and prints 
% mutual information and percentage for ALL node pairs

% By Imme Ebert-Uphoff (2006)
                   
Nnds = length(bnet.dag);

   % Create inference engine
   engine = var_elim_inf_engine(bnet);  % works  
   % jtree doesn't work here, because node pairs may not be in same clique
   evidence = cell(1,Nnds);  % create empty evidence vector
   engine = enter_evidence(engine,evidence);
  
   fprintf(1,'\nPrinting Mutual Information and Percentage for all node pairs\n\n');

   for node1 = 1:Nnds   % for all nodes of network
   for node2 = 1:Nnds   % for all nodes of network
   %  for node2 = (node1+1):Nnds   % for all nodes of network

      if (node1 == node2)  % skip pairs of identical node numbers
        continue;
      end;


      fprintf(1,'  Node Pair (%d,%d)', node1, node2 );
      if ~isempty(bnet.names)
         node1_name = get_key(bnet.names, node1);
         node2_name = get_key(bnet.names, node2);
         fprintf(1,' = (%s,%s)', node1_name, node2_name );
      end
      fprintf(1,':\n' );

      [MI,MI_perc] = calc_mutual_information(bnet, node1, node2, engine);
      fprintf(1,'  MI(%d,%d)   = %f  ', node1, node2, MI);
      if (MI_perc < -99)  % degenerate case indicated by value -100
         fprintf(1,'  MI%%(%d,%d) = Undefined\n\n', node1, node2 );
      else
         fprintf(1,'  MI%%(%d,%d) = %2.1f%%\n\n', node1, node2, MI_perc);
      end

   end  % end of for loop for node2
   end  % end of for loop for node1

fprintf(1,'\n');

end  % end of function
