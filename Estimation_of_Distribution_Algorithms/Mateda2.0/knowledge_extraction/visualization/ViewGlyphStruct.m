function[results] = ViewGlyphStruct(run_structures,viewparams)
% [results] = ViewGlyphStruct(run_structures,viewparams)
%                       
% 'ViewGlyphStruct'    :Shows the glyph representation of a subset of edges learned
%                       at a given set of runs and generations
%
% INPUT
% run_structures: Contain the data structures with all the structures
% learned by the probability models in every run and generation (see
% program ReadStructures.m for details.
% viewparams{1} = fs; % fs: Font size for the images
% viewparams{2}:  List of edges, one row for each edge
% viewparams{3}:  % Vector with the selected runs  that will be inspected
% viewparams{4};  % Vector of the selected generations  that will be inspected
% OUTPUT
% results{1}: Matrix containing one vector for each of the substructures
% shown with the glyphs
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)

 

indexmatrix = run_structures{1};
AllBigMatrices = run_structures{2};

fs = viewparams{1};      % Fontsize for the figures

substruct = viewparams{2};
selected_runs = viewparams{3};
generations = viewparams{4};


n = size(indexmatrix,1);
AuxSumContactMatrix = zeros(n,n);
results  = [];

nconds = size(substruct,1);  % Number of edges
for i=1:nconds
 indexconds(i) = indexmatrix(substruct(i,1),substruct(i,2));    % Indices of the edges in indexmatrix    
end

VectorGlyphs = [];
for j=1:size(selected_runs,2)
    the_run = AllBigMatrices{selected_runs(j)};  
    for i=1:size(generations,2)            % Only generations specified in viewparams{3}
      one_gen = the_run(:,generations(i)); % Edges learned at that generation
      VectorGlyphs = [VectorGlyphs;one_gen(indexconds)'];
    end
end
  
figure  
axes('Fontsize',fs);
glyphplot(VectorGlyphs,'Grid',[size(selected_runs,2),size(generations,2)],'ObsLabels','')

results{1} = VectorGlyphs;






