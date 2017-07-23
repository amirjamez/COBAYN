function[decep]=Trapn(vector,ntrap)
% [decep]=Trapn(vector,ntrap)
% Trapn:  Evaluation of a partition for trap function with parameter ntrap
% f(x) = f_d(x_1,x_2,...x_{ntrap}) + ...+  f_d(x_{ntrap*m-ntrap-1},x_{ntrap*m-1},x_{ntrap*m})
% INPUTS
% vector: set of variables
% ntrap: number of variables in the trap partition
% OUTPUTS
% decep: Evaluation of the deceptive function
%
% Last version 5/11/2008. Carlos Echegoyen and Roberto Santana(carlos.echegoyen@ehu.es) 

  s=sum(vector);
  if s==ntrap
    decep=ntrap; 
  else
    decep=ntrap-1-s;
  end
 return



