%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load data/initialData.mat

% Amir
% This will force the model to use only the best X configurations for 
% training the model. Check this umber as it fits.
bestPerBenchmark = 25;

% this function EXCLUDE the application a from the training set and return
% the rest of the training set (good for leave-one-out cross-validation)
[bestSet ExT ] = getBestSet(bench, bestPerBenchmark);  


BNmodel = getModel(bestSet,micaMetrics);
disp('Populating BNmodel using selected bestPerApplication is finished!')
disp('Now, generating the cross-validation models for each application.')

%%AMIR
% Here we start the parallel session, if failed
% switch back to for

parfor(a=1:size(bench,1)) 
  [bestSet ExT ] = getBestSet(bench, bestPerBenchmark,a); %it will fetch the bestset having left-out application a
  BNmodel_loo(a) = getModel(bestSet,micaMetrics);
  fprintf('Application %d is trained!\n',a);
end
disp('BN validated with leave-one-out')

save ./data/models.mat BNmodel_loo BNmodel
