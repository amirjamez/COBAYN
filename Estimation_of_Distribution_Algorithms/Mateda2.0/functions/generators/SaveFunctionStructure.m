function SaveFunctionStructure(filename,NumberVar,ListFactors,Card)
% SaveFunctionStructure(filename,NumberVar,ListFactors,Card)
%
% SaveFunctionStructure:   Saves the structure of a function in the form of a factor graph 
%                       The factor graph has two classes of nodes variable
%                       nodes and factor nodes. Each variable node should
%                       be associated to at least one factor node and
%                       viceversa. There each one edge from each variable
%                       node to the factor it belongs to.
% INPUTS
% filename:  Name of file 
% NumberVar: Number of variables
% ListFactors: Each  cell {i} stores the numb variables in the factor (k+1), the
%              current variable (i), and its k neighbors
% Card: Cardinality of the variables
% OUTPUTS
% file of name 'filename' with the following format:
%
%    Total number of nodes
%    Total number of variable  nodes
%    for i=1 to Total number of variables nodes
%      Variable node (for C compatibility i-1 instead of i is printed to the file) 
%      Cardinality of variable node i
%    end
%    Number of edges in the factor graph
%    for i=1 to Total number of edges
%      variable node incident to  edge i
%      factor node incident to  edge i
%    end
%
% Last version 8/26/2008. Alex Mendiburu and Roberto Santana (roberto.santana@ehu.es) 


totfactors = size(ListFactors,2);
totnodes = totfactors + NumberVar;

membership = zeros(1,NumberVar); % In how many factors is each variable

for i=1:totfactors,     
  sizefactor = size(ListFactors{i},2);    % Size of factor i
  for j=1:sizefactor,
     membership(ListFactors{i}(j)) = membership(ListFactors{i}(j)) + 1;
  end, 
end,
NumberEdges = sum(membership);

fid = fopen(filename,'wt');
 
fprintf(fid,'%d \n',totnodes);  % Total number of nodes
fprintf(fid,'%d \n',NumberVar); % Total number of variable  nodes
  
 for i=1:NumberVar,              % Each variable node and its cardinality
   fprintf(fid,'%d  \n',i-1);    
   fprintf(fid,'%d  \n', Card(i));
 end,

fprintf(fid,'%d \n',NumberEdges); % Number of edges in the factor graph

for i=1:totfactors,      % All the edges are printed
  sizefactor = size(ListFactors{i},2); 
  for j=1:sizefactor,
  fprintf(fid,'%d  \n',ListFactors{i}(j)-1);
  fprintf(fid,'%d  \n',NumberVar+i-1);
  end, 
end,

fclose(fid);

