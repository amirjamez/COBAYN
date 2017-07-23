function [num] = IndexconvertCard(valindex,length,AccCard)
% [num] = IndexconvertCard(valindex,length,AccCard)
% IndexconvertCard: Converts the index valindex to the vector of variables num, 
% INPUT:
% valindex: index of the vector in an ordering of all possible vectors
% length: length of the vector
% AccCard: The product of cardinalities of previous  variables, 
%          where the first variable is  the first one to the left.
% OUTPUT: 
% num: vector of values
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       


aux = valindex;
 for i=1:length
   remainder = rem(aux, AccCard(i));
   num(i)= (aux - remainder) / AccCard(i);
   aux = remainder;
 end
