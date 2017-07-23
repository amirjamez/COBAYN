function[results] = ViewStructures(run_structures,n,maxgen,nruns,varargin)
% [results] = ViewStructures(run_structures,n,maxgen,nruns,varargin)
% ViewStructures: Allows the visualization of the structures using
%                 different visualization methods.
% INPUTS
% namefile: file that contains the structures
% n: Number of variables
% mangen: maximum number of generations
% nruns: number of runs of the algorithm
% Optional INPUTS
% 'viewmatrix_method' followed by  'viewproc_filename' and array "viewparams": determines the procedure
% to view the data. The procedure is implemented in the matlab program:
% 'viewproc_filename.m' which receives as parameters the structures computed 
%  by the program ReadStructures.m  and the array of parameters "viewparams"
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
% 'ViewPCStruct'  : Searches for substructures in the set of all the structures learned
%                   and show the parallel coordinates of the edges and the
%                   generations at which they are learned. 
% viewparams{1} = fs; % fs: Font size for the images                       
% viewparams{2} : Vector with indices of edges that will be shown. For showing all the edges, set viewparams{2}=[1:m]. 
% viewparams{3} = const_edg :  Minimal number of times that an edge has to appear in (all) the structures learned
%                             to be selected for visualization.  
% viewparams{4} : Method used to order the variables before displaying them
% using  parallel coordinates. Ordering may help to reduce cluttering, improving
% visualization.  viewparams{4} = 'none' if no ordering method is used. 
% Ordering methods can be implemented by the user. Currently implemented is
% 'ClusterUsingCorr' which clusters togethers variables with strong
% correlation.
%
% More than one than one kind of graphs can be generated in the same call to
% the function by including several options together (see examples below)
% User can add more methods for visualization by passing them the
% appropriate output computed by ReadStructures.m (see program Help)
%
% OUTPUTS
%
% EXAMPLES 
%
% First Example
% [run_structures,maxgen,nruns] = ReadStructures('ProteinStructsExR.txt',20);
% [results] = ViewStructures(run_structures,20,maxgen,nruns,'viewmatrix_method','ViewSummStruct',{[150,14]},'viewmatrix_method','ViewInGenStruct',{[150,14];[1,5,10]})
% The first figure corresponds to edges learned in all runs, all
% generations. The following figures corresponds to structures learned at
% generations 1, 5, 10 computed using all runs. 
%
% Second Example
% We want to see all adjacency matrices of those structures learned in all runs
% such that edges (3,4) and (4,5) appear together and edge (3,5) does not appear
% viewparams{1} = [100,14];
% viewparams{2} = [3 4 1; 4 5 1; 3 5 0]; % The substructure is described
% viewparams{3} = [1:nruns]; % Selected runs (All)
% viewparams{4} = [1:maxgen]; % Selected generations (All)
% viewparams{5} = 'all_graphs'; % Graphs to be seen (All)
% [run_structures,maxgen,nruns] = ReadStructures('ProteinStructsExR.txt',20);
% [results] = ViewStructures(run_structures,20,maxgen,nruns, 'viewmatrix_method','ViewEdgDepStruct',viewparams)
%
% Third Example
% Parallel coordinate visualization of the generations at which most
% frequent edges appearing in the structures  learned by an EDA
%
% viewparams{1} = [14];
% viewparams{2} = []; % The edges will be found by the algorithm
% viewparams{3} = 60; % Only those edges that appear at least 20 times will be shown
% viewparams{4} = 2;  % Only substructures that have at least two edges are visualized in the PC
% viewparams{5} = 'ClusterUsingDist'; % Variables will be ordered according correlation
% viewparams{6} = 'correlation';
% [run_structures,maxgen,nruns] = ReadStructures('ProteinStructsExR.txt',20);
% [results] = ViewStructures(run_structures,20,maxgen,nruns,  'viewmatrix_method','ViewPCStruct',viewparams)
%
% Fourth Example
% Glyph visualization of the generations at which most
% frequent edges appearing in the structures  learned by an EDA
%
% viewparams{1} = [14];
% viewparams{2} = results{3}; % The edges will be found by the algorithm
% viewparams{3} = [1:10];   % Vector with the selected runs  that will be  inspected
% viewparams{4} = [1:13];   % Vector of the selected generations  that will be inspected
% [run_structures,maxgen,nruns] = ReadStructures('ProteinStructsExR.txt',20);
% [newresults] = ViewStructures(run_structures,20,maxgen,nruns, 'viewmatrix_method','ViewGlyphStruct',viewparams)
%
% Fith Example
% Dendrogram visualization of the generations at which most
% frequent edges appearing in the structures  learned by an EDA
%
% viewparams{1} = [14];
% viewparams{2} = []; % The edges will be found by the algorithm
% viewparams{3} = 60; % Only those edges that appear at least 20 times will be shown
% viewparams{4} = 2;  % Only substructures that have at least two edges are visualized in the PC
% viewparams{5} = 'correlation';
% [run_structures,maxgen,nruns] = ReadStructures('ProteinStructsExR.txt',20);
% [results] = ViewStructures(run_structures,20,maxgen,nruns, 'viewmatrix_method','ViewDendroStruct',viewparams)
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)        


% Default params value 

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





