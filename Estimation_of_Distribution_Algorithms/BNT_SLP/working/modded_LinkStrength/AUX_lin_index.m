function result = AUX_lin_index( the_matrix, index_vec )

% AUX_lin_index converts the vector of indices, index_vec,
% to a linear index.
% Primary use so far: to access CPT value given a VECTOR of states.
%
% the_matrix: matrix to read entry out of  
% index_vec:  vector of indices to be converted
%
% By Imme Ebert-Uphoff
%
% Usage Example:
%   CPT_value = AUX_lin_index( size(CPT), state_vec )
%
% returns new linear index

   dims = size(the_matrix);  % vector of matrix dimensions

   % Overwrite dims for special cases: empty, scalar, vector
   if (length(dims)==2)  % in all special cases dims is two-dimensional  
      if (isempty(the_matrix))   dims = []; result=0; return;
      elseif (isscalar(the_matrix))  dims = [1];
      elseif (isvector(the_matrix))  dims = [numel(the_matrix)];
      end
   end

   result = index_vec(length(dims))-1;
   for i=length(dims)-1:-1:1
      result = result * dims(i);
      result = result + index_vec(i)-1;
   end
   result = result +1;

end   % end of function
