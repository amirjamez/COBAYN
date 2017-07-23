function[results] = ViewInGenStruct(run_structures,viewparams)
% [results] = ViewInGenStruct(run_structures,viewparams)
% ViewInGenStruct:      Shows images where each edge has a color
%                       proportional (relative to nruns)  to the times it has been present in the structures
%                       learned in those generations included in viewparams{2}.
%                       There is one figure for each generation.
% INPUT
% run_structures: Contain the data structures with all the structures
% learned by the probability models in every run and generation (see
% program ReadStructures.m for details.
% viewparams{1} = [pcolors,fs]; % pcolors: range of colors for the  images. fs: Font size for the images                       
% viewparams{2} : Vector with the generations to inspect. For showing all the generations, set viewparams{2}=[1:ngen]. 
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)


results = [];



AllContactMatrix = run_structures{4};

pcolors = viewparams{1}(1); % Range of  colors
fs = viewparams{1}(2);      % Fontsize for the figures


for j = 1:size(viewparams{2},2)    
  i = viewparams{2}(j); % Generation to view the sum of structures
  ShowImage(pcolors,fs,AllContactMatrix{i});
end,