function[continue_evolution]=maxgen_maxval(currentgen,currentPop,currentFunVal,stop_cond_params)
% [continue_evolution]=maxgen_maxval(currentgen,currentPop,currentFunVal,stop_cond_params)
% maxgen_maxval            Implements the stop conditions of the algorithm which stops either when a
%                           maximum number of iterations has been reached 
%                           or a given  value of the function has been  reached.
% INPUTS 
% currentgen:                   Current generation.
% Pop:                          Current population
% CurrentFunVal:                       A matrix of function evaluations, one vector of m objectives for each individual
% stop_cond_params{1} = CantGen:   Maximum number of generations
% stop_cond_params{2} = MaxVal:    Maximum value of the function
% OUTPUTS
% continue_evolution= {1,0}  to determine whether to continue with the EDA or stop
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)

CantGen = cell2num(stop_cond_params{1}(1));
MaxVal = cell2num(stop_cond_params{1}(2));

continue_evolution = (max(currentFunVal(:,1))<MaxVal) & (currentgen<CantGen);
 
return
 
 
 