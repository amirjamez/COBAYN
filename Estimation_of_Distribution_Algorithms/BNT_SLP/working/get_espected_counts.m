function ess = get_espected_counts(data, engine0, engine1, dir)
% esc = get_espected_counts(data, bnet, dir)
%
% only for tabular nodes
%
% INPUTS :
%   data{i,l} - node i in case l and [] if missing
%   engine0 - the engine used for inference
%   engine1 - the engine for counts, according to its parents sets
%   dir - optionnal and ==1 to use uniform dirichlet prior (default 0)
%
% OUPUTS :
%   esc - esc{i} is the espected counts of the node i
%         respecting the syntaxe of CPTs for reading
%         use the function compute_prob to find the good index
%

if nargin<3, engine1=engine0; end
if nargin<4, dir = 0; end
[N, m] = size(data);

bnet = bnet_from_engine(engine1);
dag = bnet.dag;
ns = bnet.node_sizes;
CPT = CPT_from_bnet(bnet);
ess = CPT;
for i=1:N
  if dir, ess{i} = ones(size(ess{i}));
  else ess{i} = zeros(size(ess{i})); end
end

for l=1:m
  evidence=data(:,l); %evidence'
  miss = find(isemptycell(evidence))';
  if isempty(miss)
    [p, indice] = compute_prob(dag, ns, CPT, bnt_to_mat(evidence));
    for i = 1:N, ess{i}(indice(i)) = ess{i}(indice(i))+1; end
  else % if there are missing data
    sizes = ns(miss);
    [engine0, ll] = enter_evidence(engine0, evidence);
    for i=1:N
      if isempty(myintersect(i,miss))
        marg{i}.T = 1;
      else
        marg{i} = marginal_nodes(engine0,i);
      end
    end
      
    evidenc = bnt_to_mat(evidence);
    continu = 1;    
    cas = ones(size(miss));
    while continu
      evidenc(miss) = cas;
      [p, indice] = compute_prob(dag, ns, CPT, evidenc);     
      for i = 1:N
        proba = 1;
        for j = myunion(i,bnet.parents{i})
          if isemptycell(evidence(j))
            proba = proba * marg{j}.T(evidenc(j));
          end
        end
        if isemptycell(evidence(i))
          ess{i}(indice(i)) = ess{i}(indice(i)) + proba/prod(ns(setdiff(miss,union(i,bnet.parents{i}))));
        else
          ess{i}(indice(i)) = ess{i}(indice(i)) + proba/prod(ns(setdiff(miss,bnet.parents{i})));
        end
      end % for
      [cas, continu] = next_case(cas, sizes);
    end % while
  end % if  
end % for

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% vérifs
if 0
  sz_prior = zeros(1,N);
 for i=1:N
  CC = ess{i}; if dir, sz_prior(i) = prod(size(CC)); end
  while length(CC)>1, CC = sum(CC); end
  counts(i)=CC;
 end
 counts = round(counts*524288)/524288;
 CC = prod(counts==m*ones(1,N)+sz_prior);
 if CC==0, celldisp(ess), counts, disp('!!! Error !!! it does not seem to sum correctly !!!'),end
end
