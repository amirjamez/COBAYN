function [valindex] = NumconvertCard(num,length,AccCard)
% [valindex] = NumconvertCard(num,length,AccCard)
% NumconverCard:  Converts a vector of variables num, where the accumulative cardinality of each variable
%                 is in AccCard, to the index valindex corresponding to the vector.
% INPUT:
% num: vector of values
% length: length of the vector
% AccCard: The product of cardinalities of previous  variables, 
%          where the first variable is  the first one to the left.
% OUTPUT: 
% valindex: index of the vector in an ordering of all possible vectors
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       

   valindex = num(length);
     for i=1:length-1,
      valindex =  valindex +  num(i)*AccCard(i);
     end
