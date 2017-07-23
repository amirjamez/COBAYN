problem = 0;

%  if exist('BNT_HOME','var')~=1
%      global BNT_HOME
%      BNT_HOME='../'; % please replace it by the correct path on your machine
%  end%if
%  if exist('SLP_HOME','var')~=1
%      global SLP_HOME
%      SLP_HOME='../bnt-slp/'; % please replace it as well
%  end%if
%  add_BNT_and_SLP

if problem==1 % letterD from bnt-slp/datas
    dataset = 'letterD';
    currentdir = pwd;
    cd([SLP_HOME 'datas']);
    eval(dataset)
    cd(currentdir);
elseif problem==0 % a simpler problem
    Napp = 50;
	Ntest = 20;
	sigma = 1;
	N = 5;
    nsmax = 6;
    N1 = (Napp+Ntest)/2;
    N2 = (Napp+Ntest)/2;
	x = [(randn(N1,1)+sigma)/2; (randn(N2,1)-sigma)/2];
    x = [x,  randn(N1+N2,N-2)];
    x = (x-repmat(min(x),N1+N2,1))./(repmat(max(x),N1+N2,1)-repmat(min(x),N1+N2,1));
    x = floor((nsmax-1)*x+1);
    y = [ones(N1,1); 2*ones(N2,1)];
    [xapp,yapp,xtest,ytest] = shufflemulticlass(x,y,Napp/(Napp+Ntest),[1 2],[N1 N2]);
    app = [xapp yapp]';
    test = [xtest ytest]';
    ns = [nsmax*ones(1,N-1) 2];
else
    error('problem unknown')
end%if

% optional - useful with draw_graph
names = cell(1,N);
for i=1:N-1
    names{i} = ['E' num2str(i)];
end%for
names{end} = 'C';

% the following lines are some tummy in order to put the class node as
% first node - perhaps useless
app = [app(end,:); app(1:end-1,:)];
test = [test(end,:); test(1:end-1,:)];
ns = [ns(end) ns(1:end-1)];
names = [names(end) names(1:end-1)];

dag = zeros(N,N);
dag(1,2:N) = ones(1,N-1); % naive Bayes classifier (class node at first)
%dag(N,1:N-1) = ones(1,N-1); % naive Bayes classifier (class node at last)

% you may wish to check the structure
%draw_graph(dag,names,ones(1,N));

discrete_nodes = [1:N];
bnet1 = mk_bnet(dag,ns,discrete_nodes);
for i=1:size(app,1)
    bnet1.CPD{i} = tabular_CPD(bnet1,i);
end%for

% evaluation criteria are computation time, log likelyhood and
% classification result
tic
bnet1 = learn_params(bnet1,app); % parameters initialization - ML naive Bayes classifier will be compared to ELR classifier
t1=toc

% scg: Scaled Conjugate Gradient
tic
bnet2 = learn_params_elr(bnet1,app,1,true,'batch','scg'); % main algorithm implemented according to [Gre04] - 'batch' is not used at that moment
t2=toc
% conjgrad: Conjugate Gradient
tic
bnet3 = learn_params_elr(bnet1,app,1,true,'batch','conjgrad',[],10); % to compare the two core algorithms
t3=toc

% evaluation of both classifiers with test data
engine1 = jtree_inf_engine(bnet1);
engine2 = jtree_inf_engine(bnet2);
engine3 = jtree_inf_engine(bnet3);
mlLL = 0;
elrLL_scg = 0;
elrLL_cg = 0;
for i=1:Ntest
    evidence = num2cell(test(:,i));
    [aux_engine,LL1] = enter_evidence(engine1,evidence);
    [aux_engine,LL2] = enter_evidence(engine2,evidence);
    [aux_engine,LL3] = enter_evidence(engine3,evidence);
    mlLL = mlLL + LL1;
    elrLL_scg = elrLL_scg + LL2;
    elrLL_cg = elrLL_cg + LL3;
end%for
mlLL = mlLL / Ntest
elrLL_scg = elrLL_scg / Ntest
elrLL_cg = elrLL_cg / Ntest

[ml_ratio,ml_ratiominus,ml_ratioplus] = classification_evaluation(bnet1,test,1);
ml_ratio
[elr_scg_ratio,elr_scg_ratiominus,elr_scg_ratioplus] = classification_evaluation(bnet2,test,1);
elr_scg_ratio
[elr_cg_ratio,elr_cg_ratiominus,elr_cg_ratioplus] = classification_evaluation(bnet3,test,1);
elr_cg_ratio

% [Gre04] Structural Extension to Logistic Regression: Discriminative
%  Parameter Learning of Belief Net Classifiers, Greiner, R., Zhou, W.,
%  Su, X., Shen, B., 2004