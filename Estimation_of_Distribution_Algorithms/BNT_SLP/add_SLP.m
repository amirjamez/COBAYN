% Give here the folder where you have uncompressed the Structure Learning Package for BNT
% Amir: change this path according:

SLP_HOME = '~/COBAYN/Estimation_of_Distribution_Algorithms/BNT_SLP';

folders = {'learning','scoring','misc','examples','datas','working','working/modded_LinkStrength','working/elr','working/score_dag.c'};
addpath(SLP_HOME)
for f=1:length(folders)
  addpath(fullfile(SLP_HOME, folders{f}))
end
clear SLP_HOME f folders
