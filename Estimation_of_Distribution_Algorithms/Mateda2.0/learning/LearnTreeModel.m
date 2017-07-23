function [model] = LearnTreeModel(k,NumbVar,Card,SelPop,AuxFunVal,learning_params)
% [model] = LearnTreeModel(k,NumbVar,Card,SelPop,AuxFunVal,learning_params)
% LearnTreeModel: A maximum weighted tree is learned from the matrix of mutual information between the variables
% INPUTS
% k: Current generation
% NumbVar: Number of variables
% Card: Vector with the dimension of all the variables. 
% SelPop:  Population from which the model is learned 
% AuxFunVal: Evaluation of the data set (required for some learning algorithms, not for this one)
% learning_params{1}(1) = {}
% OUTPUTS
% model: Structure containing the tree structure (model{1} = Cliques)
%        and the parameters (model{2} = Tables)
%
% Last version 5/6/2009. Roberto Santana (roberto.santana@ehu.es)       
 
  N = size(SelPop,1);
  Cliques =  [];   

      % Univariate and Bivariate probabilities are learned   
        [UnivProb,BivProb]= FindMargProb(SelPop,NumbVar,Card);
       
       % The Matrix of Mutual information is learned
         MI = IntMutualInfFromMargProb(NumbVar,Card,UnivProb,BivProb);
         
       % The tree is extracted from the matrix of mutual information
         [Cliques] = CreateTreeStructure(MI);
       
      for i=1:NumbVar
        nparent = Cliques(i,1);        
        if  nparent== 0 % The variable has no parent
         Tables{i} = (UnivProb{i}*N + 1) ./ ( (N + Card(i))*ones(1,Card(i)));
        else 
         parent = Cliques(i,3);
         %[i,parent,Card(i),Card(parent)]         
         if parent<i
           a = BivProb{parent,i};
           %AuxBivProb = reshape(a',Card(parent),Card(i))
           AuxBivProb = reshape(a',Card(i),Card(parent))';
         else
           a = BivProb{i,parent};
           AuxBivProb = reshape(a',Card(parent),Card(i));
           
         end
            aux = repmat(UnivProb{parent}',1,Card(i));
            auxcard = repmat(Card(i),Card(parent),Card(i));
            CondBivProb =  (AuxBivProb*N +1) ./ (aux*N + auxcard);  % Laplace Estimator 
            Tables{i} = CondBivProb;
        end
        
       end
      
     model{1} = Cliques;
     model{2} = Tables;
     
     return;
     
     
         