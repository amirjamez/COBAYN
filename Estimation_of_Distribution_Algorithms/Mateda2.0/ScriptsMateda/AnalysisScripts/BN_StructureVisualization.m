%%%%%%%%%%%%%%%% KNOWLEDGE EXTRACTION AND VISUALIZATION EXAMPLES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%  EXAMPLE 1: 
%  Reading and visualizing the structure of the probabilistic models learned
%  during the evolution of an EDA based on Bayesian network.

  [run_s,results] = ViewStructuresFromFile('ProteinStructsExR.txt', 20, 'viewmatrix_method','ViewSummStruct',{[150,12]},'viewmatrix_method','ViewInGenStruct',{[150,12];[1,5,10]})
% The first figure corresponds to edges learned in all runs, all
% generations. The following figures corresponds to structures learned at
% generations 1, 5, 10 computed using all runs. 
