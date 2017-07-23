% for each benchmark in bench, fetch the best selectionSize optimization combination and I store them in the bestSet
% each row of bestSet has first the 99 MICA metrics (I use here the normalized version) and then the compiler optimizations.
% I also return the execution time but I do not need it anymore.
% ALO is the list of Applizations to be Left Out
% DLO is the list of Dataset to be Left Out

function [bestSet2 ExT ] = getBestSet2(bench, selectionSize,ALO,DLO)
if(nargin == 2)
  ALO = []; DLO = [];
    else if( nargin == 3)
        DLO = 1:size(bench,2);
    end
end

bestSet2 = zeros( prod(size(bench)-[ max(size(ALO)) max(size(DLO)) ]) * selectionSize  ,  size(bench(1,1).micaNorm,2) + size(bench(1,1).DB,2)  );
ExT = zeros(prod(size(bench)) * selectionSize, 1 );

arrayPointer = 1;
for a=1:size(bench,1) 
  for d=1:size(bench,2)
    if((ismember(a,ALO) & ismember(d,DLO) ))
      myExT = bench(a,d).Y;
      [sortedT, ids] = sort(myExT);
      
      myBestDB = bench(a,d).DB(ids(1:selectionSize),:);
      
      bestSet2( arrayPointer:(arrayPointer+selectionSize-1), 1:size(bench(a,d).micaNorm,2) ) = ...
                            repmat(bench(a,d).micaNorm,selectionSize,1) ;
      bestSet2( arrayPointer:(arrayPointer+selectionSize-1), (size(bench(a,d).micaNorm,2)+1):( size(bench(1,1).micaNorm,2) + size(bench(1,1).DB,2) ) ) = ...
                            myBestDB ;
      
      ExT( arrayPointer:(arrayPointer+selectionSize-1) ) = sortedT(1:selectionSize);
                            
      arrayPointer = arrayPointer + selectionSize;
    end
  end
end
