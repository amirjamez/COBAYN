function [Tables] = LearnMOAProb(Cliques,SelPop,NumbVar,N,Card)
% [Tables] = LearnMOAProb(Cliques,SelPop,NumbVar,N,Card)
% LearnMOAProb:   Learn the marginal tables for each clique (the variable and its neighborhood)     
%
% INPUT
% Cliques:    Structure of the model in a list of cliques that defines the  neighborhood of the variable
%             Each row of Cliques is a clique. The first value is the number of overlapping variables (neighbors of 
%             variable i)
%             The second, is the number of new variables (Variable i, but it could be extended to blocks of variables).
%             Then, neighbor  variables are listed and  finally variable i is listed.
% SelPop:     Selected population 
% NumbVar:    Number of variables
% N:          Size of the new population
% Card:       Vector with the dimension of all the variables. 
%
% OUTPUT
% Tables:     Probability tables for each clique
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       
 



NewPop=0;
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

