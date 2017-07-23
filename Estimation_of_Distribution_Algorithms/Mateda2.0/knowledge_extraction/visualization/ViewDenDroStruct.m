function[res_ordering] = ViewDenDroStruct(run_structures,viewparams)
%   function[res_ordering] = ViewDenDroStruct(run_structures,viewparams)
%   ViewDenDroStruct:  Shows the dendrograms of the edges according to
%                       their co-occurrence in the structures learned by
%                       the EDAs. Allows to detect complex hierarchical
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
% OUTPUT:
% res_ordering{1} = T;
% res_ordering{2} = PERM; % Ordering of the variables in the dendrogram
% res_ordering{3} = List of the originals edges in the order they are shown
%                   in the dendrogram
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)


indexmatrix = run_structures{1};
fs = viewparams{1};
substruct = viewparams{2};
const_edg = viewparams{3};
min_edg = viewparams{4};
distance = viewparams{5};

results = [];


 if isempty(substruct)
   [RepEdges] = SelectEdgesToShow(run_structures,const_edg); % Edges are selected according to const_edg value
   if(isempty(RepEdges))
      disp('No edges were selected. Reduce the number of times required to an edge to appear.') %No edges were found
      return
   end
   for i=1:size(RepEdges,2) 
     [row,col] = find(indexmatrix==RepEdges(i));
      dlabels{i} = [int2str(row(1)),'-',int2str(col(1))]; 
   end
 else
  for i=1:size(substruct,1)  
   RepEdges(1,i) = indexmatrix(substruct(i,1),substruct(i,2));    % Indices of the edges in indexmatrix    
   dlabels{i} = [int2str(substruct(i,1)),'-',int2str(substruct(i,2))]; 
  end
 end      
 
  
 [AllRepVectors] = ExtractSubstructures(run_structures,RepEdges,min_edg); % The substructures to be shown are extracted

 nedges = size(RepEdges,2)
 
 
 y = pdist(AllRepVectors', distance);
 z = linkage(y,'single')
 
 figure     % Dendrogram figure 
 axes('Fontsize',fs);
 [H,T,PERM] = dendrogram(z,nedges,'orientation','left','labels',dlabels);

  
 res_ordering{1} = T;
 res_ordering{2} = PERM; % Ordering of the variables in the dendrogram
 
 for i=1:nedges
  [row,col] = find(indexmatrix==RepEdges(PERM(i)));
   res_ordering{3}(i,:) = [row(1),col(1)];
 end
 
 return
 
 

 

 
 
 
 
 