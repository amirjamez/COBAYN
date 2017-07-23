function[MPEs] = Most_probable_explanations(bnets,func)
% function[MPEs] = Most_probable_explanations(bnets,func)
%
% Most_probable_explanations: Computes the most probable explanation and its fitness value at each
%                             generation given the corresponding Bayesian network
%
% INPUT
% bnets{maxgen}: Cell array that stores the Bayesian networks learned at
%                each generation
% func:          The fitness function used in the EDA execution
%
%
% OUTPUT
% MPEs: Cell array that stores the most probable configuration, its 
%       probability values and its fitness function at each
%       generation.
%
%       MPEs{1,i}: An array with the point with highest probability at generation i
%       MPEs{2,i}: The probability value for the MPE at generation i. It  
%                  is an array where MPEs{2,i}(1,1) is the probability
%                  in logarithmic scale and MPEs{2,i}(1,2)
%                  is the original probability value. 
%       MPEs{3,i}: The fitness function value for the MPE at generation i
%
% Example: 
% for i=1:maxgen
%   bnets{i}=Cache{3,i};
% end
% [MPEs] = Most_probable_explanations(bnets, F);
%
% The fitness function corresponding to the most probable configurations are shown
% for i=1:maxgen
%   fo_mpes(i)=MPEs{3,i};  
% end
% X=[1:maxgen];
% plot(X,fo_mpes);
%
% Last version 5/11/08. Carlos Echegoyen and Roberto Santana(carlos.echegoyen@ehu.es) 

k = size(bnets,2); % Number of net
num_vars = size(bnets{1}.dnodes,2); % Number of variables

for i=1:k
   [mpe_solution,prob_value] =  FindMPE(bnets{i});
    MPEs{1,i} = cell2num(mpe_solution)-1;
    MPEs{2,i} = prob_value;
    MPEs{3,i} = feval(func,MPEs{1,i});
end

