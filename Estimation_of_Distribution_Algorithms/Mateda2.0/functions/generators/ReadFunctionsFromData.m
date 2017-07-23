function[Tables] = ReadFunctionsFromData(filename,ListFactors,Card)
% [Tables] = ReadFunctionsFromData(filename,ListFactors,Card)
% ReadFunctionsFromData:    Read the  values  of a given function whose structure is defined in ListFactors 
% INPUTS
% filename: name of the file with the function
%           File format: First the factor node number (starting at NumberVar and
%              ending in NumbVar+NumberOfNodes). After each factor node number, the
%              values of the function for the factor.
% ListFactors: Each  row i stores the variables in the factor
% Card: Cardinalities of the variables
% OUTPUTS
% Tables{i}: Contains the values for each of the configurations of factor i 
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es) 

fid = fopen(filename,'r');
AllEntries = fscanf(fid,'%f');
fclose(fid);

EntryIndex = 1;
nvars = size(Card,2);

for i=1:size(ListFactors,2)
  currentFactorIndex = AllEntries(EntryIndex) - nvars + 1;
  currentFactor = ListFactors{currentFactorIndex};
  auxTableSize = 1;
  for j=1:size(currentFactor,2)
   auxTableSize = auxTableSize * Card(currentFactor(j)); 
  end
  Tables{currentFactorIndex,:} = AllEntries(EntryIndex+1:EntryIndex+auxTableSize);
  EntryIndex = EntryIndex + auxTableSize + 1;
end

