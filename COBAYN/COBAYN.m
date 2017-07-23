%%% AMIR July 2017
% COBAYN Workflow

%% Initialize The Paths
initMatEnv;
disp('(PHASE-1) All Paths set')

%% Import The datasets
take_db;
disp('(PHASE-2) Data has been imported')

%% Train COBAYN
generateModels;
disp('(PHASE-3) COBAYN has been trained')

%% Inference Phase --> COBAYN's Predictions
predictionTableGenerator;
disp('(PHASE-4) COBAYN has finished the prediction process. See it by writing COBAYN')