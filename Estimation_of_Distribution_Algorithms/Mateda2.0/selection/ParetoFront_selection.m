function[SelPop,SelFunVal]=truncation_selection(Pop,FunVal,selection_params)
% [SelPop,SelFunVal]=truncation_selection(Pop,FunVal,selection_params)
% truncation_selection:        Truncation selection
%                              Individuals are ordered according fitness values (best is the maximum)                          
%                              For multiobjetive functions, individuals are selected according 
%                              average ranking for all the objectives. (i.e. for each objective a truncation 
%                              is done) 
% INPUTS 
% Pop:                 Original population
% FunVal:              A matrix of function evaluations, one vector of m objectives for each individual
% selection_params{1}: Truncation parameter T \in (0,1)
% OUTPUTS
% SelPop: Selected population
% SelFunVal:  A vector of function evaluations for each selected individual
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       
 
   PopSize = size(Pop,1);
   
   T = cell2num(selection_params{1}(1));   % The parameter used by truncation selection is the truncation parameter
   number_objectives = size(FunVal,2);
   SelPopSize = floor(T*PopSize);
   
   [Index] = fitness_ordering(Pop,FunVal,SelPopSize);
  
   SelPop = Pop(Index,:);  
   SelFunVal = FunVal(Index,:); 
  
   return
 
   
   
   