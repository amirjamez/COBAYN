function[ListCliqAccCard] = FindListCliqAccCard(totcliq,ListCliques,Card)
% [ListCliqAccCard] = FindListCliqAccCard(totcliq,ListCliques,Card)
% FindListCliqAccCard calculates de accumulative cardinalities for all the cliques, and the dimension of the probability tables
%                     All the information is saved ListCliqAccCard
% INPUTS:
% totcliq: Number of Cliques
% ListCliques: Structure containing each of the cliques
% Card: Cardinality of the variables
% 
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)  
 ListCliqAccCard = zeros(size(ListCliques));
     for i=1:totcliq,
         sizecliq = ListCliques(i,1);
         cliq = ListCliques(i,3:sizecliq+2);
         AccCard = FindAccCard(sizecliq,Card(cliq));
         ListCliqAccCard(i,1) =  NumconvertCard(Card(cliq)-1,sizecliq,AccCard)+1; % Size of the table for cliq1
	 ListCliqAccCard(i,2:sizecliq+1) =  AccCard;
     end
