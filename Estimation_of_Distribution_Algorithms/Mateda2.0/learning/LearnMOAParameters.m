function[Tables] = LearnMOAParameters(Cliques,SelPop,NumbVar,Card)
% [Tables] = LearnMOAParameters(Cliques,SelPop,NumbVar,Card)
% LearnMOAModel: The parameters of the Markov network model of the Markov Optimization Algorithm (MOA) 
%                are learned from data
% INPUTS
%    Cliques: Structure of the model in a list of cliques that defines the  
%    Each row of Cliques is a clique. The first value is the number of neighbor for variable i. 
%    The second, is the number of new variables (one new variable, i).
%    Then, neighbor variables are listed and  finally new variables (variable i) are listed
% NumbVar: Number of variables
% Card: Vector with the dimension of all the variables. 
% SelPop:  Population from which the model is learned         
% OUTPUTS
% Tables: Probability tables for each variable conditioned on its neighbors
%
% Last version 8/26/2008. Roberto Santana and Siddarta Shakya (roberto.santana@ehu.es)    


NumberCliques = size(Cliques,1);


%%%%%%%%%%%%%%%%%%%%%%  First step  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The tables of all the cliques are filled  


for i=1:size(Cliques,1)

  sizeCliqOther = Cliques(i,2);
  sizeCliqSolap = Cliques(i,1);

  CliqOther = Cliques(i,Cliques(i,1)+3:Cliques(i,1)+Cliques(i,2)+2);
  AccCardOther = FindAccCard(sizeCliqOther,Card(CliqOther));
  dimOther =   NumconvertCard(Card(CliqOther)-1,sizeCliqOther,AccCardOther)+1;

  if(sizeCliqSolap > 0)
    CliqSolap = Cliques(i,3:(Cliques(i,1)+2));
    AccCardSolap = FindAccCard(sizeCliqSolap,Card(CliqSolap));
    dimSolap =   NumconvertCard(Card(CliqSolap)-1,sizeCliqSolap,AccCardSolap)+1;
    aux=zeros(dimSolap,dimOther);
  else 
    AccCardSolap = [];
    CliqSolap = [];
    aux=zeros(1,dimOther);
    dimSolap = 1;
  end
   
  AllVars = [CliqSolap,CliqOther];

 
 for j=1:dimSolap
    if (sizeCliqSolap>0) 
      solapval = IndexconvertCard(j-1,sizeCliqSolap,AccCardSolap);
    else
      solapval=[];
    end

    for k=1:dimOther
     auxSelPop=SelPop(:,[CliqSolap,CliqOther]);
     otherval =  IndexconvertCard(k-1,sizeCliqOther,AccCardOther);
     allvarvalues = [solapval,otherval];
    
     if(size(allvarvalues,2)==1)
       aux(j,k) =  sum((auxSelPop==repmat(allvarvalues,size(SelPop,1),1))');
     else 
       aux(j,k)=sum( sum((auxSelPop==repmat(allvarvalues,size(SelPop,1),1))') == size(allvarvalues,2)); 
     end
    end 
   % aux(j,:) = (aux(j,:))/(sum(aux(j,:)));
    aux(j,:) = (aux(j,:)+1)/(sum(aux(j,:))+dimOther); % Laplace Estimator
  end
 %aux=aux/sum(sum(aux)); % Normalization
 
 
 % En Table i se guardan las probabilidades del clique i

 eval(['Tables{',num2str(i),'}=aux;']);
         
end

