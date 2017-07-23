% get the Most Likly Explanation.
% In reference to the Compiler Optimization, this is the most likely optimal compiler optimization configuration.

function MLE = getMLE(model, metrics )
myEng = enterEvidence(model, metrics);
% the model shall be generated such as in getModel.
%disp('enterEvidence done!')

% normalize metrics
cleanMetrics = (metrics - model.norm.mean) ./ model.norm.std;
cleanMetrics = cleanMetrics(:,model.norm.cleanMask);% cleanMetrics here must be a row vector.

% get principal components
pc = cleanMetrics * model.pca.coeff;% pc here must be a row vector.


evidence = cell(1,size(model.BN.dag,1));

for( i=1:size(model.BN.dag,1) )
  if(i<=model.pca.length)
    evidence{i} = pc(i);
  else
    evidence{i} = [];
  end
end


MLE = find_mpe(myEng,evidence);
%disp('find_mpe done!')
