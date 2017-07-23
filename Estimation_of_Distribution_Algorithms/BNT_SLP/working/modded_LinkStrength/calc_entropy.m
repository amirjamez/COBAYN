function entropy = calc_entropy(bnet,node,engine)
  
% calc_entropy(...) returns entropy of single node
%
% 'engine' is optional parameter to supply existing inference engine.
% (Otherwise new engine is created every time this function is called, 
%  which can be inefficient.)
%
% By Imme Ebert-Uphoff
%
% Usage:
%    calc_entropy(bnet,node):  
%       returns entropy of node - using newly created inference engine
%    calc_entropy(bnet, node, engine)
%       returns entropy of node - using "engine" for inference.

  EPSILON = AUX_set_epsilon;

% Test whether node # is valid:
   Nnds = length(bnet.dag);
   if ( node < 1 || node > Nnds )
      fprintf(1,'Error - calc_entropy called with invalid node number\n');
      return;
   end;

% Assign inference engine:
   if (nargin >= 3)  % if 3rd input variable exists: use existing engine
      % fprintf(1,'  (Using existing engine.)   ');
   else  % create new inference engine
      % fprintf(1,'  (Creating new engine.)   ');
      engine = jtree_inf_engine(bnet);   % select inference engine
      evidence = cell(1,Nnds);  % create empty evidence vector
      engine = enter_evidence(engine,evidence);
   end;

% Calculate entropy of node:
   marg = marginal_nodes(engine,node);  % marginal probabilities of node
   [n_states,dummy] = size(marg.T);
   entropy=0;
   for state = 1:n_states
      p = marg.T(state);
      if ( p > EPSILON)  % Avoid division by zero (see documentation)
         entropy = entropy + p * log2(1/p);
      end;
   end   % end of for loop (state)

% Deal with numerical error: 
%  if entropy within [-EPSILON,0], set to 0.
   if (entropy < 0 && entropy > -EPSILON) 
      entropy = 0;
   end

end  % end of function
