%%% Amir: This will setup the paths

% Amir
%start the parallel pool if possible
%Comment this out if failed and change all the parfor instances to for
parpool
%This has conflict with native assert.m, run this first


addpath('../Estimation_of_Distribution_Algorithms');
setupMatlabEnv_EDA; % note that this adds the Bayesian Network toolboxes as well as MATEDA (Estimation of Distribution Algorithms).



addpath('./dataProcessing/');
addpath('./model/');
addpath('./utils/');

% use learn_struct_PC passing constraints not to let primary variables be children of anybody. (page 31, gr03.pdf)
addpath('../Estimation_of_Distribution_Algorithms/');

