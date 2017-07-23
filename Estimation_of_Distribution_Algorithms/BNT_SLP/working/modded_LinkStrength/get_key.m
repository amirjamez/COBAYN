function key = get_key(A,val)

% Added to Kevin Murphy''s associative array class by Imme Ebert-Uphoff

% GET_KEY(A,val) returns key (=string) corresponding to val of 
% associative array A.

% Caution: This assumes that vals(i) are numbers.
%
% Typical Use: get_key(bnet.names,i) returns name of node i

i = 1;
while ( i <= length(A.keys) )
   if (val == A.vals{i})
      key = A.keys{i};
      return;
  end
  i = i + 1;
end

error(['Invalid index!'])  % complain if index isn't valid
