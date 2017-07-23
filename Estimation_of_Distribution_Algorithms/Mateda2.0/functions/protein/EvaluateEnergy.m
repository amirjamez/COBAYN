function[energy] =  EvaluateEnergy(vector)
% EvaluateEnergy:    Evaluates  the energy corresponding to the sequence lattice configuration determined by the lattice in vector.
% From the residues positions, the interaction energies are calculated by the energy function    
% For reference on the  HP model see:
%--- R. Santana, P. Larra�aga, and J. A. Lozano (2004) Protein folding in 2-dimensional lattices with estimation of distribution algorithms. 
%--- In Proceedings of the First International Symposium on Biological and Medical Data Analysis, 
%--- Volume 3337 of Lecture Notes in Computer Science, pages 388-398, Barcelona, Spain, 2004. Springer Verlag. 
% INPUTS
% vector: Sequence of residues ( (H)ydrophobic or (P)olar, respectively represented by zero and one)
% OUTPUTS
% energy: Energy evaluation.
%
% Last version 4/15/2009. Roberto Santana (roberto.santana@ehu.es)     


global HPInitConf;


[Collisions,Overlappings,Pos] =  EvalChain(vector);
 

if Collisions<0
 energy = Collisions*(Overlappings+1);
else
 energy = Collisions/(Overlappings+1);
end



