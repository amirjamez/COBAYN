%%%AMIR
% This script will infer the BN for all applications
%
% Also it sorts out the full table per application-dataset -> 
% COBAYN(a,d).predictions
% 
iteration=[];

% Generates the complete prediction vector of (2^7 = 128) 
% a bit slow but need to do it once and use it later 
% on the comparison. i.e.: Top-N will be the first N rows
samples=128;

% Generates the predictions
[predTable]= useModels(samples, bench, BNmodel_loo);

% Sort out the prediction table into the different applications and save
% them to COBAYN structure
        pp=1;
        samples=128;
        for a=1:size(bench,1)
            for d=1:size(bench,2)
                for s=1:samples
                        COBAYN(a,d).predictions(s,:)=predTable(pp,:);
                    pp=pp+1;
                end
            end
        end
    
% Finally it saves the predictions        
save data/COBAYN_predictions.mat COBAYN
