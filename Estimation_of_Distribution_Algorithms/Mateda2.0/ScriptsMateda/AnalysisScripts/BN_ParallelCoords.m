% EXAMPLE 3:
% Parallel coordinate visualization of the generations at which most
% frequent edges appearing in the structures  learned by an EDA. The
% vertical axis represent the generation at which edges (shown in the
% horizontal axis) has been learned. A line between two points means that
% both edges appear in the same structure learned at the same generation. 

 viewparams{1} = [14];
 viewparams{2} = []; % The edges will be found by the algorithm
 viewparams{3} = 20; % Only those edges that appear at least 20 times will be shown
 viewparams{4} = 2;  % Only substructures that have at least two edges are visualized in the PC
 viewparams{5} = 'ClusterUsingCorr'; % Variables will be ordered according correlation
 viewparams{6} = 'correlation';  %The distance used to cluster edges is 1-correlation between variables.  (see help pdist).

 [run_s,results] = ViewStructuresFromFile('ProteinStructsExR.txt', 20, 'viewmatrix_method','ViewPCStruct',viewparams)
 
