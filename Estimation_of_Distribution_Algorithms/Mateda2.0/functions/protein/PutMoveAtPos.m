function[Pos] = PutMoveAtPos(Pos,pos,mov)
% PutMoveAtPos:    updates the lattice given a mov
% INPUTS
% sizeChain: Size of the subchain inspected
% pos: Position of the residue in the sequence  
% mov: Corresponding move (left,front,right)
% OUTPUTS
% Pos: Final configuration of the sequence 

if (pos<3) 
 return;
end

i = pos;

 if(Pos(i-1,2)==Pos(i-2,2))
  if (mov==0)            %UP MOVE
   Pos(i,1) = Pos(i-1,1);  
   Pos(i,2) = Pos(i-1,2) + (Pos(i-1,1)-Pos(i-2,1));
  elseif (mov==1)        %FORWARD MOVE 
   Pos(i,1) = Pos(i-1,1) + (Pos(i-1,1)-Pos(i-2,1));  
   Pos(i,2) = Pos(i-1,2);
  else                         %DOWN MOVE
   Pos(i,1) = Pos(i-1,1);  
   Pos(i,2) = Pos(i-1,2) - (Pos(i-1,1)-Pos(i-2,1));
  end
  end
if (Pos(i-1,1)==Pos(i-2,1))
  if (mov==0)            %UP MOVE
    Pos(i,2) = Pos(i-1,2);  
    Pos(i,1) = Pos(i-1,1) -  (Pos(i-1,2)-Pos(i-2,2));  
  elseif (mov==1)        %FORWARD MOVE 
    Pos(i,2) = Pos(i-1,2) +  (Pos(i-1,2)-Pos(i-2,2));  
    Pos(i,1) = Pos(i-1,1);
  else                         %DOWN MOVE
    Pos(i,2) = Pos(i-1,2);  
    Pos(i,1) = Pos(i-1,1) + (Pos(i-1,2)-Pos(i-2,2));
  end
 end


% Last version 10/09/2005. Roberto Santana (rsantana@si.ehu.es) 