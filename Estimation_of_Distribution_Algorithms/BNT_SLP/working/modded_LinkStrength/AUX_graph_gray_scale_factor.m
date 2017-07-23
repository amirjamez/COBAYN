function result = AUX_graph_gray_scale_factor (bnet)

% Returns log2(max # of states per node)

% Used to scale values of LS or MI to a range of [0,1] as follows:
%    If percentage is used for LS or MI, then we do not need scaling.
%    Otherwise, divide by log2(max # of states per node),
%    where max is taken over ALL nodes of network.

% By Imme Ebert-Uphoff

   Nnds = length(bnet.dag);

   % Find number of states for all nodes
   for node=1:Nnds
      ds = dom_sizes(bnet.CPD{node});
      % max state is last element of ds:
      n_states(node) = ds(length(ds));
   end
   result = log2(max(n_states));

end  % end of function
