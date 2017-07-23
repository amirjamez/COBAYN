%%% Amir: This will reformat the excution table and import it to Matlab 

% DSE exploration file
E=importdata('./data/cBench_onPandaboard_24app_5ds.csv', ',');  % execution time data collection file
datasets      = size(E.data,2) - 1;          % last column is code size
compilerFlags = size(E.textdata,2) - datasets - 2;    % last column is code size & first is app name
applications  = size(unique(E.textdata(2:size(E.textdata,1))),2);
experiments   = (size(E.textdata,1)-1)/applications;

appNames_flags = E.textdata(2:size(E.textdata,1),1);
txtFlags = E.textdata(2:size(E.textdata,1),2:(compilerFlags+1));
flagNames = E.textdata(1,2:(compilerFlags+1));
flags = ~(strcmp('X',txtFlags));
exTimes = E.data(:,1:datasets);


M=importdata('./data/ft_Milepost_cbench.csv', ',');  % software characterization file

if(~(size(M.data,1)==datasets*applications))
error('the app characterization database is not compliant with the exploration database');
end


micaMetrics = size(M.textdata,2)-2;% first two are appname and dataset.
micaNames = M.textdata(1,3:(micaMetrics+2));
micas = M.data; 

%%%AMIR
%Choose one from the 5 different methods Deafult is 1.

%1%
%AMIR% Normalizing by the first column
micasNorm = micas./repmat(micas(:,1),1,micaMetrics);

%2%
%AMIR% When we have them both as stat/dynamic-analyzer

%ONLY FOR cbench both
%micasNorm = [micas(:,1:45)./repmat(micas(:,1),1,45) micas(:,46:62)./repmat(micas(:,46),1,17)];

%ONLY FOR poly both
%micasNorm = [micas(:,1:16)./repmat(micas(:,1),1,16) micas(:,17:31)./repmat(micas(:,17),1,15)];



%3%
%AMIR% matlab normc function
%micasNorm = normc(micas);

%4%
%AMIR%
%normalizing the micas using (Xi- mean(column of Xi) )/ std(all_data)
%micasNorm = std2(micas)./bsxfun(@minus,micas,mean(micas,1));

%5$
%AMIR%
%normalizing the micas using (Xi- mean(column of Xi) )/ std(columns)
%micasNorm = bsxfun(@ldivide,bsxfun(@minus,micas,mean(micas,1)),(std(micas)));


i_m = 1;
i_e = 1;
for a = 1:applications
  appName = M.textdata(i_m+1,1);
  if(~strcmp(appName,appNames_flags(i_e)))
    error('appName differs from experiments to mica');
  end

  for d = 1:datasets
    bench(a,d).application  = appName;
    bench(a,d).dataset      = d;
    bench(a,d).mica(1,:)    = micas(i_m,:);
    bench(a,d).micaNorm(1,:)= micasNorm(i_m,:);
    bench(a,d).DB           = flags(i_e:(i_e+experiments-1),:);
    bench(a,d).Y            = exTimes(i_e:(i_e+experiments-1),d);
    
    i_m = i_m + 1;
  end
  i_e = i_e + experiments;
end


save data/initialData.mat bench micaMetrics experiments datasets applications
