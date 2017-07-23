function [new_states, success] = AUX_increment_state(old_states, limits, skip_index)

% AUX_increment_state(...) increments state vector "current_states" 
%   Incrementation is from right to left, 
%   i.e. last element of vector is incremented first. 
%
% current_states:  vector of current state numbers
% limits:          vector of maximal state numbers
% skip_index:      optional parameter, if on index is to be kept constant 
%
% By Imme Ebert-Uphoff
%
% Usage:
%    [new_states,success] = AUX_increment_state(old_states, limits)
% or
%    [new_states,success] = AUX_increment_state(old_states, limits, skip_index)
%
% returns new state vector and "true" if incrementation was successful
%                              "false" if incrementation failed
%                              (if last state was already reached)

   if (nargin <= 2)  % if function called WITHOUT optional parameter 
      skip_index = 0;  % assign impossible index
   end

   new_states = old_states;     % initialize new state vector
   index = length(old_states);  % start with LAST element of vector

   while (index > 0)
      if ( index ~= skip_index )  % unless index is to be skipped
         if ( new_states(index) < limits(index) )  
	    % unless max state already reached for this node:
	    % increment state of this node
	    new_states(index) = new_states(index)+1;
            success = true;
            return;	   
	 else  % overflow occurred for this node
	    new_states(index) = 1;  % reset this node to minimal state 
         end
      end
      index = index-1;  % increment next node
   end  % of while loop

   % last index reached and still no incrementation possible --> end reached
   success = false;
   return;

end   % end of function
