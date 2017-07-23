function  MakePajekGraphFromDag(dag,pajekfilename)
% MakePajekGraphGraphFromDag(dag,pajekfilename)
% MakePajekGraphFromDag:  Creates a graph in .net format (to be read by
% Pajek program http://vlado.fmf.uni-lj.si/pub/networks/pajek/ ) of the Bayesian network with structure in dag
% Pajek allows sophisticated network analysis and visualization 
% INPUTS
% dag: Bayesian network structure 
% pajekfilename: Name of the pajek file containing the structure of the
% network
%
% Last version 3/9/2009. Roberto Santana (roberto.santana@ehu.es)        

n = size(dag,1);

Pos(:,1) = [0:1/n:1];
Pos(:,2) = 0.5;


fid = fopen(pajekfilename,'wt');
        fprintf(fid,'*Vertices %d \n', n); 
         for i=1:n,
          auxstr = ['"v',num2str(i),'"'];   
          auxstr1 = 'ellipse ic Black fos 20';
          fprintf(fid,'%d %s %d %d %s \n',i,auxstr,Pos(i,1),Pos(i,2),auxstr1);
         end,
     
     fprintf(fid,'*Arcs %d \n', sum(sum(dag))); 
      for i=1:n,
       for j=1:n,   
         if dag(i,j)==1
             fprintf(fid,'%d %d \n',i,j);
         end
       end
     end
      
  fclose(fid)
         
