function[energy] =  EvaluateEnergyFunctional(vector)
% [energy] =  EvaluateEnergyFunctional(vector)
% EvaluateEnergyFunctional:    Evaluates  the energy corresponding to the sequence lattice configuration determined by the lattice in vector.
% From the residues positions, the interaction energies are calculated by the functional energy function  (Hirst:1999)  
% INPUTS
% vector: Sequence of residues ( (H)ydrophobic or (P)olar, respectively represented by zero and one)
% OUTPUTS
% energy: Energy evaluation.
%
% Last version 4/15/2009. Roberto Santana (roberto.santana@ehu.es) 


global HPInitConf;


[Collisions,Overlappings,Pos] =  EvalChainFunctional(vector);
 

if Collisions<0
 energy = Collisions*(Overlappings+1);
else
 energy = Collisions/(Overlappings+1);
end

