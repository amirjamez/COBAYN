% Generate Bayesian network model to correlate a set of metrics with a set of optimizaiton flags.
% First remove all the metrics that are not correlated to any optimization flags.
% Then generate Bayesian Network using the BNT software.
% Store in the model the mask to hide the removed metrics.

function micaBNmodel = getModel(bestSet,metrics)

%metrics=micaMetrics;
bestPerBenchmark = 25; %just to be on the safeside

metricMatrix = bestSet(1:bestPerBenchmark:end,1:metrics); %returns best MICA for those bestSets, noREP for PCA
flagMatrix = bestSet(:,metrics+1 : size(bestSet,2)); %returns the best compilerflags 
flags = size(flagMatrix,2);  %the sumber of the compiler flags

%corrThreshold = 0.2;
%mask = ones(1,metrics);
%mask = mask & (max(metricMatrix) ~= min(metricMatrix));

%% correlation is not fine since flags are binary (categorical and non continuous).
% metricCorr = corr(metricMatrix,flags);
% metricThreshold = abs(metricCorr) > corrThreshold;
%%

%% Let me use the krukalwallis test instead.
%% Reject the null hypothesis if the pvalue is less than 0.05
%% the null hypothesis is that the groups have the same rank (i.e. the fact than X < Y is not systematic)
%% e se per ogni benchmark prendessi solo la mediana dato che ho solo una micaMetrics? Altrimenti passano sempre tutti ;(
%pvalues = ones(flags,metrics);
%for m = 1:metrics
%  if mask(m)==1
%    for f = 1:flags
%      pvalues(f,m) = kruskalwallis(metricMatrix(:,m), flagMatrix(:,f), 'off' );
%    end
%  end
%end
%mask = mask & (min(pvalues) < 0.05)
%micaBNmodel = pvalues
%%

%1st standardize the metrics
%2nd apply PCA
%3rd build the dag
%4th get probabilities

                                                                                                                         
%1st standardize the mica matrix
meanMetric = mean(metricMatrix);  
stdMetric = std(metricMatrix);

cleanMetricMatrix = (metricMatrix-repmat(meanMetric,size(metricMatrix,1),1)) ./ repmat(stdMetric,size(metricMatrix,1),1);
cleanMask = ~any(isnan(cleanMetricMatrix));
cleanMetricMatrix = cleanMetricMatrix(:,cleanMask); %this is the final standardized version of MICA


%2nd PCA OR Factor Analysis
%PCA
  PCAlength = 5;
 [pcaCoeff, pcaData] = pcaFromStatToolbox(cleanMetricMatrix);% for verification, cleanMetricMatrix * pcaCoeff -> pcaData.
 trainData = [repmat(pcaData(:,1:PCAlength),bestPerBenchmark,1) flagMatrix+1]'; %the dataset we start training on

%FA Factor Analysis (to be conformed, I rename the FA variabe to PCA)
%%Original_Names
%%FAlength = 4; %change this for having m factors
%%[lambda,psi,T,stats,F] = factoran(cleanMetricMatrix,FAlenght);
%%trainData = [pcaData(:,1:PCAlength) flagMatrix+1]';

%renamed version USE THIS VERSION
%PCAlength = 3; %change this for having m factors (ONLY WORKS FOR 4 and the specific statset)
%[pcaCoeff,psi,T1,stats,pcaData] = factoran(cleanMetricMatrix,PCAlength,'optimopts',statset('TolX',1e-4,'TolFun',1e-2));
%[pcaCoeff,psi,T1,stats,pcaData] = factoran(cleanMetricMatrix,PCAlength);
%ONLY FOR poly_MICA !!!solved!!! no need for this
%[pcaCoeff,psi,T1,stats,pcaData] = factoran(cleanMetricMatrix(:,[1:27 35:end]),5,'optimopts',statset('TolX',1e-4,'TolFun',1e-4));
%trainData = [repmat(pcaData(:,1:PCAlength),bestPerBenchmark,1) flagMatrix+1]';



%3rd Build dag (directed A. gragh--> BN)
Card = ones(1,PCAlength+flags);
Card(PCAlength+(1:flags)) = 2;
%[sampled_graphs, accept_ratio, n_edges] = learn_struct_mcmc(trainData, Card, ...
%                                    'discrete', [PCAlength+(1:flags)]);
discrete = PCAlength+(1:flags);
types = cell(1,PCAlength+flags); 

for i=1:(PCAlength+metrics) ;
    if(i<=PCAlength);
        types{i} = 'gaussian';
    else types{i} = 'tabular';
    end 
end
dag = full(learn_struct_mwst(trainData,discrete,Card,types,'bic',1));
order = topological_sort(dag);
dag =  learn_struct_K2(trainData, Card, order, 'discrete', discrete);
score = score_dags(trainData,Card,{dag},'discrete',discrete);
%dag = learn_struct_K2(trainData, Card, 1:(PCAlength+metrics), ...
%                                    'discrete', discrete);


%4th build bayesian network
init_bnet = mk_bnet(dag,Card,'discrete',discrete,'observed',1:PCAlength);
for i=1:(PCAlength+flags);
  if(i<=PCAlength);
      init_bnet.CPD{i} = gaussian_CPD(init_bnet,i);
  else if(~isempty(parents(init_bnet.dag,i)) );
              init_bnet.CPD{i} = softmax_CPD(init_bnet,i);% FIXME!!! 
      else
          init_bnet.CPD{i} = tabular_CPD(init_bnet,i);% FIXME!!!
      end
  init_bnet.CPD{i} = softmax_CPD(init_bnet,i);% FIXME!!! %tabular_CPD(init_bnet,i);% FIXME!!!
  end 
end
bnet = learn_params(init_bnet,trainData);
%engine = jtree_inf_engine(bnet);


% return the model
micaBNmodel.norm.mean = meanMetric;
micaBNmodel.norm.std = stdMetric;
micaBNmodel.norm.cleanMask = cleanMask;

micaBNmodel.pca.length = PCAlength;
micaBNmodel.pca.coeff = pcaCoeff;

%%%AMIR
%to be able to compare with GCO2006, we need to keep every PCA per application/ds 
micaBNmodel.pca.pcaData = pcaData;
% micaBNmodel.pca.selected_pcaData=pcaData(:,1:PCAlength);
% ppp=1;
% for a=1:size(bench,1)
%     for d=1:size(bench,2)
%         pcaDataPerApp(a,d).pc=micaBNmodel.pca.selected_pcaData(ppp,:);
%         ppp=ppp+1;
%     end
% end
%considering the first dataset for now
% line=1;
% for a=1:size(bench,1)
%         distanceMatrix=[distanceMatrix; pcaDataPerApp(a,1).pc ];
%         line=line+1;
% end
%
micaBNmodel.trainData.trainData = trainData;
micaBNmodel.trainData.bestSet = bestSet;
micaBNmodel.trainData.metrics = metrics;

micaBNmodel.BN.dag = dag;
micaBNmodel.BN.score = score;
micaBNmodel.BN.bnet = bnet;
%micaBNmodel.BN.engine = engine;

