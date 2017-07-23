% Enter the metric evidence (i.e. the knowledge of MICA).
% Preprocess the MICA by normalizing and get the principal component.
% 
% Sample the bayesian network given the evidence.

function sample = sampleModel(model, metrics,nsamples)
% get the MLE point
sam_=getMLE(model, metrics);
%disp('getMLE done!')
sample(1,:) = cat(1,sam_{:})';

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

%disp('evidence assignment done!')

s=1;
while s<nsamples
    
  csample = sample_bnet(model.BN.bnet,'evidence',evidence);
  %disp('sample_bnet done!')
  sam(1,:) = cat(1,csample{:})';
  
  if(~ismember(sam,sample,'rows'))
    sample(s+1,:) = sam;
    s = s+1;
  end
end
%disp('sample assignent done!')

