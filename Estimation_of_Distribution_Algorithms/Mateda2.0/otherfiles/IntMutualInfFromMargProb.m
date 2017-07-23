function[MI]=IntMutualInfFromMargProb(NumbVar,Card,UnivProb,BivProb)
% [MI]=IntMutualInfFromMargProb(NumbVar,Card,UnivProb,BivProb)
% IntMutualInfFromMargProb:   This functions computes the normalized matrix of mutual information (MI)
%                             from the sets of univariate and bivariate marginal probabilities
% INPUTS:
% NumbVar: Number of variables
% Card: Vector with the dimension of all the variables. 
% UnivProb: Univariate probabilities
% BivProb: Bivariate probalities
% OUTPUTS: 
% MI: Matrix of mutual information 
% 
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)  

MI = zeros(NumbVar);
for i=1:NumbVar-1,
 for j=i+1:NumbVar,
   for k=0:Card(i)-1,
      for l=0:Card(j)-1,
        if(BivProb{i,j}(Card(j)*k+l+1)>0)
            MI(i,j) = MI(i,j) + BivProb{i,j}(Card(j)*k+l+1)* log(BivProb{i,j}(Card(j)*k+l+1)/(UnivProb{i}(k+1)*UnivProb{j}(l+1)));
        end
      end,
   end,
   MI(i,j) = MI(i,j)/(Card(i)*Card(j)); %Normalization of the mutual information 
   MI(j,i) = MI(i,j);
 end,
end, 
