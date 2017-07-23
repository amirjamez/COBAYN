% EXAMPLE 11:  
 % Default EDA for the solution of the evalfuncntrap function
 % The algorithm stops after a max number of generations is reached
 
  PopSize = 1000; n = 45; cache  = [0,0,0,0,0]; Card = 2*ones(1,n); edaparams = {};
  F = 'evalfunctrapn'; % Trap function of parameter k=5;
  global ntrapparam;
  ntrapparam = 5;           % The parameter of the function is passed as a global variable 
  
  [AllStat,Cache]=RunEDA(PopSize,n,F,Card,cache,edaparams) 