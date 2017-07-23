function[run_structures,maxgen,nruns] = ReadStructures(namefile,n)
% [run_structures,maxgen,nruns] = ReadStructures(namefile,n)
% ReadStructures:  Reads all structures stored in the file 'namefile' which correspond to 
%                  structures of the probabilistic models learned in nruns of an EDA with
%                  a maximum of maxgen generations.
% INPUTS
% namefile: file that contains the structures
%           The file contains two columns of numerical values
%           where negative values -g -r  mean that the precedent positive
%           values were the edges learned at generation g or run r.
%           (In the file, vertices are numbered from 0 to n-1)
%           EXAMPLE: 
%             2 0 
%             8 0 
%             14 3 
%             -1 -1
%             13 8 
%             0 10 
%             3 5
%             9 10 
%            -1 -2
%          The structure learned at run 1, generation 1 contains edges
%          (3,1), (9,1) and (15,4).  The structure learned at run 2,
%          generation 1 contains edges  (14,9), (1,11), (4,6) and (10,11).
% n: Number of variables
% mangen: maximum number of generations
% nruns: number of runs of the algorithm
% OUTPUTS
% run_structures{1} = indexmatrix(n,n): Associates an index to each possible edge in the network.
% e.g. indexmatrix(1,2) = 1, number of edges m = n*(n+1)/2;
% run_structures{2} = AllBigMatrices{nruns}(m,maxgen}: For each run contains whether the edge i appeared in generation j
% run_structures{3} = AllSumMatrices(m,maxgen): = \sum_i^nruns AllBigMatrices{i},
% i.e. the number of runs that each edge i appeared in generation j 
% run_structures{4} = AllContactMatrix{maxgen}(n,n): The number of runs in which edge i,j
% was present in generation k.
% run_structures{5} = SumAllContactMatrix(n,n): = \sum_k^maxgen AllContactMatrix{k}. 
% i.e. Total number of times edge i,j was present in all the structures
% learned in all generations of all runs.
% EXAMPLE
%[] = ReadStructures('ProteinStructsExR.txt',20,43,50)
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)



[m,indexmatrix] = Find_indexmatrix(n);

AuxFile = load (namefile);  % The file is read
Cycle = size(AuxFile,1);  % Its length is calculated

nruns = -1*min(AuxFile(:,1));
maxgen = -1*min(AuxFile(:,2));


a = 1;

 for i=1:Cycle,
  if(AuxFile(i,1)<0)
    run = -1*AuxFile(i,1);
    gen = -1*AuxFile(i,2);   
    AllStruct{run,gen} = AuxStruct;
    a = 1;
    AuxStruct = [];    
  else
    AuxStruct(a,:) = AuxFile(i,:);
    a = a+1;
  end 
end

% The matrices containing the occurrence of edges at each generation are constructed
AllSumMatrices = zeros(m,maxgen);
 
 for j=1:maxgen  
  AllContactMatrix{j}= zeros(n,n);
 end
 
for i=1:nruns,
 BigMatrix = zeros(m,maxgen);
  for j=1:size(AllStruct,2)  
     if ~isempty(AllStruct{i,j})
     edges = AllStruct{i,j};
     for k=1:size(edges,1),
      AllContactMatrix{j}(edges(k,1)+1,edges(k,2)+1) =  AllContactMatrix{j}(edges(k,1)+1,edges(k,2)+1) + 1;
      AllContactMatrix{j}(edges(k,2)+1,edges(k,1)+1) =  AllContactMatrix{j}(edges(k,2)+1,edges(k,1)+1) + 1;
      edgeindex = indexmatrix(edges(k,1)+1,edges(k,2)+1);
      BigMatrix(edgeindex,j) = 1;       
     end
   end
  end
  AllBigMatrices{i} = BigMatrix;
  AllSumMatrices = AllSumMatrices + BigMatrix;
end

SumAllContactMatrix = zeros(n,n);
for j=1:maxgen  
  SumAllContactMatrix  =  SumAllContactMatrix  + AllContactMatrix{j};
end

run_structures{1} = indexmatrix;
run_structures{2} = AllBigMatrices;
run_structures{3} = AllSumMatrices;
run_structures{4} = AllContactMatrix;
run_structures{5} = SumAllContactMatrix;




