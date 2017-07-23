function[val]=evalfunctrapn(vector)
% [val]=evalfunctrapn(vector)
% evalfunctrapn: Implements the non-overlapping trap function of parameter ntrapparam (passed as a global variable) 
% f(x) = f_d(x_1,x_2,...x_{ntrapparam}) + ...+  f_d(x_{ntrapparam*m-ntrapparam-1},x_{ntrapparam*m-1},x_{ntrapparam*m})
% INPUTS
% vector: set of variables
% ntrapparam: number of variables in the trap partition (passed as a global variable) 
% OUTPUTS
% val: Evaluation of the deceptive function
% Last version 5/11/08. Carlos Echegoyen and Roberto Santana (carlos.echegoyen@ehu.es) 

global ntrapparam
NumbVar = size(vector,2);

val = 0;

for i=1:ntrapparam:NumbVar
   val = val+Trapn(vector(i:i+ntrapparam-1),ntrapparam);
end



