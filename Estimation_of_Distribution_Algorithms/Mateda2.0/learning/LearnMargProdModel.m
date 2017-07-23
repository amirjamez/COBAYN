function [model] = LearnMargProdModel(k,NumbVar,Card,SelPop,AuxFunVal,learning_params)
% [model] = LearnMargProdModel(k,NumbVar,Card,SelPop,AuxFunVal,learning_params)
% LearnMargProdModel:     Learns a marginal product model using affinity
%                         propagation on the matrix of mutual information
% INPUTS
% k: Current generation
% NumbVar: Number of variables
% Card: Vector with the dimension of all the variables. 
% SelPop:  Population from which the model is learned 
% AuxFunVal: Evaluation of the data set (required for some learning algorithms, not for this one)
% learning_params{1}(1) = sizeconstraint: Maximum size of the cliques in
%                                         the factorization 
% OUTPUTS
% model: Markov network model containing the structure (model{1} = Cliques)
%        and the parameters (model{2} = Tables)
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       

        sizeconstraint =  cell2num(learning_params{1}(1)); 

        % Univariate and Bivariate probabilities are learned   
        [UnivProb,BivProb]= FindMargProb(SelPop,NumbVar,Card);
       
       % The Matrix of Mutual information is learned
         MI = IntMutualInfFromMargProb(NumbVar,Card,UnivProb,BivProb);

         %[idx,cent] = kmeans(MI,NumbVar/3,'Distance','correlation');
         
         
         % The cliques are learned from the matrix of mutual information
         auxperm = randperm(NumbVar);
         [Cliques,auxval]=FactAffinityElim(MI(auxperm,auxperm),auxperm,sizeconstraint,median(MI(auxperm)),1);
         %[Cliques,auxval]=FactAffinityElim(MI,[1:NumbVar],sizeconstraint,median(MI),1)
 
         % The parameters of the model are learned
         [Tables] = LearnFDAParameters(Cliques,SelPop,NumbVar,Card);
         
       
     model{1} = Cliques;
     model{2} = Tables;
     
     return;
       

       