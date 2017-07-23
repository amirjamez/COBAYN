function[Collisions,Overlappings,Pos] =  EvalChainFunctional(vector)
% Given a chain of molecules, calculates the numer of Collisions with 
% neighboring same sign molecules, and the number of Overlappings molecules.
% HPInitConf is the configuration of the Chain of molecules
% vector is the set of moves for all 

global HPInitConf;
sizeChain = size(vector,2);

Collisions = 0;
Overlappings = 0;


Pos = zeros(sizeChain,2);

Pos(1,1) = 0;  %Position for the initial molecule 
Pos(1,2) = 0;
 
Pos(2,1) = 1;  %Position for the second molecule 
Pos(2,2) = 0;

 for i=3:sizeChain

 if(Pos(i-1,2)==Pos(i-2,2))
  if (vector(i)==0)            %UP MOVE
   Pos(i,1) = Pos(i-1,1);  
   Pos(i,2) = Pos(i-1,2) + (Pos(i-1,1)-Pos(i-2,1));
  elseif (vector(i)==1)        %FORWARD MOVE 
   Pos(i,1) = Pos(i-1,1) + (Pos(i-1,1)-Pos(i-2,1));  
   Pos(i,2) = Pos(i-1,2);
  else                         %DOWN MOVE
   Pos(i,1) = Pos(i-1,1);  
   Pos(i,2) = Pos(i-1,2) - (Pos(i-1,1)-Pos(i-2,1));
  end
  end
if (Pos(i-1,1)==Pos(i-2,1))
  if (vector(i)==0)            %UP MOVE
    Pos(i,2) = Pos(i-1,2);  
    Pos(i,1) = Pos(i-1,1) -  (Pos(i-1,2)-Pos(i-2,2));  
  elseif (vector(i)==1)        %FORWARD MOVE 
    Pos(i,2) = Pos(i-1,2) +  (Pos(i-1,2)-Pos(i-2,2));  
    Pos(i,1) = Pos(i-1,1);
  else                         %DOWN MOVE
    Pos(i,2) = Pos(i-1,2);  
    Pos(i,1) = Pos(i-1,1) + (Pos(i-1,2)-Pos(i-2,2));
  end
 end

   for j=1:i-2,   % Check for Overlappings and Collissions in all the    molecules except the previous one
    if(Pos(i,1)==Pos(j,1) & Pos(i,2)==Pos(j,2))
      Overlappings = Overlappings + 1;
    elseif (HPInitConf(i)==0  & HPInitConf(j)==0) 
     if (Pos(i,1)==Pos(j,1) & Pos(i,2)==Pos(j,2)-1)
        Collisions =   Collisions + 2;
     end
     if (Pos(i,1)==Pos(j,1)+1 & Pos(i,2)==Pos(j,2))
        Collisions =   Collisions + 2;
     end
     if (Pos(i,1)==Pos(j,1) & Pos(i,2)==Pos(j,2)+1)
        Collisions =   Collisions + 2;
     end
     if (Pos(i,1)==Pos(j,1)-1 & Pos(i,2)==Pos(j,2))
        Collisions =   Collisions + 2;
     end
    elseif (HPInitConf(i)+HPInitConf(j)>0)    
     if (Pos(i,1)==Pos(j,1) & Pos(i,2)==Pos(j,2)-1)
        Collisions =   Collisions - 1;
     end
     if (Pos(i,1)==Pos(j,1)+1 & Pos(i,2)==Pos(j,2))
        Collisions =   Collisions - 1;
     end
     if (Pos(i,1)==Pos(j,1) & Pos(i,2)==Pos(j,2)+1)
        Collisions =   Collisions - 1;
     end
     if (Pos(i,1)==Pos(j,1)-1 & Pos(i,2)==Pos(j,2))
        Collisions =   Collisions - 1;
     end
    end 
 end 
end 

%HPInitConf =  [zeros(1,12),1,0,1,0,1,1,0,0,1,1,0,0,1,1,0,1,1,0,0,1,1,0,0,1,1,0,1,1,0,0,1,1,0,0,1,1,0,1,0,1,zeros(1,12)]; 




 

