function[Val] = ComputeDistanceToPoint(Pop,point) 
% [Val] = ComputeDistanceToPoint(Pop,point) 
% ComputeDistanceToPoint: Computes the average quadratic distance between vectors
%                         in  Pop and a given point.
% INPUTS
% Pop: Each row corresponds to a vector
% point: Vector taken as a reference
% OUTPUT
% Val: Average square difference between vectors and point
%
% Last version 2/26/2009. Roberto Santana (roberto.santana@ehu.es)

 Val = 0;
 
 [PopSize,n] = size(Pop);

 for i=1:PopSize,
    Val = Val + sum((Pop(i,:)-point).^2); 
 end
 
 Val = Val/PopSize;