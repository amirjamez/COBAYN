function[Sj] =  CreateFibbInitConf(n)
%Translates the vector to the  positions in the grid

Si = [1];
Sj = [0];

for i=2:n
  aux = Sj;
  Sj = [Si,Sj];
  Si = aux;
end
