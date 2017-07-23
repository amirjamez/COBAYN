function[res_ordering] = ViewPCStruct(run_structures,viewparams)
% [res_ordering] = ViewPCStruct(run_structures,viewparams)
% 'ViewPCStruct':  Parallel coordinate visualization of the generations at which most
%                  frequent edges appearing in the structures  learned by an EDA. The
%                  vertical axis represents the generation at which edges (shown in the
%                  horizontal axis) has been learned. A line between two points means that
%                  both edges appear in the same structure learned at the same generation. 
% INPUT:
% run_structures: Contain the data structures with all the structures
% learned by the probability models in every run and generation (see  program ReadStructures.m for details.
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
% OUTPUT:
% res_ordering{1}: Generations from which the edges have been extracted
% res_ordering{2}: Executions from which the edges have been extracted
% res_ordering{3}: List of the edges
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)

indexmatrix = run_structures{1};

fs = viewparams{1};
substruct = viewparams{2};
const_edg = viewparams{3};
min_edg = viewparams{4};
edge_ordering_method = viewparams{5};
distance =  viewparams{6};



results{1} = [];

 if isempty(substruct)
   [RepEdges] = SelectEdgesToShow(run_structures,const_edg); % Edges are selected according to const_edg value
   if(isempty(RepEdges))
      disp('No edges were selected. Reduce the number of times required to an edge to appear.') %No edges were found
      return
   end
 else
  for i=1:size(substruct,1)  
   RepEdges(1,i) = indexmatrix(substruct(i,1),substruct(i,2));    % Indices of the edges in indexmatrix    
  end
 end
 
 
 
 [AllRepVectors] = ExtractSubstructures(run_structures,RepEdges,min_edg); % The substructures to be shown are extracted

 nedges = size(RepEdges,2);
 ordering = [1:nedges];
 
 if(strcmp(edge_ordering_method,'random') == 1)
  ordering = randperm(nedges);   
 elseif(strcmp(edge_ordering_method,'none') ~= 1)    
     res_ordering  = eval([edge_ordering_method,'(AllRepVectors,distance)';]); %The method for ordering the variables is invoked
     ordering = res_ordering{1}; % The new ordering of the variables should be the first output of the method
 end,

 
 ShowParallelCoord(fs,AllRepVectors(:,ordering)); % Parallel coordinates are shown in the new ordering
  
 res_ordering{1} = ordering;
 
 for i=1:nedges
  [row,col] = find(indexmatrix==RepEdges(ordering(i)));
   res_ordering{3}(i,:) = [row(1),col(1)];
 end
 
 return
 
 

 

 
 
 
 
 