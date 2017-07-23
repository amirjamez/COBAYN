function[solutionFound,s,Pos] =   HP_newrepairing(sizeChain,Pos,pos,moves,s,vector)
% HP_newrepairing:        An auxiliary function that modifies a sequence configuration to avoid self-intersections
%                   It is called recursively
% INPUTS
%  sizeChain: Size of the subchain inspected
%  Pos: Configuration of the sequence being repaired
%  pos: position in the sequence being inspected
%  moves: set of allowed moves in random order
%  s:  Sequence of residues repaire
%  vector: original sequence
% OUTPUTS
%  solutionFound: whether the solution was repaired
%  s:  Sequence of residues repaired (without self-intersections) 
%  Pos: Final configuration of the sequence 
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       

global HPInitConf;


 if (NewFeasible(s,pos-1,Pos)==1 )  
    if (size(s,2) == sizeChain)
     solutionFound = 1;
    else
     solutionFound = 0;
     i = 1;
     while (solutionFound==0  & i<=4)
      if(i==1 || moves(pos,i) ~= vector(pos))      
       new_s = [s,moves(pos,i)];
       [Pos] = PutMoveAtPos(Pos,pos,moves(pos,i));
       [solutionFound,new_s,Pos] = HP_newrepairing(sizeChain,Pos,pos+1,moves,new_s,vector);
      end
      i = i + 1;
      if (solutionFound==1)
         s = new_s;
      end
     end
   end
  else
     solutionFound = 0;
  end


% Last version 10/09/2005. Roberto Santana (rsantana@si.ehu.es) 