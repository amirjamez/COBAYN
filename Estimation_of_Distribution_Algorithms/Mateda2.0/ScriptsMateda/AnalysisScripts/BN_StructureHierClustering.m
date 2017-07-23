 
% EXAMPLE 4:
% Dendrogram visualization of the hierarchical clustering of edges is shown
% Then, the ordering of variables found by the clustering is used to show
% the parallel coordinates representation of the edges learned at each
% generation.

 viewparams{1} = [14];
 viewparams{2} = []; % The edges will be found by the algorithm
 viewparams{3} = 30; % Only those edges that appear at least 30 times will be shown
 viewparams{4} = 3;  % Only substructures that have at least two edges are visualized in the PC
 viewparams{5} = 'correlation'; % The distance used to cluster edges is 1-correlation between variables.  (see help pdist).
 [run_s,results] = ViewStructuresFromFile('ProteinStructsExNR.txt',50, 'viewmatrix_method','ViewDenDroStruct',viewparams);

 viewparams{2} = results{3}; % The ordering of edges found by hierarchical clustering will be used to show parallel coordinates 
 viewparams{5} = 'none';
 viewparams{6} = '';
 [run_s,results] = ViewStructuresFromFile('ProteinStructsExNR.txt',50, 'viewmatrix_method','ViewPCStruct',viewparams);


 viewparams{1} = 14;
 viewparams{2} = [3 4 ; 4 5 ; 3 5 ; 6 7 ; 7 8; 8 9]; % The edges are  listed
 viewparams{3} = [1:10]; % The first 10 runs
 viewparams{4} = [2,4,6,8,10]; % Generations 2,4,6,8,10
 [run_s,results] = ViewStructuresFromFile('ProteinStructsExNR.txt',50, 'viewmatrix_method','ViewGlyphStruct',viewparams);
