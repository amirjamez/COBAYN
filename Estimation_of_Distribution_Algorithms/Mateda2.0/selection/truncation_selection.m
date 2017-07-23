function[SelPop,SelFunVal]=truncation_selection(Pop,FunVal,selection_params)
% [SelPop,SelFunVal]=truncation_selection(Pop,FunVal,selection_params)
% truncation_selection:        Truncation selection
%                              Individuals are ordered according the given
%                              ordering criterion and then, the best T*PopSize are selected.
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
   ordering_criterion =  char(cellstr(selection_params{1}(2)));
   number_objectives = size(FunVal,2);
   SelPopSize = floor(T*PopSize);
   
   
   Index = eval([ordering_criterion,'(Pop,FunVal)']);   
   SelPop = Pop(Index(1:SelPopSize),:);  
   SelFunVal = FunVal(Index(1:SelPopSize),:); 
  
   return
 
   
   
   