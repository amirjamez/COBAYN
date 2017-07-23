function[Collisions,Overlappings,Pos] =  EvalChain(vector)
% [Collisions,Overlappings,Pos] =  EvalChain(vector)
% EvalChain: Given a chain of molecules in the HP model, calculates the numer of Collisions with 
% neighboring same sign molecules, and the number of Overlappings molecules.
% For reference on the  HP model see:
%--- R. Santana, P. Larra�aga, and J. A. Lozano (2004) Protein folding in 2-dimensional lattices with estimation of distribution algorithms. 
%--- In Proceedings of the First International Symposium on Biological and Medical Data Analysis, 
%--- Volume 3337 of Lecture Notes in Computer Science, pages 388-398, Barcelona, Spain, 2004. Springer Verlag. 
% INPUTS
% vector: Sequence of residues ( (H)ydrophobic or (P)olar, respectively represented by zero and one)
% OUTPUTS
% Collisions:   Number of non contiguous H residues that are neighbors in the lattice 
% Ovelappings:  Number of residues that self-intersect in the lattice
% Pos:    Position of the residues
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       


global HPInitConf;


sizeChain = size(vector,2);

Collisions = 0;
Overlappings = 0;


Pos = zeros(sizeChain,2);

Pos(1,1) = 0;  %Position for the initial molecule 
Pos(1,2) = 0;
 
Pos(2,1) = 1;  %Position for the second molecule 
Pos(2,2) = 0;

 for i=3:sizeChain

 [Pos] = PutMoveAtPos(Pos,i,vector(i));
  
   for j=1:i-2,   % Check for Overlappings and Collissions in all the    molecules except the previous one
    if(Pos(i,1)==Pos(j,1) & Pos(i,2)==Pos(j,2))
      Overlappings = Overlappings + 1;
    elseif (HPInitConf(i)==0  & HPInitConf(j)==0)   
     if (Pos(i,1)==Pos(j,1) & Pos(i,2)==Pos(j,2)-1)
        Collisions =   Collisions + 1;
     end
     if (Pos(i,1)==Pos(j,1)+1 & Pos(i,2)==Pos(j,2))
        Collisions =   Collisions + 1;
     end
     if (Pos(i,1)==Pos(j,1) & Pos(i,2)==Pos(j,2)+1)
        Collisions =   Collisions + 1;
     end
     if (Pos(i,1)==Pos(j,1)-1 & Pos(i,2)==Pos(j,2))
        Collisions =   Collisions + 1;
     end
    end
  end
 end
   




 

