function [lattice, inter] = LoadIsing(n, inst)
% [lattice, inter] = LoadIsing(n, inst)
% LoadIsing: Reads  the file of an Ising instance 
% INPUT
% n: number of variables
% inst: the number of the instance
% OUTPUT
% Isinglattice: this structure represents the J matrix (The neighboors for each node)
% Isinginter: this structure contains the value of the interactions between spins
%
% Last version 8/26/2008. Carlos Echegoyen and Roberto Santana (roberto.santana@ehu.es)


%instance = ['./IsingInstances/SG_', num2str(n), '_', num2str(inst), '.txt'];
instance = ['SG_', num2str(n), '_', num2str(inst), '.txt'];

fp = fopen(instance, 'r');
numVars = fscanf(fp, '%d', 1);
dim = fscanf(fp, '%d', 1);
neigh = fscanf(fp, '%d', 1);
width = fscanf(fp, '%d', 1);

% Initialize laticce and inter
neighbor = power(2, neigh) * dim;
lattice = zeros(numVars, neighbor + 1);
inter = zeros(numVars, neighbor);

% Load the structures from file
for i=1:numVars
    lattice(i,1) = fscanf(fp, '%d', 1);
    
    if lattice(i,1) > 0
    
        for j=2:lattice(i,1) + 1
            lattice(i,j) = fscanf(fp, '%d', 1) + 1;
        end
    
        for j=1:lattice(i,1)
            inter(i,j) = fscanf(fp, '%d', 1);
        end

    end
    
end

fclose(fp);