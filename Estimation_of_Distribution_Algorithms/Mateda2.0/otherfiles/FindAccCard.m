function [AccCard] = FindAccCard(length,Card)
% [AccCard] = FindAccCard(length,Card)
%
% FindAccCard:  Finds the accumulative cardinality of a set of variables
% whose cardinality is in Card.
% INPUT:
% length: length of the vector
% Card: Cardinality of the variables
% OUTPUT: 
% AccCard: The product of cardinalities of previous  variables, 
%          where the first variable is  the first one to the left.
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       


 AccCard(length) = 1;

for i=length-1:-1:1
    AccCard(i)=AccCard(i+1)*Card(i+1);
 end
