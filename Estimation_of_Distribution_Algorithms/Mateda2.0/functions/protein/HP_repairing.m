function[NewPop] =  HP_repairing(Pop,Card,repairing_params)
% [NewPop] =  HP_repairing(Pop,Card,repairing_params)
% HP_repairing:   Modifies a sequence configuration to avoid self-intersections
% INPUTS
% Pop: Population in which each vector corresponds to a relative position of a residue 
%      in a grid 
% Card: Cardinality of the variables
% repairing_params: Repairing params are not used
% OUTPUTS
% s:  Sequence of residues repaired (without self-intersections) 
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       
global HPInitConf;

PopSize = size(Pop,1);
sizeChain = size(Pop,2);

for j=1:PopSize
 Pos = zeros(sizeChain,2);

 Pos(1,1) = 0;  %Position for the initial molecule 
 Pos(1,2) = 0;
  
 Pos(2,1) = 1;  %Position for the second molecule 
 Pos(2,2) = 0;

  for i=1:sizeChain
   moves(i,:) = randperm(3)-1;
  end
  moves = [Pop(j,:)',moves];
  s = [];

  [SolutionFound,NewPop(j,:)] = HP_newrepairing(sizeChain,Pos,1,moves,s,Pop(j,:));
  %NewPop(j,[1,2]) = [0,0];
  clear moves;
end
