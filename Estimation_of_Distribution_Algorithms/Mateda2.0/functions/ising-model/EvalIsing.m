function [r] = evalIsing(ind)
% [r] = evalIsing(ind)
%  evalIsing : Gives the value of the Ising model for zero-one
%                        vector configuration. Requires that lattice and inter be previously
%                        defined as global structures.
% INPUT
% ind: the individual (vector) which represents a matrix of values for the spins
% lattice, inter: Structures with the lattice J and the interaction values between spins
% OUTPUT
% The evaluation of the Ising model given a problem instance and a
% individual
%
% Last version 8/26/2008. Carlos Echegoyen and Roberto Santana (roberto.santana@ehu.es)

global Isinglattice
global Isinginter
r = 0;
for i=1:size(Isinglattice,1)
    if Isinglattice(i,1) > 0
        for j=2:(Isinglattice(i,1) + 1)
            if i < Isinglattice(i,j)
                auxr = 2 * (ind(i) == ind(Isinglattice(i,j))) - 1;
                r = r + (auxr * Isinginter(i,j-1));
            end
        end
    end
end

r = -1*r;