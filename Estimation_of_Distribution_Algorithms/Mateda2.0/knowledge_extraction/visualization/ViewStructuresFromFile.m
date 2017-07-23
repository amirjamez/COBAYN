function[run_structures,results] = ViewStructuresFromFile(namefile,n,varargin)
% [run_structures,results] = ViewStructuresFromFile(namefile,n,varargin)
% ViewStructuresFromFile: Given a file containing the  structures of the
% models learned by an EDA in different generations, extract information
% from the estructures and visualize this information using different
% methods
% INPUTS
%
% namefile: file that contains the structures
% n: Number of variables
% mangen: maximum number of generations
% nruns: number of runs of the algorithm
%
% Optional INPUTS
%
% 'viewmatrix_method' followed by  'viewproc_filename' and array "viewparams": determines the procedure
% to view the data. The procedure is implemented in the matlab program:
% 'viewproc_filename.m' which receives as parameters the structures computed 
%  by the program ReadStructures.m  and the array of parameters "viewparams"
%
% Currently, the following procedures have been implemented:
%
% 'ViewSummStruct'    : Show one image where each edge has a color proportional 
%                       to the times it has been present in the structures learned in all generations.
% viewparams{1} = [pcolors,fs]; % pcolors: range of colors for the  images. fs: Font size for the images                       
%                    
% 'ViewInGenStruct'   : Shows images where each edge has a color
%                       proportional (relative to nruns)   to the times it has been present in the structures
%                       learned in those generations included in viewparams{2}.
%                       There is one figure for each generation.
%                       For showing all the generations, set viewparams{2}=[1:ngen]. 
% viewparams{1} = [pcolors,fs]; % pcolors: range of colors for the  images. fs: Font size for the images                       
%
%
%                       
% 'ViewEdgDepStruct'  : Searches for substructures in the set of all the structures learned
%                       and show the adjacency matrices corresponding to
%                       the structures
% viewparams{1} = [pcolors,fs]; % pcolors: range of colors for the
% images. fs: Font size for the images
% viewparams{2}: Describe the substructure by giving values of
% absence/presence to a subset of edges. (see Example below)
% viewparams{3}:   % Vector of with the selected runs  that will be
% inspected
% viewparams{4};  % Vector of with the selected generations  that will be
% inspected
% viewparams{5}; % Display type that could be one of the following:
%   'all_graphs': There is an image for each structure that contain the
%    substructure.
%   'one_graph': an image adding all the structures that contain the
%    substructure.
%   'no_graph': no image is generated. This option is for the cases where we only
%    want the list of runs and generations where the substructure is
%    included. This is an output of the function (see ViewEdgDepStruct.m
%    for details)
% 
%
% 'ViewPCStruct'  : Searches for substructures in the set of all the structures learned
%                   and show the parallel coordinates of the edges and the
%                   generations at which they are learned. 
%
% viewparams{1} = fs; % fs: Font size for the images                       
% viewparams{2} : Matrices with edges that will be shown. One row for each
% edge. If viewparams{2}== [], the algorithm finds a subset of edges
% according viewparams{3}
% viewparams{3} = const_edg :  Minimal number of times that an edge has to appear in (all) the structures learned
%                             to be selected for visualization. Since the  clarity of the parallel coordinate
%                             visualization depend on the number of variables, this is an important parameter. 
% 
% viewparams{4} = min_edg :  Minimal number of edges in the substructures selected (min_edg>0)
% viewparams{5} : Method used to order the variables before displaying them
% using  parallel coordinates. Ordering may help to reduce cluttering, improving
% visualization. viewparams{5} = 'none' if the current  given ordering is used. 
% viewparams{5} = 'random' for random order of variables 
% Ordering methods can be implemented by the user. Currently implemented is
% 'ClusterUsingCorr' which clusters togethers variables with strong
% correlation using affinity propagation.
% viewparams{6} = distance. Distance used to cluster edges from their
% appearance in the structures (distances used by matlab command pdist (ex. 'correlation', 'euclidean',etc.) can
% be used (see help pdist).
%    'ViewDenDroStruct'  :  Shows the dendrograms of the edges according to
%                       their co-occurrence in the structures learned by
%                        the EDAs. Allows to detect complex hierarchical
%                       relationships between the variables of the problem
%                       
% INPUT
% run_structures: Contain the data structures with all the structures
% learned by the probability models in every run and generation (see
% program ReadStructures.m for details.
% viewparams{1} = fs; % fs: Font size for the images                       
% viewparams{2} : Matrices with edges that will be shown. One row for each
% edge. If viewparams{2}== [], the algorithm finds a subset of edges
% according viewparams{3}
% viewparams{3} = const_edg :  Minimal number of times that an edge has to appear in (all) the structures learned
%                             to be selected for visualization. Since the  clarity of the parallel coordinate
%                             visualization depend on the number of variables, this is an important parameter. 
% viewparams{4} = min_edg :  Minimal number of edges in the substructures selected (min_edg>0)
% viewparams{5} = distance. Distance used to cluster edges from their
% appearance in the structures (distances used by matlab command pdist (ex. 'correlation', 'euclidean',etc.) can
% be used (see help pdist).
%
%                       
% 'ViewGlyphStruct'    :Shows the glyph representation of a subset of edges learned
%                       at a given set of runs and generations
%
%
% INPUT
% run_structures: Contain the data structures with all the structures
% learned by the probability models in every run and generation (see
% program ReadStructures.m for details.
%
% viewparams{1} = fs; % fs: Font size for the images
% viewparams{2}:  List of edges, one row for each edge
% viewparams{3}:  % Vector with the selected runs  that will be inspected
% viewparams{4};  % Vector of the selected generations  that will be inspected
%
% OUTPUT
% results{1}: Matrix containing one vector for each of the substructures
% shown with the glyphs
%
%
% More than one than one kind of graphs can be generated in the same call to
% the function by including several options together (see examples below)
% User can add more methods for visualization by passing them the
% appropriate output computed by ReadStructures.m (see program Help)
%
% EXAMPLES 
%
% Example 1
% [run_s,results] = ViewStructuresFromFile('ProteinStructsExR.txt', 20, 'viewmatrix_method','ViewSummStruct',{[150]},'viewmatrix_method','ViewInGenStruct',{150;[1,5,10]})
% The first figure corresponds to edges learned in all runs, all
% generations. The following figures corresponds to structures learned at
% generations 1, 5, 10 computed using all runs. 
%
% Example 2
% We want to see all adjacency matrices of those structures learned in all runs
% such that edges (3,4) and (4,5) appear together and edge (3,5) does not appear
% viewparams{1} = [100,14];
% viewparams{2} = [3 4 1; 4 5 1; 3 5 0]; % The substructure is described
% viewparams{3} = [1:nruns]; % Selected runs (All)
% viewparams{4} = [1:maxgen]; % Selected generations (All)
% viewparams{5} = 'all_graphs'; % Graphs to be seen (All)
% [run_s,results] = ViewStructuresFromFile('ProteinStructsExR.txt', 20, 'viewmatrix_method',viewparams)
% 
% Example 3
% Parallel coordinate visualization of the generations at which most
% frequent edges appearing in the structures  learned by an EDA. The
% vertical axis represent the generation at which edges (shown in the
% horizontal axis) has been learned. A line between two points means that
% both edges appear in the same structure learned at the same generation. 
%
% viewparams{1} = [14];
% viewparams{2} = []; % The edges will be found by the algorithm
% viewparams{3} = 20; % Only those edges that appear at least 20 times will be shown
% viewparams{4} = 2;  % Only substructures that have at least two edges are visualized in the PC
% viewparams{5} = 'ClusterUsingCorr'; % Variables will be ordered according correlation
% viewparams{6} = correlation. The distance used to cluster edges is 1-correlation between variables.  (see help pdist).
%
% [run_s,results] = ViewStructuresFromFile('ProteinStructsExR.txt', 20, 'viewmatrix_method','ViewPCStruct',viewparams)
% 
% Example 4
% First a dendrogram visualization of the hierarchical clustering of edges is shown
% Then, the ordering of variables found by the clustering is used to show
% the parallel coordinates representation of the edges learned at each
% generation.
% viewparams{1} = [14];
% viewparams{2} = []; % The edges will be found by the algorithm
% viewparams{3} = 30; % Only those edges that appear at least 30 times will be shown
% viewparams{4} = 3;  % Only substructures that have at least two edges are visualized in the PC
% viewparams{5} = 'correlation'; % The distance used to cluster edges is 1-correlation between variables.  (see help pdist).
% [run_s,results] = ViewStructuresFromFile('ProteinStructsExNR.txt',50, 'viewmatrix_method','ViewDenDroStruct',viewparams);
% viewparams{2} = results{3}; % The ordering of edges found by hierarchical clustering will be used to show parallel coordinates 
% viewparams{5} = 'none';
% viewparams{6} = '';
% [run_s,results] = ViewStructuresFromFile('ProteinStructsExNR.txt',50, 'viewmatrix_method','ViewPCStruct',viewparams);
%
%
% viewparams{1} = 14;
% viewparams{2} = [3 4 ; 4 5 ; 3 5 ; 6 7 ; 7 8; 8 9]; % The edges are  listed
% viewparams{3} = [1:10]; % The first 10 runs
% viewparams{4} = [2,4,6,8,10]; % Generations 2,4,6,8,10
% [run_s,results] = ViewStructuresFromFile('ProteinStructsExNR.txt',50, 'viewmatrix_method','ViewGlyphStruct',viewparams);
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)    

[run_structures,maxgen,nruns] = ReadStructures(namefile,n);


% Default params values

viewparams{1}(1) = 100; % Range of colors 
viewparams{1}(2) = 14;  % Font size

viewmethod = 'ViewSummStruct'; % Default view method

args = varargin;
nargs = length(args);
if length(args) > 0
    if isstr(args{1})
    	for i = 1:3:nargs
    		switch args{i}
    		 case 'viewmatrix_method', viewmethod = args{i+1};, viewparams = args{i+2};
            end;
            results = eval([viewmethod,'(run_structures,viewparams)']);
    	end;
    end;
end;





