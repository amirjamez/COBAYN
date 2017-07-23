function [MI,MI_perc] = calc_mutual_information(bnet, node1, node2, user_engine)

% calc_mutual_information(...)  returns mutual information and percentage 
%               for node pair (node1, node2)
%
% 'engine' is optional parameter to supply existing inference engine.
% (Otherwise new engine is created every time this function is called, 
%  which can be inefficient.)
%
% By Imme Ebert-Uphoff
%
% Usage:
%    calc_mutual_information(bnet, node1, node2):  
%       returns Mutual Information and Percentage 
%       using newly created inference engine
%
%    calc_mutual_information(bnet, node1, node2, user_engine)
%       returns Mutual Information and Percentage 
%       using supplied 'user_engine' for inference.               

% By Imme Ebert-Uphoff    

   EPSILON = AUX_set_epsilon;

% Test whether nodes are valid:
   Nnds = length(bnet.dag);
   if ( node1<1 || node2<1 || node1>Nnds || node2>Nnds || node1==node2 )
      fprintf(1,'Error - calc_mutual_information called with invalid node pair.\n');
      return;
   end;

% Assign inference engine and calculate entropy:
   if (nargin >= 4)  % if 4th input variable exists: use existing engine
      % fprintf(1,'  (Using existing engine.)   ');

      % calculate entropy with user supplied engine:
      entropy = calc_entropy( bnet, node2, user_engine);

      % assign user-supplied engine also for MI calculation
      engine = user_engine;

   else  % create new inference engine
      % fprintf(1,'  (Creating new engine.)   ');

      % calculate entropy using default engine of calc_entropy function.
      entropy = calc_entropy( bnet, node2 );
 
      % define inference engine for MI calculation 
      engine = var_elim_inf_engine(bnet);  % Alternative
         % The following would result in an error for the ALARM network - still
         % need to figure out why, but don't use for now...
      % engine = jtree_inf_engine(bnet,'clusters',{[node1,node2]});

      evidence = cell(1,Nnds);  % create empty evidence vector
      engine = enter_evidence(engine,evidence);
   end;

% Get probabilities to calculate MI:
   % Get marginal probabilities of single nodes:
   P_X = marginal_nodes(engine, node1);
   P_Y = marginal_nodes(engine, node2);

   % Get Joint Probabilites for node pair
   P_X_Y = marginal_nodes(engine, [node1,node2]); 

   % Get # of discrete states for each node:
   sz = dom_sizes( bnet.CPD{node1} );
   n_states_node1 = sz(length(sz));
   sz = dom_sizes( bnet.CPD{node2} );
   n_states_node2 = sz(length(sz));

% Calculate Mutual Information:
   MI = 0;
   for (node1_state = 1:n_states_node1)
   for (node2_state = 1:n_states_node2)

      % Assign proper value of P_X_Y.T
      % Caution: Note that when accessing joint probabilities, P_X_Y.T,  
      %          the index of smaller node must always comes first !!!
      % --> Usage: P_X_Y.T(i,j) represents
      %        P( min(node1,node2) = i, max(node1,node2) = j )
      if (node1 < node2)  % if nodes already in correct order
         P_x_y = P_X_Y.T(node1_state, node2_state);
      else 
         P_x_y = P_X_Y.T(node2_state, node1_state);
      end;

      if ( P_x_y > EPSILON)  % Avoid degenerate cases (see documentation)
         MI = MI + P_x_y * log2( P_x_y / (P_X.T(node1_state) * P_Y.T(node2_state)) );
      end;
   end
   end
   % fprintf(1,'  MI(%d,%d) = %f\n', node1, node2, MI);

   % Deal with numerical error: 
   %  if MI within [-EPSILON,0], set to 0.
   if (MI < 0 && MI > -EPSILON) 
      MI = 0;
   end

   % calculate Percentage value
   if (entropy < EPSILON) 
      fprintf(1,'Degenerate case for MI%% of node pair (%d,%d).', node1,node2);
      fprintf(1,'  Problem:  Entropy(%d) = 0, thus MI%% not defined!\n',node2);
      MI_perc = -100;  % assign impossible value
   else
      MI_perc = 100 * MI / entropy;
   end

end  % end of function
