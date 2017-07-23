function [cpdag, best_score, cache] = learn_struct_ges_new(data, nodesizes, varargin)
%
% LEARN_STRUCT_GES learns a structure of Bayesian net by Greedy Equivalence Search.
% cpdag = learn_struct_ges(Data, Nodesizes, 'cache', cache, 'scoring_fn', 'bic', 'verbose', 'yes')
%
% cpdag: the final cpdag
% Data : training data, data(i,m) is the m obsevation of node i
% Nodesizes: the size array of different nodes
% cache : data structure used to memorize local score computations
%   (cf. SCORE_INIT_CACHE function)
%
% V1.1 : 28 july 2003 (Ph. Leray)
%
% Ref:
%   Optimal Structure Identification with Greedy Search, Chickering 2002
%

[N ncases] = size(data);
seeddag = zeros(N,N);

% set default params
scoring_fn = 'bayesian';
verbose  = 0;
cache=[];
    
% get params
args = varargin;
nargs = length(args);
if length(args) > 0
    if isstr(args{1})
        for i = 1:2:nargs
            switch args{i}
            case 'scoring_fn', scoring_fn = args{i+1};
            case 'verbose',  verbose  = strcmp(args{i+1},'yes');
            case 'cache',  cache=args{i+1} ;
            end;
        end;
    end;
end;

if verbose
    names=cellstr(int2str((1:N)'));
    carre=zeros(N,1);
end

done = 0;
%[best_score cache] = score_dags(data,nodesizes, {seeddag},'scoring_fn',scoring_fn,'cache',cache);
best_score = -Inf;
cptt=0;
dag = seeddag;

% First step : INSERT
while ~done
    cptt=cptt+1; %seeddag, A=pdag_to_dag(seeddag), 
    [pdags,nodes] = mk_nbrs_of_pdag_add_limited(seeddag);
    seedold=seeddag;
    sold=best_score;
    nbrs = length(pdags);
    dags=pdag_to_dag(pdags);
    [scores cache] = score_dags(data, nodesizes, dags,'scoring_fn',scoring_fn,'cache',cache);
    %max_score = max(scores);
    %new = find(scores == max_score );
    
    [max_scores, news] = sort(scores);
    newl=length(news);
    new=news(newl); 
    pdag = pdags{new};
    while ~isdag(dags{new}) %isempty(dags{new})
      newl=newl-1; disp('This pdag does not admit any extension --> continu with another one.')
      new=news(newl);
      pdag = pdags{new};
    end
    max_score = max_scores(newl);
    dag = dags{new};
    
    if ~isempty(new) 
      p = sample_discrete(normalise(ones(1, length(new))));
      dag = dags{new(p)}; 
           
      notlinked = 0;
      for i=1:N, par=find(dag(:,i)==1); son=find(dag(i,:)==1); notlinked=notlinked+ ((length(par)+length(son))==0); end
      tooempty = notlinked>0; %ceil(N/8);
      
      if tooempty | (max_score > best_score)
        %if (max_score <= best_score), fprintf('too empty graph --> continu'); end

        fprintf(' +> score = %8.4f ', max_score);
        best_score = max_score; %dag
        seeddag = dag_to_cpdag(dag);
        if isempty(pdag_to_dag(seeddag)), warning('This network is not consistant --> loosing optimality'); seeddag = cpdag_to_dag(seeddag); end
        new=new(p); 
        if verbose
            figure;
            subplot(1,2,1), [xx yy]=draw_graph(seedold,names,carre);  
            set(gca,'color',[1 1 0]); 
            title(sprintf('current CPDAG (Smax=%5.2f)',sold));
            subplot(1,2,2), draw_graph(seeddag,names,carre,xx,yy);     
            s=sprintf(' %d',nodes{new,3});
            title([sprintf('Best in N+ = INSERT(%d, %d,',nodes{new,1},nodes{new,2}) s ')' sprintf('  S=%5.2f',max_score)]);
            drawnow;
        end
      else
        done = 1;
      end     
    else
      error('Non instantiable structure !!!')
    end;
end;

done = 0;
cptt=0;
[best_score cache] = score_dags(data, nodesizes, {dag},'scoring_fn',scoring_fn,'cache',cache);
%dag,
%best_score, 

% Second step : DELETE
while ~done
    cptt=cptt+1; %seeddag, A=pdag_to_dag(seeddag), 
    [pdags,nodes] = mk_nbrs_of_pdag_del(dag);
    seedold=seeddag; sold=best_score;
    nbrs = length(pdags);
    dags=pdag_to_dag(pdags);
    [scores cache] = score_dags(data, nodesizes, dags,'scoring_fn',scoring_fn,'cache',cache);
    max_score = max(scores);
    new = find(scores == max_score );
    if ~isempty(new) & (max_score > best_score)
        p = sample_discrete(normalise(ones(1, length(new))));
        best_score = max_score;
        dag = dags{new(p)};
        seeddag = dag_to_cpdag(dag);
        fprintf(' -> score = %8.4f ', max_score);
        new=new(p);
        if verbose
            cpdags=dag_to_cpdag(dags);
            figure;
            subplot(1,2,1), [xx yy]=draw_graph(seedold,names,carre);  
            set(gca,'color',[1 1 0]); 
            title(sprintf('current CPDAG (Smax=%5.2f)',best_score));
            subplot(1,2,2), draw_graph(seeddag,names,carre,xx,yy);     
            s=sprintf('%d',nodes{new,3});
            title([sprintf('Best in N- = DELETE(%d, %d,',nodes{new,1},nodes{new,2}) s ')' sprintf('  S=%5.2f',max_score)]);
            drawnow;
        end
        
    else
        done = 1;
        %[best_score cache] = score_dags(data, nodesizes, {dag},'scoring_fn',scoring_fn,'cache',cache);
        %dag,
        %best_score, 
        cpdag = dag_to_cpdag(dag);
    end;
end;
%cpdag = dag_to_cpdag(dag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function G2 = pdag_to_dag(pdags)
% same as pdag_to_dag without warnings
if ~iscell(pdags)
    pdag=cell(1,1);
    pdag{1}=pdags;
else
    pdag=pdags;
end
for da=1:length(pdag)
    %fprintf('%d ',da)
    G=pdag{da};     
    G2 = G; A = G;
    N = size(G,1);
    empty_loop = 0;
    while ~isempty(find(A))
        [x x_y_undirected] = select_vertex(A);
        if x==0, G2=[]; break, end,
        G2(x,x_y_undirected) = 0; G2(x_y_undirected,x) = 1;
        A(x,:) = 0; A(:,x) = 0;
    end
    dags{da}=G2;
end
if ~iscell(pdags)
    G2=dags{1};
else
    G2=dags;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [sol, x_y] = select_vertex(G)
N = size(G,1);
sol = 0;
x = 0;
fini=0 ;
while ~fini
    x = x+1;
    if x>N
        fini=1;
    else
        beforex=find(G(:,x));
        afterx=find(G(x,:));
        if ~(isempty(beforex)&isempty(afterx))
            x_y = myintersect(beforex,afterx);
            beforex=mysetdiff(beforex,x_y);
            afterx=mysetdiff(afterx,x_y);
            
            if isempty(afterx) % x is a sink
                Ax=  myunion(x_y,beforex);
                for y=x_y
                    % Adjacents of y
                    Ay = myunion(find(G(:,y)), find(G(y,:)));
                    Ay = myunion(Ay,y);
                    if isempty(setdiff(Ax,Ay))
                        fini=fini+1; 
                    else
                        break;
                    end                    
                end
                if fini==length(x_y) %fini==size(x_y)
                    sol=x; fini=1;
                else
                    fini=0;
                end
            end
        end
    end
end % while


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function b = isdag(G)
b = sum(sum(G.*G'));        % How many undirected arcs ? (x2)
b=~b & ~isempty(G);
if b
  M = expm(full(G)) - eye(length(G)); M = (M>0);
  b = b & find(sum(sum(eye(length(G)).*M))); % is there no cycle ?
end

