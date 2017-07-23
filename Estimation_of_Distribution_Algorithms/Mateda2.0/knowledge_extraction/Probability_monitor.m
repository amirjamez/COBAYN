function [Probs] =  Probability_monitor(bnets, point)

% function [Probs] =  Probability_monitor(bnets, point)
%
% Probability_monitor: Computes the probability given by the models to a given point along the generations.
%                      For example, it is useful to calculate the probability of the
%                      optimum point during the search if it is known. 
%                      Nevertheless, it is also useful to calculate the probability of different interesting points such as 
%                      suboptimals. 
% INPUT
% bnets{maxgen}: Cell array that stores the Bayesian networks learned at
%                each generation. It is obtained from Cache{3,:}
% point: Array with the point whose probability will  be computed. For example the
%        optimum point
%
%
% OUTPUT
% Probs: An array with the probability for the given point at each
%        generation. The values are in logarithmic scale. 
%
% Example: (If the algorithm have reached the optimum (it is known))
% optimal_point = AllStat{maxgen,2}
% for i=1:maxgen
%   bnets{i}=Cache{3,i};
% end
% [P] = Probability_monitor(bnets, optimal_point);

% Last version 5/11/2008. Carlos Echegoyen and Roberto Santana (carlos.echegoyen@ehu.es)

k = size(bnets,2);                   % Number of networks
num_vars = size(bnets{1}.dnodes,2);  % Number of variables

for j=1:num_vars
    point_cell{j} = point(j)+1;
end

for i=1:k
    engine = jtree_inf_engine(bnets{i});
    [eng, loglik_point]=enter_evidence(engine,point_cell);
    Probs(i) = exp(loglik_point);
end
