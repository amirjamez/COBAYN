function[NewPop] = SampleMPE_BN(NumbVar,bnet,Card,AuxPop,AuxFunVal,sampling_params)  
% [NewPop] = SampleMPE_BN(NumbVar,bnet,Card,sampling_params):
%              Samples a population in which the first individual corresponds 
%              to the most probable configuration and the remaining  PopSize-1 individuals 
%              are sampled using Probabilistic Logic Sampling
% INPUTS
% NumbVar:   Number of variables
% bnet:      Bayesian network
% Card:      Cardinality of the variables
% AuxPop: Auxiliary (selected) population (May be use for partial sampling or resampling)
% AuxFunVal: Evaluation of the data set (required for some sampling algorithms, not for this one)
% sampling_params{1}(1) = PopSize: Number of generated individuals 
% OUTPUTS
% NewPop: Sampled individuals
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       

PopSize = cell2num(sampling_params{1}(1)); 

[mpe_solution,prob_value] =  FindMPE(bnet);
if ~isempty(mpe_solution)
 NewPop(1,:) = cell2num(mpe_solution) - 1;
 beg = 2;
else 
 beg = 1;
end

for i=2:PopSize
 NewPop(i,:) = cell2num(sample_bnet(bnet))-1;
end
 
