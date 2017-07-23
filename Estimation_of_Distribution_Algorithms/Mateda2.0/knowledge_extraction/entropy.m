function H = entropy(var,min,max,laplace)
% function H = entropy(var,min,max,laplace)
%
% entropy: Calculates the entropy for a discrete variables with positive states from min to max.
% INPUT:
% min: The minimum value
% max: The maximum value
% var: Array with the values for the discrete variable
% laplace: Determines wether or not Laplace correction is used in the computation
% of the probabilities. Laplace=1 (It is used), otherwise  it is not.
% OUTPUT:
% H: The entropy for a given variable.
%
% Last version 5/11/08. Carlos Echegoyen (carlos.echegoyen@ehu.es) 


if size(var,2) == 1 
    var = var';
end

H = 0;
N = size(var,2); 

% One counter for each state
nstates = max-min+1;
cont=zeros(1,nstates);
c=0;

for j=min:max % sumo 1 por si hay ceros. Recorro los estados
    c = c + 1;
    cont(c) = sum(var==j);
    
    % Calculating probabilities 
    if (laplace==1)
     Probs(c) = (cont(c)+1) / (N+nstates);
    else 
      Probs(c) = (cont(c)) / (nstates);   
    end
    
    % Calculating entropy
    if Probs(c)>0 
      H = H + Probs(c) * log2(Probs(c));
    end,
end

H = -H;

 
