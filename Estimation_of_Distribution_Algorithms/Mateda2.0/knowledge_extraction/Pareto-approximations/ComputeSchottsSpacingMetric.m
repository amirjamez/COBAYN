function[Val] = ComputeSchottsSpacingMetric(Pop) 
% [Val] = ComputeSchottsSpacingMetric(Pop) 
% ComputeSchottsSpacingMetric: Computes the Schotts Spacing Metric for a
% Pareto set approximation
% INPUTS
% Pop: Each row corresponds to a vector
% OUTPUTS
% Val: Average square difference between pairs of vectors
%
% Last version 2/26/2009. Roberto Santana (roberto.santana@ehu.es)

 Val = 0;
 [PopSize,n] = size(Pop);
 di = n*max(max(Pop))*ones(1,PopSize);
 npairs = PopSize*(PopSize-1)/2;
 for i=1:PopSize,
  for j=1:PopSize,
    if i~=j
      di(i) = min(di(i),sum(abs(Pop(i,:)-Pop(j,:))));
    end
  end
 end
 d = mean(di);
 
 Val = sqrt((1/(PopSize-1))*sum( (di-d).^2));
 
 