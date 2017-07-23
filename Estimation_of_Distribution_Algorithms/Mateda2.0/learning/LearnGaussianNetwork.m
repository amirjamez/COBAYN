function[bnet] =  LearnGaussianNetwork(k,NumbVar,Card,AuxPop,AuxFunVal,learning_params)
% [bnet] = LearnGaussianNetwork(k,NumbVar,Card,AuxPop,AuxFunVal,learning_params)
% LearnGaussianNetwork:     Learns the Gaussian network from the given population using
%             Gaussian network learning algorithms of the BNtools and
%             libraries (see references in the documentation)
% INPUTS
% k: Current generation
% NumbVar: Number of variables
% AuxPop: Selected population (data set for learning the BN
% AuxFunVal: Evaluation of the data set (required for some learning algorithms, not for this one)
% Card: Vector with the dimension of all the variables. 
% learning_params{1} = TypeLearning: Type of method used for learning the Bayesian network
%                         TypeLearning = {'tree','k2','k2t'}.  
%                         'tree':  MWST based tree algorithm. 'k2': K2  algorithm initialized from a random 
%                         ordering of the variables k2t:  K2  algorithm initialized from a tree dag ordering
% learning_params{2} = MaxParent: Maximum number of parents for the Bayesian Networks or
%                         maximum size of the conditioning set for PC. By default, MaxParent = n.
% learning_params{3} = verbose = {'yes','no'}. Whether to display the output of K2 learning algorithm while running 
% OUTPUTS
% bnet: Gaussian network learned from the selected population 
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       

TypeLearning = char(cellstr(learning_params{1}(1)));
MaxParent = cell2num(learning_params{1}(2));
%verbose = char(cellstr(learning_params{1}(3)));


scoring_fn = 'bic';

SelPop = AuxPop'+1;  % For the bnet learning procedure, variables are rows and observations columns
                     % Entries in the matrix should be non-zero

% All nodes are set to be gaussian
for i=1:NumbVar 
 nodetype{i} = 'gaussian';
end

 
switch lower(TypeLearning)
   case {'tree'}
    % MWST based tree algorithm
    root = fix(rand*NumbVar)+1;
    dag = full(learn_struct_mwst(SelPop,[],ones(NumbVar,1),nodetype,'bic',root));
   case {'k2'} 
   %K2 algorithm 
    root = fix(rand*NumbVar)+1;
    order = randperm(NumbVar);
    dag =  learn_struct_K2(SelPop,ones(1,NumbVar),order,'type',nodetype,'max_fan_in',MaxParent,'discrete',[],'scoring_fn',scoring_fn,'params',[]);   
   case {'k2t'} 
   %K2 algorithm initialized from a tree dag
    root = fix(rand*NumbVar)+1;
    dag = full(learn_struct_mwst(SelPop,[],ones(NumbVar,1),nodetype,'bic',root));
    order = topological_sort(dag);
    dag =  learn_struct_K2(SelPop,ones(NumbVar,1),order,'type',nodetype,'max_fan_in',MaxParent,'discrete',[],'scoring_fn',scoring_fn,'params',[]);   
   end,

%dag
bnet = mk_bnet(dag,ones(NumbVar,1),'discrete',[]);
% All nodes are set to be gaussian
for i=1:NumbVar 
 bnet.CPD{i} = gaussian_CPD(bnet,i);
end,
bnet = learn_params(bnet,SelPop);
%figure
%draw_graph(dag);
 
