function result = AUX_CPT_value( child_CPT, parent_states, child_state )

% AUX_CPT determines the CPT value corresponding to the 
% provided child_state and vector of parent_states.
%
% child_CPT:      CPT table of considered node
% parent_states:  vector of states of all parents of node 
% child_state  :  state of child node 
%
% By Imme Ebert-Uphoff
%
% Usage Example:
%
%   child_CPT = get_field(bnet.CPD{child},'cpt')  % get CPT for child
%   CPT_value = AUX_CPT_value( child_CPT, parent_states, child_state )
%
% returns value of CPT

   % start with parent states
   dummy_vec = parent_states;
   % append child state at end of vector
   dummy_vec( length(parent_states)+1 )= child_state;
      my_index = AUX_lin_index( child_CPT, dummy_vec );
   result = child_CPT(my_index);
  
end   % end of function
