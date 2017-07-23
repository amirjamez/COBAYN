function[Pos] =  MakePajekGraphOfProtein(vector,pajekfilename)
% [Pos] =  MakePajekGraphOfProtein(vector)
% MakePajekGraphOfProtein:  Creates a graph in Pajek format corresponding to the configuration encoded by vector
% INPUTS
% vector: Sequence of residues ( (H)ydrophobic or (P)olar, respectively represented by zero and one)
% OUTPUTS
% Pos:    Position of the residues
%
% Last version 3/9/2009. Roberto Santana (roberto.santana@ehu.es)        


global HPInitConf;

[Collisions,Overlappings,Pos] =  EvalChain(vector);

sizeChain = size(HPInitConf,2);

Pos(:,1) = abs(min(Pos(:,1))) + Pos(:,1);
Pos(:,2) = abs(min(Pos(:,2))) + Pos(:,2);

Pos(:,1) = (Pos(:,1) / max(Pos(:,1)))*0.85 + 1/sizeChain;
Pos(:,2) = (Pos(:,2) / max(Pos(:,2)))*0.85 + 1/sizeChain;

fid = fopen(pajekfilename,'wt');
        fprintf(fid,'*Vertices %d \n', sizeChain); 
         for i=1:sizeChain,        
          auxstr = ['"v',num2str(i),'"'];   
          if(HPInitConf(i) == 0)
           auxstr1 = 'box ic Red fos 30';
          else    
           auxstr1 = 'ellipse ic Black fos 30';
          end
          fprintf(fid,'%d %s %d %d %s \n',i,auxstr,Pos(i,1),Pos(i,2),auxstr1);
         end,
     
     fprintf(fid,'*Edges %d \n', sizeChain-1); 
      for i=2:sizeChain,        
          fprintf(fid,'%d %d \n',i-1,i);
      end
      
  fclose(fid)
         
