function [NewPop,NewFunVal] = best_elistism(Pop,SelPop,SampledPop,FunVal,SelFunVal,SampledFunVal,replacement_params)
% [NewPop,NewFunVal] = best_elistism(Pop,SelPop,SampledPop,FunVal,SelFunVal,SampledFunVal,replacement_params)
% best_elitism:              Creates a new population (NewPop) joining (all) the best individuals
%                           individuals in SelPop with the SamplePopSize best individuals from SampledPop 
%                           This method is appropriate for truncation selection and it should be  enforced that
%                           SamplePopSize = PopSize - SelPopSize.
% INPUTS 
% Pop:                                 Current population
% SelPop:                              Current selected population
% SampledPop:                          Population sampled from the probabilistic model
% CurrentFunVal:                       A matrix of function evaluations, one vector of m objectives for each individual
% OUTPUTS
% NewPop                        : New Population
% NewFunVal                     : Evaluations of the new population
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       


find_bestinds_method = char(cellstr(replacement_params{1,1}));
PopSize = size(Pop,1);
SelPopSize = size(SelPop,1);
SampledPopSize = size(SampledPop,1);

AuxPopSize = PopSize - SelPopSize;

[Ind]  = eval([find_bestinds_method,'(SampledPop,SampledFunVal)']);  % The  best AuxPopSize individuals are found
Ind = Ind(1:AuxPopSize);

NewPop(1:AuxPopSize,:) = SampledPop(Ind,:);
NewFunVal(1:AuxPopSize,:) = SampledFunVal(Ind,:);

NewPop(AuxPopSize+1:PopSize,:) = SelPop;
NewFunVal(AuxPopSize+1:PopSize,:) = SelFunVal;

 
return
 
 
 