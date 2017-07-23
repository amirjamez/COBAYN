function[s] = CallBackTracking(InitConf)
 
sizeChain = size(InitConf,2);

Pos =  NewInitPop(sizeChain);

  for i=1:sizeChain
   moves(i,:) = randperm(3)-1;
  end
  
 s = [];
 sizeChain = size(InitConf,2);
 
 [solutionFound,s,Pos] = NewBackTracking(InitConf,sizeChain,Pos,1,moves,s);




 