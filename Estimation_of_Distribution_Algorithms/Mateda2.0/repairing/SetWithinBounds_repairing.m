function[NewPop] =  SetWithinBounds_repairing(Pop,RangeValues,repairing_params)
% SetInBounds_repairing:   For a problem with continuous representation
% where solutions are below (above) the contraints modify the solutions to
% a random value within the variables ranges
%                          
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
          n_under = size(under_val,1);          
          NewPop(under_val,i) = RangeValues(1,i) + rand(1,n_under).*(RangeValues(2,i)-RangeValues(1,i));
          over_val = find(Pop(:,i)>RangeValues(2,i));
          n_over = size(over_val,1);
          NewPop(over_val,i) = RangeValues(1,i) + rand(1,n_over).*(RangeValues(2,i)-RangeValues(1,i));
   end   