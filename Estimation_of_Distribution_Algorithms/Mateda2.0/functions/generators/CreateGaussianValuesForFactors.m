function [Table] = CreateGaussianValuesForFactors(totfactors,J,T)
% [Table] = CreateGaussianValuesForFactors(totfactors,J,T)
% CreateGaussianValuesForFactors: Generate function using values from a Normal distribution of mean J and
%                                 variance 1
% INPUTS
% totfactors: Number of cactors
%          J: Mean of the Gaussian distribution
%          T: Temperature parameter
% OUTPUTS
% Tables{i}: Contains the values for each of the 2^k configurations of
%            factor 
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es) 

for i=1:totfactors
 Jij =  normrnd(J,1);  
 Table{i}(1) = Jij;
 Table{i}(2) = -1*Jij;
 Table{i}(3) = -1*Jij;
 Table{i}(4) = Jij;
 Table{i} = exp(Table{i}/T);
end,