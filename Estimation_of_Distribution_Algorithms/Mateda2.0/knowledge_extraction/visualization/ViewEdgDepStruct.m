function[results] = ViewEdgDepStruct(run_structures,viewparams)
% [results] = ViewEdgDepStruct(run_structures,viewparams)
%                       
% 'ViewEdgDepStruct'  : Searches for substructures in the set of all the structures learned
%                       and can show the adjacency matrices corresponding to
%                       these  structures
% INPUT
% run_structures: Contain the data structures with all the structures
% learned by the probability models in every run and generation (see
% program ReadStructures.m for details.
% viewparams{1} = [pcolors,fs]; % pcolors: range of colors for the
% images. fs: Font size for the images
% viewparams{2}: Describe the substructure by giving values of
% absence/presence to a subset of edges. (see Example below)
% viewparams{3}:   % Vector with the selected runs  that will be inspected
% viewparams{4};  % Vector of with the selected generations  that will be inspected
% viewparams{5}; % Display type that could be one of the following:
%   'all_graphs': There is an image for each structure that contain the
%    substructure.
%   'one_graph': an image adding all the structures that contain the
%    substructure.
%   'no_graph': no image is generated. This option is for the cases where we only
%    want the list of runs and generations where the substructure is
%    included. This is an output of the function (see ViewEdgDepStruct.m
%    for details)
% OUTPUT
% results: a matrix of 2 columns, where each row contains a run and
% generation where the subgraph has been found 
% EXAMPLE
% We want to see all adjacency matrices of those structures learned in all runs
% such that edges (3,4) and (4,5) appear together and edge (3,5) does not appear
% viewparams{1} = [100,14];
% viewparams{2} = [3 4 1; 4 5 1; 3 5 0]; % The substructure is described
% viewparams{3} = [1:nruns]; % Selected runs (All)
% viewparams{4} = [1:maxgen]; % Selected generations (All)
% viewparams{5} = 'all_graphs'; % Graphs to be seen (All)
% [results] = ViewEdgDepStruct(run_structures,viewparams);
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)
 

indexmatrix = run_structures{1};
AllBigMatrices = run_structures{2};

pcolors = viewparams{1}(1); % Range of  colors
fs = viewparams{1}(2);      % Fontsize for the figures

substruct = viewparams{2};
selected_runs = viewparams{3};
generations = viewparams{4};
display_type = viewparams{5};

n = size(indexmatrix,1);
AuxSumContactMatrix = zeros(n,n);
results  = [];

nconds = size(substruct,1);  % Number of conditions specified
for i=1:nconds
 indexconds(i) = indexmatrix(substruct(i,1),substruct(i,2));    % Indices of the edges in indexmatrix    
end
 valconds = substruct(:,3);                                     % Values to be satisfied by the conditions
 
a = 1; 
for j=1:size(selected_runs,2)
    the_run = AllBigMatrices{selected_runs(j)} 
    for i=1:size(generations,2)        % Only generations specified in viewparams{3}
      one_gen = the_run(:,generations(i)); % Edges learned at that generation
      check_cond = sum(one_gen(indexconds)==valconds)==size(substruct,1); % Checking if all conditions are satisfied 
     
      if(check_cond==1)       
         AuxContactMatrix = ConvertFromIndex(indexmatrix,one_gen);
         switch display_type
    		 case 'one_graph',  AuxSumContactMatrix = AuxSumContactMatrix +  AuxContactMatrix;
             case 'all_graphs', ShowImage(pcolors,fs,AuxContactMatrix);
         end;
         results(a,:) = [j,generations(i)]; %These are the runs and generations corresponding to the structures.
         a = a + 1; 
      end
    end    
end  
  

  switch display_type
    case 'one_graph',  ShowImage(pcolors,fs,AuxSumContactMatrix);
  end;




