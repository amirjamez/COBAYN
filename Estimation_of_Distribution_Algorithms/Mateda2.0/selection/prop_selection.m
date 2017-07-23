function[SelPop,SelFunVal]= prop_selection(Pop,FunVal,selection_params)
% [SelPop,SelFunVal]= prop_selection(Pop,FunVal,selection_params)
%
% prop_selection:       Proportional selection for single objective functions
% INPUTS 
% Pop:                          Original population
% FunVal:                       A matrix of function evaluations, one vector of m objectives for each individual
% OUTPUTS
% SelPop: Selected population
% SelFunVal:  A vector of function evaluations for each selected individual
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       
 
   PopSize = size(Pop,1);
   
   minval = min(FunVal)+10^(-60);
   partialsum = (FunVal+minval)/sum(FunVal+minval);  
                                           % minval is used to guarantee a positive selection 
                                           % probability to individuals
                                           % with negative fitness values
   partialsum=cumsum(partialsum);
   Index=sus(PopSize,partialsum);          % Stochastic Universal Sampling is used for sampling individuals
   SelPop=Pop(Index,:);                   
   SelFunVal=FunVal(Index,:);  
   
   return
 
 
 