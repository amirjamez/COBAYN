function[results] = ViewSummStruct(run_structures,viewparams)
% [results] = ViewSummStruct(run_structures,viewparams)
% ViewSummStruct:       Shows one image where each edge has a color proportional 
%                       to the times it has been present in the structures learned in all generations.
%
% INPUT
% run_structures: Contain the data structures with all the structures
% learned by the probability models in every run and generation (see
% program ReadStructures.m for details.
% viewparams{1} = [pcolors,fs]; % pcolors: range of colors for the  images. fs: Font size for the images                       
% OUTPUT:
% results = [];
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)
results = [];
SumAllContactMatrix = run_structures{5};
pcolors = viewparams{1}(1);                % Range of  colors
fs = viewparams{1}(2);                     % Fontsize for the figures
ShowImage(pcolors,fs,SumAllContactMatrix);