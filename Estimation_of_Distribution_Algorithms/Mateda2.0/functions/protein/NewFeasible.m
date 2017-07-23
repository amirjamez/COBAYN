function[is_feasible] = NewFeasible(s,i,Pos)
% NewFeasible evaluates if a given move is feasible.

  global HPInitConf;

   if (size(s,2) <=2)
       is_feasible=1;
       return;
   else
       [Overlappings,Pos] =  CheckConstraint(Pos,i,s);
        is_feasible = (Overlappings==0);
   end

% Last version 10/09/2005. Roberto Santana (rsantana@si.ehu.es) 