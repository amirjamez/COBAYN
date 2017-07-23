function[AuxContactMatrix] = ConvertFromIndex(indexmatrix,one_gen)
% [AuxContactMatrix] = ConvertFromIndex(indexmatrix,one_gen)
%
% ConvertFromIndex:  Transforms a vector of indices corresponding to edges in an adjacency
%                    matrix.
% INPUT
% indexmatrix : Matrix in which cell i,j contains the index of the edge
% one_gen: One vector where each position i corresponds to absence/presence
% of edge represented by index i in the structure
%  OUTPUT
%  AuxContactMatrix: Adjacency matrix
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)

n = size(indexmatrix,1);    % number of variables

alledges = find(one_gen>0); % edges present in the structure

AuxContactMatrix = zeros(n,n);

for i=1:size(alledges,1)
 [row,col] = find(indexmatrix==alledges(i));
 AuxContactMatrix(row,col) = one_gen(alledges(i));
end