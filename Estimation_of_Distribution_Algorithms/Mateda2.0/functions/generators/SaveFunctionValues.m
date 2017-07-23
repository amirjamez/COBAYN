function []  = SaveFunctionValues(filename,NumberVar,ListFactors,Table)
% []  = SaveFunctionValues(filename,NumberVar,ListFactors,Table)
% SaveFunctionValues:  Saves in a file the  values  of a given function whose structure is defined in ListFactors 
% INPUTS
% filename: name of the file with the function 
%           File format: First the factor node number (starting at NumberVar and
%           ending in NumbVar+NumberOfNodes). After each factor node number, the
%           values of the function for the factor.
% NumberVar: Number of variables
% ListFactors: Each  row i stores the variables in the factor
% Tables{i}: Contains the values for each of the configurations of factor i 
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es) 

totfactors = size(ListFactors,2);

fid = fopen(filename,'wt');
 for i=1:totfactors,     
  fprintf(fid,'%d  \n',NumberVar+i-1); % Factor number
  sizetable = size(Table{i},2);    % Size of potential for factor i
  for j=1:sizetable,
   fprintf(fid,'%f \n',Table{i}(j)); %Potentials are printed  
  end, 
 end, 
 
fclose(fid);

