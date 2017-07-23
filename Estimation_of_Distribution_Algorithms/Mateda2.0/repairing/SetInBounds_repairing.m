function[NewPop] =  SetInBounds_repairing(Pop,RangeValues,repairing_params)
% SetInBounds_repairing:   For a problem with continuous representation
%                          Modify the solutions to the minimum (respectivel maximum) bounds 
%                          if variables are under (respectively over) the variables ranges
% INPUTS
% Pop: Population 
% RangeValues: Range of values for each of the variables
% repairing_params: Not use for this function
% OUTPUTS
% NewPop: New repaired population
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       

NumbVar = size(Pop,2);
NewPop = Pop;
   for i=1:NumbVar,
          under_val = find(Pop(:,i)<RangeValues(1,i));
          NewPop(under_val,i) = RangeValues(1,i);
          over_val = find(Pop(:,i)>RangeValues(2,i));
          NewPop(over_val,i) = RangeValues(2,i);
   end   