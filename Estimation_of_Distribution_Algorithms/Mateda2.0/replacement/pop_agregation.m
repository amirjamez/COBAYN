function [NewPop,NewFunVal] = pop_agregation(Pop,SelPop,SampledPop,FunVal,SelFunVal,SampledFunVal,replacement_params)
%  [NewPop,NewFunVal] = pop_agregation(Pop,SelPop,SampledPop,FunVal,SelFunVal,SampledFunVal,replacement_params)
%  pop_agregation                Creates a new population (NewPop) by  selecting the PopSize best individuals
%                               of population Pop and SampledPop altogether 
% INPUTS 
% Pop:                                 Current population
% SelPop:                              Current selected population
% SampledPop:                          Population sampled from the probabilistic model
% CurrentFunVal:                       A matrix of function evaluations, one vector of m objectives for each individual
% replacement__params{1} = find_bestids_method:   Name of the procedure for selecting the k best individuals 
%                                                 from a population (by default is 'fitness_ordering'
% OUTPUTS
% NewPop                        : New Population
% NewFunVal                     : Evaluations of the new population
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       


PopSize = size(Pop,1);
SelPopSize = size(SelPop,1);
SampledPopSize = size(SampledPop,1);

Agregated_Pop = [Pop;SampledPop];
Agregated_PopFunVal = [FunVal;SampledFunVal];
nans = sum(isnan(Agregated_PopFunVal(:,1)));

find_bestinds_method =  char(cellstr(replacement_params{1,1}));
[Ind]  = eval([find_bestinds_method,'(Agregated_Pop,Agregated_PopFunVal)']);  %The k best individuals are taken from Pop
Ind = Ind((nans+1):nans+PopSize);
NewPop = Agregated_Pop(Ind,:);
NewFunVal = Agregated_PopFunVal(Ind,:);

 
return
 
 
 