function print_entropy(bnet)
% print_entropy(adj) takes bnet and prints entropy of all nodes

% By Imme Ebert-Uphoff (2006)
                   
adj = bnet.dag;
Nnds = length(adj);

% Preparation for inference (to infer marginal probabilities later on)
   engine = jtree_inf_engine(bnet);   % select inference engine
      % assign (empty) evidence list to engine:
   evidence = cell(1,Nnds);  % create empty evidence vector
   [engine,loglik] = enter_evidence(engine,evidence);
      % loglik now contains the log-likelihood of the evidence (not used here)
  

   fprintf(1, '\nPrinting entropy of all nodes\n\n');
   for node = 1:Nnds   % for all nodes of network
      node_name = '';  
      if ~isempty(bnet.names) 
         node_name = get_key(bnet.names, node); 
      end       
      % print node number, and, if available, node_name:
      fprintf(1,'  Node %d: %s\n', node, node_name );
      entropy = calc_entropy( bnet, node, engine);
      fprintf(1,'  Entropy: %f\n', entropy);
      fprintf(1,'\n');

   end  % end of for loop
   fprintf(1,'\n');

end  % end of function
