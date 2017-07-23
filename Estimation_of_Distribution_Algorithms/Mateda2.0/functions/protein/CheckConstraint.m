function[Overlappings,Pos] =  CheckConstraint(Pos,pos,vector)
% [Overlappings,Pos] =  CheckConstraint(Pos,pos,vector)
% CheckConstraint: Given the configuration of residues, calculates the number of 
%                  Overlappings  that the  addition of move mov at position pos provokesn
% INPUT
%  Pos: Configuration of the sequence being repaired
%  pos: position in the sequence being inspected
%  vector: original sequence
% OUTPUT
% Collisions:   Number of non contiguous H residues that are neighbors in the lattice 
% Pos: Configuration of the sequence being repaired
% Ovelappings:  Number of residues that self-intersect in the lattice
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)    
global HPInitConf;


Overlappings = 0;
if(pos < 3)
 return;
end

 [Pos] = PutMoveAtPos(Pos,pos,vector(pos));
  
   for j=1:pos-2,   % Check for Overlappings and Collissions in all the    molecules except the previous one
    if(Pos(pos,1)==Pos(j,1) & Pos(pos,2)==Pos(j,2))
      Overlappings = Overlappings + 1;
    end
   end
  
