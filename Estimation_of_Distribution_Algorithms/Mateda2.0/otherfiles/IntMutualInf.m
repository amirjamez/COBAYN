function[MI]=IntMutualInf(SelPop,NumbVar,N,Card)
% [MI]=IntMutualInf(SelPop,NumbVar,N,Card)
% IntMutualInf computes the normalized matrix of mutual information (MI)
% from a discrete data set. MI should be normalized because variables may have different
% cardinalities
% INPUTS: 
% SelPop: Selected population 
% NumbVar: Number of variables
% N: Size of the selected population
% Card: Cardinality of the variables. 
% OUTPUT:
% MI: Matrix of normalized mutual information
% 
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)  

for i=1:NumbVar-1,
 UnivProb{i} = zeros(1,Card(i));   %Initialization of univariate probabilities
 if (i==NumbVar-1)
    UnivProb{NumbVar} = zeros(1,Card(NumbVar));
 end,
 for j=i+1:NumbVar,
   BivProb{i,j} = zeros(1,Card(i)*Card(j));  %Initialization of bivariate probabilities for all pair of variables are computed
   for k=1:N,
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

MI = zeros(NumbVar);
for i=1:NumbVar-1,
 for j=i+1:NumbVar,
   for k=0:Card(i)-1,
      for l=0:Card(j)-1,
        if(BivProb{i,j}>0)
            MI(i,j) = MI(i,j) + BivProb{i,j}(Card(j)*k+l+1)* log(BivProb{i,j}(Card(j)*k+l+1)/(UnivProb{i}(k+1)*UnivProb{j}(l+1)));
        end
      end,
   end,
   MI(i,j) = MI(i,j)/(Card(i)*Card(j)); %Normalization of the mutual information 
   MI(j,i) = MI(i,j);
 end,
end, 
