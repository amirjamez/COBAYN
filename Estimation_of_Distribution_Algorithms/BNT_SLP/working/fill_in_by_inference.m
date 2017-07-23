function [data_mat, LLik, logP] = fill_in_by_inference(data, engine)
% [data_mat, LLik, logP] = fill_in_by_inference(data, engine)
%
% only for tabular nodes
%
% INPUTS :
%   data{i,l} - node i in case l
%   engine - inference engine
%
% OUPUTS :
%   data_mat(i,l) - complete data inferered
%   LLik - loglikelyhood of the imcomplete dataset data
%   logP - loglikelyhood of the complete dataset data_mat
%

[N, m] = size(data);
LLik = 1;

logP = 0;
bnet = bnet_from_engine(engine);
dag = bnet.dag;
ns = bnet.node_sizes;
CPT = CPT_from_bnet(bnet);

for l=1:m
  evidence=data(:,l);
  %  if MPE
  %    [mpe, ll] = calc_mpe_given_inf_engine(engine, evidence);
  %    ll = log(ll);
  %    data_mat(:,l)=mpe';
  %  else
  [engine, ll] = enter_evidence(engine, evidence);
  for i = 1:N
    if isempty(evidence{i})
      marg = marginal_nodes(engine,i); 
      %data_mat(i,l) = argmax(marg.T);
      alea = rand(1,1);
      inter = cumsum(marg.T);
      continu = 1; j = 1;
      while continu
	if alea <= inter(j), continu = 0; data_mat(i,l) = j; end
	j = j+1;
      end
    else
      data_mat(i,l) = evidence{i};
    end
  %    end
  end
  LLik = LLik + ll;
  logP = log(compute_prob(dag, ns, CPT, data_mat(:,l))) + logP;
end
