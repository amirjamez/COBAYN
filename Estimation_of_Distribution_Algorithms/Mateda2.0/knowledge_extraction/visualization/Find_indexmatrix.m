function[m,indexmatrix] = Find_indexmatrix(n)
% [m,indexmatrix] = Find_indexmatrix(n) 
% Find_indexmatrix:   Given a number of variables, creates a structure that
%                     associates an index to every possible edge of a full structure (all related
%                     variables) 
% INPUTS
% n: Number of variables
% OUTPUTS
% m: Number of variables
% indexmatrix: Matrix where entry i,j has the associated index of edge i,j.
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       


m = n*(n+1)/2; % Number of possible edges

indexmatrix = zeros(n,n);  % Matrix of indices for edges
a= 1;
for i=1:n-1  
 for j=i+1:n
  indexmatrix(i,j) = a;    % Each edge has an associated index
  indexmatrix(j,i) = a;
  a = a + 1;
 end
end