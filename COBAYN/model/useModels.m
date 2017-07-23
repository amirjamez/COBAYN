%%% Amir: 
% This function uses the bench(a,d),micaNorm and look into the evince
% of LOO (other benchs) to come up with the MLE os certain prediction
% samples = 128 to generate the whole prediction table one

function [predTable]= useModels(samples, bench, BNmodel_loo)

clear predTable
samples = 128;
index = 1;
for a=1:size(bench,1)
  %fprintf('Predicting flags for application %d',a);
  for d=1:size(bench,2)
     % fprintf('Predicting flags for application %d - dataset %d',a,d);
    %bestGuess = getMLE(BNmodel_loo(a), bench(a,d).micaNorm );  % This has
    %been commented to be able to predict the full table, not the best (MLE)
    allGuesses = sampleModel(BNmodel_loo(a), bench(a,d).micaNorm, samples);

    
    %predTable(index,:) = bestGuess((BNmodel_loo(a).pca.length+1):end);
    predTable((index):(index+samples-1),:) = allGuesses(:,(BNmodel_loo(a).pca.length+1):end);
    
    dataSetId(index:(index+samples-1)) = d;
    appNames(index:(index+samples-1)) = bench(a,d).application;
    
    index = index+samples;
  end
end


myM=[dataSetId' (predTable-1)];
%for (i=1:size(myMM))%AMIR!!!
 %   myMM
  %  myMM(i)=str2double(myM{i})
%end
%for(a=1:size(myM,1)) %AMIR!!!
 %   a
  %  for(cf=2:size(myM,2))
   %     cf
    %    if(myMM(a,cf)==1)
     %       myMM(a,cf)=flagNames(cf)
      %  end
    %end
%end
        
toWrite = cell(size(myM) + [0 1] );
toWrite(:,1) = appNames;
c= num2cell(myM);
toWrite(:,2:end) = c;
%cell2csv('predictions.csv',toWrite);

%%%AMIR! I am fixing the predTable here!
predTable=predTable-1;


