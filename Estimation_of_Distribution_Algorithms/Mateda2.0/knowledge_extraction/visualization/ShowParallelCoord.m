function[] = ShowParallelCoord(fs,AllRepVectors)
% [] = ShowParallelCoord(fs,AllRepVectors)
% ShowParallelCoord :    Shows the parallel coordinates graph of the vectors 
% INPUT
% fs: Font size for the images                       
% AllRepVectors: Vectors, each row  is an observation, each column
% corresponds to a variable. 
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       


 figure     % Parallel coordinates
 axes('Fontsize',fs);
 parallelcoords(AllRepVectors);