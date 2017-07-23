function[Val] = ComputeDiversity(Pop) 
% [Val] = ComputeDiversity(Pop) 
% ComputeDiversity: Computes the average quadratic distance between each pair of vectors
%                   in  Pop.
% INPUTS
% Pop: Each row corresponds to a vector
% Val: Average square difference between pairs of vectors
%
% Last version 2/26/2009. Roberto Santana (roberto.santana@ehu.es)

 Val = 0;
 
 [PopSize,n] = size(Pop);
 npairs = PopSize*(PopSize-1)/2;
 for i=1:PopSize-1,
  for j=i+1:PopSize,
    Val = Val + sum((Pop(i,:)-Pop(j,:)).^2); 
  end
 end
 
 Val = Val/(npairs);