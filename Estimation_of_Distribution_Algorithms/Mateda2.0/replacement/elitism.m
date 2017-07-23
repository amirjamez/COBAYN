function [NewPop,NewFunVal] = elistism(Pop,SelPop,SampledPop,FunVal,SelFunVal,SampledFunVal,replacement_params)
% [NewPop,NewFunVal] =  elistism(Pop,SelPop,SampledPop,FunVal,SelFunVal,SampledFunVal,replacement_params)
% elitism:                  Creates a new population (NewPop) with the k best
%                           individuals of Pop and the (PopSize-k) best individuals from SampledPop 
% INPUTS 
% Pop:                                 Current population
% SelPop:                              Current selected population
% SampledPop:                          Population sampled from the probabilistic model
% CurrentFunVal:                       A matrix of function evaluations, one vector of m objectives for each individual
% replacement__params{1} = k:          Number of elistist solutions
% replacement__params{2} = find_bestids_method:   Name of the procedure for selecting the k best individuals 
%                                                 from a population (by default is 'fitness_ordering'
% OUTPUTS
% NewPop                        : New Population
% NewFunVal                     : Evaluations of the new population
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       


PopSize = size(Pop,1);
SelPopSize = size(SelPop,1);
SampledPopSize = size(SampledPop,1);


k = cell2num(replacement_params{1}(1));
find_bestinds_method = char(cellstr(replacement_params{1}(2)));

[Ind]  = eval([find_bestinds_method,'(Pop,FunVal)']);  %The k  best individuals are taken from Pop
Ind = Ind(1:k);
NewPop(1:k,:) = Pop(Ind,:);
NewFunVal(1:k,:) = FunVal(Ind,:);

[Ind]  = eval([find_bestinds_method,'(SampledPop,SampledFunVal)']); %The PopSize - k best individuals are taken from SampledPop
Ind = Ind(1:PopSize-k);
NewPop(k+1:PopSize,:) = SampledPop(Ind,:);
NewFunVal(k+1:PopSize,:) = SampledFunVal(Ind,:);

 
return
 
 
 