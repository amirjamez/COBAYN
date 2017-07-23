function [model] = LearnMOAModel(k,NumbVar,Card,SelPop,AuxFunVal,learning_params)
% [model] = LearnMOAModel(k,NumbVar,Card,SelPop,AuxFunVal,learning_params)
% LearnMOAModel: The Markov network model learned by the Markov Optimization Algorithm (MOA) is learned
%                The structure of the model can be given (see explanation of paramater Cliques below) or learned from
%                the data. 
% INPUTS
% k: Current generation
% NumbVar: Number of variables
% Card: Vector with the dimension of all the variables. 
% SelPop:  Population from which the model is learned 
% AuxFunVal: Evaluation of the data set (required for some learning algorithms, not for this one)
% learning_params{1}(1) = 
%    Cliques: Structure of the model in a list of cliques that defines the neighborhood 
%    Each row of Cliques is a clique. The first value is the number of neighbors for variable i. 
%    The second, is the number of new variables (one new variable, i).
%    Then, neighbor variables are listed and  finally new variables (variable i) are listed
%    When Cliques is empty, the model is learned from the data
% learning_params{1}(2) = Nneighbors: Constraint on the maximum number of
%                         neighbors (similar to the maximum number of parents in a Bayesian network)
% learning_params{1}(3) = threshold 
%                         threshold for determining the neighbors from the
%                         matrix of the mutual information.
% learning_params{1}(4) = TypeAnnealing \in {'none','Boltzman_linear','fixed'}
%                         Type of annealing method used to modify the way
%                         the parameters of the model are computed
% learning_params{1}(5) = Temp: Temperature parameter for fixed temperature
% OUTPUTS
% model: Markov network model containing the structure (model{1} = Cliques)
%        and the parameters (model{2} = Tables)
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       
 


auxcell = learning_params{1}(1);
if isemptycell(auxcell)
  Cliques =  [];   
else
  Cliques = cell2num(learning_params{1}(1));
end

Nneighbors = cell2num(learning_params{1}(2)); 
threshold = cell2num(learning_params{1}(3)); 
TypeAnnealing = char(cellstr(learning_params{1}(4))); 
Temp = cell2num(learning_params{1}(5)); 

   if isempty(Cliques)      
      % Univariate and Bivariate probabilities are learned   
        [UnivProb,BivProb]= FindMargProb(SelPop,NumbVar,Card);
       
       % The Matrix of Mutual information is learned
         MI = IntMutualInfFromMargProb(NumbVar,Card,UnivProb,BivProb);
        
       % MIthreshold determines a threshold to consider variables "connected" in the Markov Network
         MIthreshold = threshold*(sum(sum(MI))/(NumbVar*(NumbVar-1))); % Average of the mutual information
        
       % The neighborhood structure is learned from the matrix of mutual information                      
         [Cliques] = FindNeighborhood(MI,Nneighbors,MIthreshold);
   end    
         % The conditional probability tables of each variable i given each
         % neighborhood are learned.
         
         [Tables]=LearnFDAParameters(Cliques,SelPop,NumbVar,Card);
           
         if ~strcmp(TypeAnnealing,'none')        
          if strcmp(TypeAnnealing,'Boltzman_linear')   % Boltzman probability with linear schedule
            Temp = 1/(0.5*k); 
          end
            for i=1:size(Tables,2)
             Tables{i} = exp(Tables{i}/Temp)./repmat(sum((exp(Tables{i}/Temp)'))',1,2);
            end
         end
        
     model{1} = Cliques;
     model{2} = Tables;
     
     return;
     
     
         