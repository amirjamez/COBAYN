%%%%%%%%%%%%%%%% MODEL EVALUATION EXAMPLES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%% Example 1: Determination of the k most probable
%%%%%%%%%%%%%%%%            configurations of a model of a random population
%% First, a dataset is generated, a Bayesian network is learned from the
%% set, and the k most probable configurations of the network are found.

% Characteristics of the data set are defined
NumbVar = 10;
Card = 2*ones(1,NumbVar);
N = 20;
Pop = fix(2*rand(N,NumbVar))'+1;


%%%%%  Characteristics of the Bayesian network and learning algorithm set are defined

MaxParent = 5;
scoring_fn = 'bic';
for i=1:NumbVar 
 nodetype{1,i} = 'tabular';
end

% Structure of the Bayesian network are learned
root = 1;
order = randperm(NumbVar);
dag =  learn_struct_K2(Pop,Card,order,'max_fan_in',MaxParent,'scoring_fn',scoring_fn);   

init_bnet = mk_bnet(dag,Card);  
% All nodes are set to be discrete
for i=1:NumbVar 
 init_bnet.CPD{i} = tabular_CPD(init_bnet,i);
end,

% Parameters Bayesian network are learned
bnet = learn_params(init_bnet,Pop);

% Bayesian network is painted
figure
draw_graph(dag);


k = 10;
% k most probable configurations are found
[k_solutions,k_probvalues] =  Find_kMPEs(bnet,k,Card)
