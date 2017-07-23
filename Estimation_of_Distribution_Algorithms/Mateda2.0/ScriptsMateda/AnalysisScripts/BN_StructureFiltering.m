%  EXAMPLE 2:
%  We want to see all adjacency matrices of those structures learned in all runs
%  such that edges (3,4) and (4,5) appear together and edge (3,5) does not appear

  nruns = 50;
  maxgen = 43;
  viewparams{1} = [100,14];
  viewparams{2} = [3 4 1; 4 5 1; 3 5 0];  % The substructure is described
  viewparams{3} = [1:nruns];              % Selected runs (All)
  viewparams{4} = [1:maxgen];             % Selected generations (All)
  viewparams{5} = 'all_graphs';           % Graphs to be seen (All)
  [run_s,results] = ViewStructuresFromFile('ProteinStructsExR.txt', 20, 'viewmatrix_method','ViewEdgDepStruct',viewparams)
