function[UnivProb,BivProb]=FindMargProb(SelPop,NumbVar,Card)
% [UnivProb,BivProb]=FindMargProb(SelPop,NumbVar,Card)
% FindMargProb:      Computes the univariate and bivariate marginal probabilities
% INPUT:
% SelPop: Selected population 
% NumbVar: Number of variables
% Card: Vector with the dimension of all the variables. 
% OUTPUT:
% UnivProb:  Univariate probabilities
% BivProb:  Bivariate probabilities
% Last version 8/26/2008. Roberto Santana and Siddarta Shakya (roberto.santana@ehu.es)    

SelPopSize = size(SelPop,1);
for i=1:NumbVar-1,
 UnivProb{i} = zeros(1,Card(i));   %Initialization of univariate probabilities
 if (i==NumbVar-1)
    UnivProb{NumbVar} = zeros(1,Card(NumbVar));
 end,
 for j=i+1:NumbVar,
   BivProb{i,j} = zeros(1,Card(i)*Card(j));  %Initialization of bivariate probabilities for all pair of variables are computed
   for k=1:SelPopSize,
     if(j==i+1)
        UnivProb{i}(SelPop(k,i)+1) = UnivProb{i}(SelPop(k,i)+1) + 1;
        if(i==NumbVar-1)
          UnivProb{NumbVar}(SelPop(k,NumbVar)+1) = UnivProb{NumbVar}(SelPop(k,NumbVar)+1) + 1;
        end
     end
     BivProb{i,j}(Card(j)*SelPop(k,i) + SelPop(k,j)+1) = BivProb{i,j}(Card(j)*SelPop(k,i) + SelPop(k,j)+1) +1;
   end,
  BivProb{i,j} = BivProb{i,j}/sum(BivProb{i,j}); % Normalization of the probabilities
 end
 UnivProb{i} = UnivProb{i}/sum(UnivProb{i});
end 
UnivProb{NumbVar} = UnivProb{NumbVar}/sum(UnivProb{NumbVar});


