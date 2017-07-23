function [Cliques] = CreateTreeStructure(MI)
% [Cliques] = CreateTreeStructure(MI)
% CreateTreeStructure: A maximum weighted tree is learned from the matrix of mutual information between the variables
% INPUTS
% MI: Matrix of mutual information
% OUTPUTS
%    Cliques: Structure of the model in a list of cliques that defines the neighborhood 
%    Each row of Cliques is a clique. The first value is the number of parents for variable i (1 in the case of a tree). 
%    The second, is the number of new variables (one new variable, i).
%    Then, parent variables are listed and  finally new variables (variable i) are listed
%
% Last version 5/6/2009. Roberto Santana (roberto.santana@ehu.es)       
 
threshold = 10^-4;

NumbVar = size(MI,1);
Cliques = zeros(NumbVar,4);
shuffle = randperm(NumbVar); % This is used to  avoid bias when the mutual information  is the same for many couple of variables

Cliques(:,2) =  1;  % In every clique only a new variable is added;
Tree = [1:NumbVar]; % Index of the parent for every variable


%root = shuffle(fix(rand*NumbVar)+1);  % The root of the tree is randomly selected

[a,b] = find(MI==max(max(MI)));
root = a(1); % The root corresponds to the link with highest mutual information

Cliques(root,:) = [0,1,root,-1]; % The root has zero parents    
Tree(root) = -1; 

                        
	for i=1:NumbVar-1  
		maxval=-10;
		for j=1:NumbVar
		 for k=1:NumbVar
		     auxm = MI(shuffle(j),shuffle(k));
             if(Tree(shuffle(j))==shuffle(j) && Tree(shuffle(k))~=shuffle(k) && auxm>maxval)
					  maxsonindex = shuffle(j);
					  maxfatherindex = shuffle(k);
					  maxval=auxm;
             end
         end
        end 
        if (maxval > threshold)
         Tree(maxsonindex)=maxfatherindex;
         Cliques(maxsonindex,:) = [1,1,maxfatherindex,maxsonindex];
         Weight(maxsonindex) = maxval;
        else
          Tree(maxsonindex) = -1;
          Cliques(maxsonindex,:) = [0,1,maxsonindex,-1];
          Weight(maxsonindex) = 0;
        end 
    end
     
  return;
     