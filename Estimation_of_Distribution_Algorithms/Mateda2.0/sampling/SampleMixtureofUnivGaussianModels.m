function [NewPop] =  SampleMixtureofUnivGaussianModels(NumbVar,model,RangeValues,AuxPop,AuxFunVal,sampling_params)
% [NewPop] = SampleMixtureofUnivGaussianModels(NumbVar,model,RangeValues,AuxPop,AuxFunVal,sampling_params)
% SampleMixtureFullGaussianModels:         Samples a population of individuals from
%                                          a mixture of full multivariate Gaussian  model
% INPUTS
% NumbVar: Number of variables
% model: model{1,i} = mean of the variables for solutions in  cluster i
%        model{2,i} = covariance of the variables for solutions in cluster i
%        model{3,i} = coefficient associated to component i of the mixture
% RangeValues: Matrix of two vectors with the minimum and maximum real values 
%              each variable can take 
% AuxPop: Auxiliary (selected) population (May be use for partial sampling or resampling)
% AuxFunVal: Evaluation of the data set (required for some sampling algorithms, not for this one)
% sampling_params{1,1} = PopSize: Number of generated individuals 
% sampling_params{1,2} = var_scaling: Scaling for the covariance values. A
%                        very low variance tends to move the algorith to stagnation. Scaling is a partial 
%                        solution to this problem. Dynamic scaling should
%                        be implemented as a more robust solution
% OUTPUTS
% NewPop: Sampled individuals
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)  

PopSize = cell2num(sampling_params{1}(1)); 
var_scaling = cell2num(sampling_params{1}(2)); 

nclusters = size(model,2);
for j=1:nclusters
 prob_vector(j) = model{3,j};
end
partialsum=cumsum(prob_vector);

Index=sus(PopSize,partialsum);  % Individuals to be selected from each cluster

for i=1:PopSize,
 vars_means = model{1,Index(i)};
 vars_sigmas =   var_scaling*model{2,Index(i)};
 NewPop(i,:) = normrnd(vars_means,vars_sigmas); 
end  
  
return;