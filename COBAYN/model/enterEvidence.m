% Enter the metric evidence (i.e. the knowledge of MICA).
% Preprocess the MICA by normalizing and get the principal component.
% enter_evidence in the Bayesian Network model.
% return the new Bayesian Network where knowledge has been integrated.

function [engine ] = enterEvidence(model, metrics)
% the model shall be generated such as in getModel.

% normalize metrics
cleanMetrics = (metrics - model.norm.mean) ./ model.norm.std;
cleanMetrics = cleanMetrics(:,model.norm.cleanMask);% cleanMetrics here must be a row vector.

% get principal components
pc = cleanMetrics * model.pca.coeff;% pc here must be a row vector.


evidence = cell(1,size(model.BN.dag,1));

for(i=1:size(model.BN.dag,1) )
  if(i<=model.pca.length)
    evidence{i} = pc(i);
  else
    evidence{i} = [];
  end
end

[engine ] = enter_evidence(jtree_inf_engine(model.BN.bnet),evidence);
%disp('enter_evidence done!')
