function[bnet] =  LearnBNwithObjectives(k,NumbVar,Card,AuxPop,AuxFunVal,learning_params)
% [bnet] =  LearnBNwithObjectives(k,NumbVar,Card,AuxPop,AuxFunVal,learning_params)
% LearnBNwithObjectives:     Learns the Bayesian network from the given population using
%             Bayesian network learning algorithms of the BNtools and
%             libraries (see references in the documentation)
%             See also BNT structure learning  package for explanation (http://bnt.insa-rouen.fr/ajouts.html)
% INPUTS
% k: Current generation
% NumbVar: Number of variables
% AuxPop: Selected population (data set for learning the BN)
% AuxFunVal: Evaluation of the data set (required for some learning algorithms, not for this one)
% Card: Vector with the dimension of all the variables. 
% learning_params{1} = TypeLearning: Type of method used for learning the Bayesian network
%                         TypeLearning = {'pc','tree','k2','k2t'}.  pc:  PC algorithm.
%                         'tree':  MWST based tree algorithm. 'k2': K2  algorithm initialized from a random 
%                         ordering of the variables k2t:  K2  algorithm initialized from a tree dag ordering
% learning_params{2} = MaxParent: Maximum number of parents for the Bayesian Networks or
%                         maximum size of the conditioning set for PC. By default, MaxParent = n.
% learning_params{3} = epsilon: alpha is the significance level (default: 0.05) for the
%                                  probabilistic independence tests in PC  algorithm
% learning_params{4} = type_indeptest: Type of independence test used by
%                         PC.   type_indeptest = {'pearson', 'LRT'} for  Pearson's chi2 test (default) 
%                         and G2 likelihood ratio test 
% learning_params{5} = scoring_fn:  Type of scoring function used by K2 structure learning algorithms.
%                         scoring_fn = {'bic','bayesian'}. Default (bic)
% learning_params{6} = verbose = {'yes','no'}. Whether to display the output of K2 learning algorithm while running 
% OUTPUTS
% bnet: Bayesian network learned from the selected population 
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       

TypeLearning = char(cellstr(learning_params{1}(1)));
MaxParent = cell2num(learning_params{1}(2));
alpha = cell2num(learning_params{1}(3));
type_indeptest = char(cellstr(learning_params{1}(4))); 
scoring_fn = char(cellstr(learning_params{1}(5)));
verbose = char(cellstr(learning_params{1}(6)));

 
SelPop = AuxPop'+1;  % For the bnet learning procedure, variables are rows and observations columns
                     % Entries in the matrix should be non-zero

% All nodes are set to be discrete
for i=1:NumbVar 
 nodetype{1,i} = 'tabular';
end

 
switch lower(TypeLearning)
  case {'pc'}
    % PC algorithm
    pdag = learn_struct_pdag_pc('cond_indep_chisquare',NumbVar,MaxParent,SelPop,'pearson',alpha,Card);
    dag = cpdag_to_dag(pdag);
  case {'tree'}
    % MWST based tree algorithm
    root = fix(rand*NumbVar)+1;
    dag = full(learn_struct_mwst(SelPop,[],ones(1,NumbVar),nodetype,'mutual_info',root));
   case {'k2'} 
   %K2 algorithm 
    root = fix(rand*NumbVar)+1;
    order = randperm(NumbVar);
    dag =  learn_struct_K2(SelPop,Card,order,'max_fan_in',MaxParent,'scoring_fn',scoring_fn);   
   case {'k2t'} 
   %K2 algorithm initialized from a tree dag
    root = fix(rand*NumbVar)+1;
    dag = full(learn_struct_mwst(SelPop,[],ones(1,NumbVar),nodetype,'mutual_info',root));
    order = topological_sort(dag);
    dag =  learn_struct_K2(SelPop,Card,order,'max_fan_in',MaxParent,'scoring_fn',scoring_fn);   
   end,


init_bnet = mk_bnet(dag,Card);
% All nodes are set to be discrete
for i=1:NumbVar 
 init_bnet.CPD{i} = tabular_CPD(init_bnet,i);
end,

bnet = learn_params(init_bnet,SelPop);
%figure
%draw_graph(dag);

 
