function[val]=Deceptive3(vector)
% [val]=Deceptive3(vector)
% Deceptive3: Building block of the non-overlapping deceptive3 function introduced by Goldberg  
%             f(x) = f_d(x_1,x_2,x_3) + f_d(x_4,x_5,x_6) + ...+  f_d(x_{3m-2},x_{3m-1},x_{3m})
% INPUTS
% vector: set of 3 variables
% OUTPUTS
% val: Evaluation of the deceptive function
%
% Last version 10/10/2005. Roberto Santana (rsantana@si.ehu.es)

  s=sum(vector);
  if s==3
    val=1; 
  elseif s==1
    val=0.8; 
  elseif s==2
    val=0; 
  else
    val=0.9;
  end
 return


 
