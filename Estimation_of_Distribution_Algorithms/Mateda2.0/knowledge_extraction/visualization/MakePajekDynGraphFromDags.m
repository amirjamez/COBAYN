function  MakePajekDynGraphFromDags(listdags,pajekfilename)
% MakePajekDynGraphFromDags(listdags,pajekfilename)
% MakePajekDynGraphFromDags:  Creates a dynamic graph in .tin format (to be read by
% Pajek program http://vlado.fmf.uni-lj.si/pub/networks/pajek/ ) of the Bayesian networks 
% structure learned at each step of an EDA that learns Bayesian networks
% Pajek allows sophisticated network analysis and visualization 
% INPUTS
% listdag: List of Bayesian network structures. listdags{i} is the dag
% learned at generation i
% pajekfilename: Name of the pajek file containing the structure of the
% network
%
%
% EXAMPLE
 %for i=1:size(Cache,2),
  %listdags{i} = Cache{3,i}
 %end
% MakePajekDynGraphFromDags(listdags,'EDAstructures.tin')
%
% Last version 3/9/2009. Roberto Santana (roberto.santana@ehu.es)        


ndags = size(listdags,2);
n = size(listdags{1}.dag,1);

Pos(:,1) = [0:1/n:1];
Pos(:,2) = 0.5;



fid = fopen(pajekfilename,'wt');
        fprintf(fid,'*Vertices %d \n', n); 
        fprintf(fid,'*Events \n');
     
        fprintf(fid,'TI = 1 \n');
        for i=1:n,
          auxstr = ['"v',num2str(i),'"'];   
          auxstr1 = 'ellipse ic Black fos 20';
          fprintf(fid,'AV %d %s %d %d %s \n',i,auxstr,Pos(i,1),Pos(i,2),auxstr1);
        end,
         
   for t=1:ndags
    if(t>1)
      for i=1:n,
       for j=1:n,   
         if listdags{t-1}.dag(i,j)==1
             fprintf(fid,'DA %d %d \n',i,j);
         end
       end
      end
    end
      for i=1:n,
       for j=1:n,   
         if listdags{t}.dag(i,j)==1
             fprintf(fid,'AA %d %d \n',i,j);
             fprintf(fid,'SA %d %d \n',i,j);
         end
       end
      end
      fprintf(fid,'TE %d \n',t);
      if t<ndags
        fprintf(fid,'TI %d \n',t+1);
      end
   end     
      
  fclose(fid)
         
