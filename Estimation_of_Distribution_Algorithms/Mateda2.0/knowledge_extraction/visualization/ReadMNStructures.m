function[run_structures] = ReadMNStructures(n, maxgen, nruns,AllModels)
% [run_structures] = ReadMNStructures(n, maxgen, nruns,AllModels)
% ReadMNStructures:   Given the MN or factorization models learned during the execution of
%                     Mateda (i.e. Cliques saved in Cache{k,:}. Extract information
%                     ready for analysis and visualization
% INPUTS
% n: Number of variables
% mangen: maximum number of generations
% nruns: number of runs of the algorithm
% AllModels: Cell array containing in each row all the factorized models saved during
%            one run of the corresponding EDA (e.g. MOA,FDA,etc) , i.e. AllModels{i} = Cache{3,:} where Cache
%            is the output of the EDA that learns the factorizations
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
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       

 
[m,indexmatrix] = Find_indexmatrix(n);


% The matrices containing the occurrence of edges at each generation are constructed
AllSumMatrices = zeros(m,maxgen);
 
 for j=1:maxgen  
  AllContactMatrix{j}= zeros(n,n);
 end
  
for i=1:nruns,
 AllCliques = AllModels{i};
 BigMatrix = zeros(m,maxgen);
 edgemat = zeros(n,n);
  for j=1:size(AllCliques,2),      
      Cliques = AllCliques{j}{1};
      for k=1:size(Cliques,1)
        mySize = Cliques(k,1) + Cliques(k,2);
        for kk=3:(3+mySize -2); 
         for kkk=(kk+1):(3+mySize -1);
          edgemat(Cliques(k,kk),Cliques(k,kkk)) = 1;
         end
        end
      end
      sim_mat = (edgemat' + edgemat) > 0;
      AllContactMatrix{j} = AllContactMatrix{j} + sim_mat;
      edgeindex =   indexmatrix(find(sim_mat==1));
      if ~isempty(edgeindex)
        BigMatrix(edgeindex,j) = 1;       
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




