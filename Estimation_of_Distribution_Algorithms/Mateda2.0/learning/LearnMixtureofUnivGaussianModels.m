function [model] = LearnMixtureofUnivGaussianModels(k,NumbVar,Card,AuxPop,AuxFunVal,learning_params)
% [model] =  LearnMixtureofUnivGaussianModels(k,NumbVar,Card,AuxPop,AuxFunVal,learning_params)
% LearnMixtureofUnivGaussianModels:     Learns a mixture of univariate Gaussian models using kmeans
% INPUTS
% k: Current generation
% NumbVar: Number of variables
% Card: Vector with the range of values for all the variables. 
% AuxPop:  Population from which the model is learned  
% AuxFunVal:   Evaluation of the data set (required for some learning algorithms, not for this one)
% learning_params{1}(1) = what_to_cluster: Information used to cluster the
%                         solutions: 'vars': information about variables values, 'objs': objective
%                         values, 'vars_and_objs': objectives and variables are clustered together
% learning_params{1}(2) = how_to_cluster: Method used to cluster the
% solutions, currently: 'ClusterPointsAffinity' and 'ClusterPointsKmeans'
% learning_params{1}(3) = nclusters: Number of clusters 
% learning_params{1}(4) = distance: Distance used for clustering (e.g.
%                         'euclidean', 'correlation', 'cosine' ... See help pdist for full list of
%                          possible metrics)
% learning_params{1}(5) = normalization: Whether the values of the variables
%                                    are normalized previous to clustering. This is done in order to avoid
%                                    that some variables have more weights in the clustering.
% OUTPUTS
% model: model{1,i} = mean of the variables for solutions in  cluster i
%        model{2,i} = stardard deviation of the variables for solutions in cluster i
%        model{3,i} = size(ind,1)/PopSize;    % Coefficient of component i
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)  
 
what_to_cluster = char(cellstr(learning_params{1}(1)));
how_to_cluster =  char(cellstr(learning_params{1}(2)));
nclusters = cell2num(learning_params{1}(3));
distance = char(cellstr(learning_params{1}(4)));
normalization = cell2num(learning_params{1}(5));

PopSize = size(AuxPop,1);

 switch what_to_cluster
            case 'vars', NormPop = AuxPop;
            case 'objs', NormPop = AuxFunVal; 
            case 'vars_and_objs',   NormPop = [AuxPop,AuxFunVal];
 end,        


if normalization==1
 for i=1:size(NormPop,2),
  NormPop(:,i) = normalize(NormPop(:,i));   % First values for all the variables are normalized         
 end
end


 [ind,nclusters] = eval([how_to_cluster,'(NormPop,distance,nclusters);']);
 
 
 for i=1:nclusters,   
   idx = find(ind==i);
   nmembers = size(idx,1);
   if nmembers>1
    model{1,i} =  mean(AuxPop(idx,:));   % Vector of means for each cluster
    model{2,i} =  std(AuxPop(idx,:));    % Vector of standard deviation for each cluster
    model{3,i} =  nmembers/PopSize;    % Coefficient for the mixture, proportional to the number of points in the cluster
   else
    model{1,i} =  mean(AuxPop);        % Vector of means for each cluster
    model{2,i} =  std(AuxPop);         % Vector of standard deviation for each cluster
    model{3,i} =  nmembers/PopSize;    % Coefficient for the mixture, proportional to the number of points in the cluster
   end
 end

 return;
       
       
       