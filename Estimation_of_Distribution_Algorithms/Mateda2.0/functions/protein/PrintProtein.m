function[Pos] =  PrintProtein(vector)
% [Pos] =  PrintProtein(vector)
% PrintProtein:  Prints the configuration encoded by vector
% INPUTS
% vector: Sequence of residues ( (H)ydrophobic or (P)olar, respectively represented by zero and one)
% OUTPUTS
% Pos:    Position of the residues
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)        


global HPInitConf;

[Collisions,Overlappings,Pos] =  EvalChain(vector);

sizeChain = size(HPInitConf,2);

figure
hold on
for i=1:sizeChain
 if(HPInitConf(i) == 0)
   plot(Pos(i,1),Pos(i,2),'*');
 else
   plot(Pos(i,1),Pos(i,2),'o');
 end  
end
 plot(Pos(:,1),Pos(:,2),'b-');

