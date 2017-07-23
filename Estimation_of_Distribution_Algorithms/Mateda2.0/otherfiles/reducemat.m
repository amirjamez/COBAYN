function[NewMat] =  reducemat(Mat,siz)
% [NewMat] =  reducemat(Mat,siz)
% reducemat extracts the set of rows of a given matrix that satisfy that
% each pair of rows are different in at least siz elements. When siz is
% equal to the number of columns, reducemat gives the unique rows in the
% original matrix
% INPUTS: 
% Mat: Original matrix
% OUTPUTS: 
% Mat: Reduced matrix
% 
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)  
sizeNewMat = 1;
NewMat = Mat(1,:);


for i=2:size(Mat,1)
 j = sizeNewMat; 
 while( j>=1 & (sum(Mat(i,1:siz) == NewMat(j,1:siz)) <siz))
  j = j-1;
 end

 if(j==0) 
   sizeNewMat = sizeNewMat + 1;
   NewMat = [NewMat;Mat(i,:)];
 end

end