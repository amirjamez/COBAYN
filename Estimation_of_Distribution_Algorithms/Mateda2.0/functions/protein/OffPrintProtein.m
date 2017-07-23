function[] =  OffPrintProtein(vector)
% [] =  OffPrintProtein(vector)
% OffPrintProtein: Prints the configuration encoded by vector
% Fixing the lengths of the edges, each angle defines the position of the next residue respective the two previous ones.    
% For reference on the Offline HP model see:
%-- H. P. Hsu, V. Mehra and  P. Grassberger (2003)  Structure optimization in an off-lattice protein model.
%-- Phys Rev E Stat Nonlin Soft Matter Phys. 2003 Sep;68(3 Pt 2):037703. Epub 2003 Sep 30. 
%-- http://scitation.aip.org/getabs/servlet/GetabsServlet?prog=normal&id=PLEEE8000068000003037703000001&idtype=cvips&gifs=yes   
% INPUTS
% vector: Sequence of residues (Angles (continuous values) defining the position of the next residue respective the two previous  )
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       



% InitConf has been initialized with a Fibbonacci sequence by the RunOffLineProtein.m routine 
global HPInitConf;


% OffFindPos translates the vector of angles to the  positions into the lattice.
[Pos] =  OffFindPos(vector);

sizeChain = size(HPInitConf,2)

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

