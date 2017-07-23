function[] = ShowImage(pcolors,fs,matrix)
% [] = ShowImage(pcolors,fs,matrix)
% ShowImage: Shows the image contained in an incident matrix associating colors proportional to the
%            cell values 
%
% INPUT
%
% [pcolors,fs]; % pcolors: range of colors for the  images. fs: Font size for the images                       
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)

 max_edges = max(max(matrix)); % Maximum number of values in the matrix
 figure     
 axes('Fontsize',fs);
 if max_edges>0
  image(pcolors*matrix/max_edges);
 else
 image(pcolors*matrix);
 end
 axis xy
 G = xlabel('Variable I');
 H = ylabel('Variable J');
 set(G,'Fontsize',fs);
 set(H,'Fontsize',fs);
