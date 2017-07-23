% EXAMPLE 1: One Max Funtion. Default parameters
  
  PopSize = 300; n = 45; cache  = [0,0,0,0,0]; Card = 2*ones(1,n); edaparams = {};
  F = 'sum'; % Onemax function;
  [AllStat,Cache]=RunEDA(PopSize,n,F,Card,cache,edaparams) 
