function[NewPop] =  Trigom_repairing(Pop,RangeValues,repairing_params)
% [NewPop] =  Trigomn_repairing(Pop,RangeValues,repairing_params)
% Trigon_repairing:   For a problem with continuous representation
% where solutions are in [0,2pi], modifies the unfeasible solutions to
% be in this interval
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
          NewPop(under_val,i) = rem(Pop(under_val,i),2*pi)+2*pi;
          over_val = find(Pop(:,i)>RangeValues(2,i));
          n_over = size(over_val,1);
          NewPop(over_val,i) = rem(Pop(over_val,i),2*pi);
   end   