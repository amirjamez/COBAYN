function [bnet,LCL] = learn_params_elr(bnet,data,cnode,bnet_initialized,mode,gradfunc,thres,max_iter)

% LEARN_PARAMS_ELR Estimates params of a BN classifier for a fully observed model.
% bnet = learn_params_elr(bnet,data,cnode,bnet_initialized,mode,gradfunc,thres,max_iter)
%
% Performs parameters learning of a bayesian belief net classifier through
%  Extended Logistic Regression [Gre04].
% bnet is the bayesian belief net structure (in an programing sense).
% data is an [d n] array, with n examples and d variables.
% cnode is the decision node (default is last).
% Optional arguments max_iter and thresh are related to the gradient 
%  descent algorithm which can be 'scg' or 'conjgrad' (gradfunc).
% Possible values for mode are 'batch' (default) and 'inline' (warning: 
%  only 'batch' is available at the moment).
%
% [Gre04] Structural Extension to Logistic Regression: Discriminative
%  Parameter Learning of Belief Net Classifiers, Greiner, R., Zhou, W.,
%  Su, X., Shen, B., 2004

if nargin<2
    error('too few input arguments')
end%if

[d,n] = size(data);
epsilon = 1e-6;

if nargin<8 || length(max_iter)==0
    max_iter = 1e2;
end%if
if nargin<7 || length(thres)==0
    thres = 1e-4;
end%if
if nargin<6 || length(gradfunc)==0
    gradfunc = 'scg';
end%if
if nargin<5 || length(mode)==0
    mode = 'batch';
end%if
if nargin<4 || length(bnet_initialized)==0
    bnet_initialized = false;
end%if
if nargin<3 || length(cnode)==0
    cnode = d;
end%if

options = zeros(18,1);
%options(1) = 1; % display error values
options(2) = thres; % absolute precision required for the value of X at the solution
options(3) = thres; % precision required of the objective function at the solution
%options(9) = 1; % check the user defined gradient function
options(14) = max_iter; % maximum number of iterations
options(15) = thres; % precision of the line search in parameter space (conjgrad)

enodes = [1:cnode-1 cnode+1:d];

if ~bnet_initialized
    for i=1:d
        bnet.CPD{i} = tabular_CPD(bnet,i);
    end%for
    bnet = learn_params(bnet,data); % parameters initialization
end%if
theta = bnet_unpak(bnet);

ind = find(theta<epsilon); % prevent logarithms of 0
theta(ind) = epsilon * ones(length(ind),1);
beta = log(theta)'; % softmax parameters initialization
% conjgrad or scg need that grad_global_nLCL returns a row vector, therefore
% beta must be a row vector as well.

data = data';
% the following two values are computed because of linesearch
%nLCL = global_nLCL([],bnet,data,cnode,enodes); % global log conditional likelyhood initialization
%gGrad = grad_global_nLCL([],bnet,data,cnode,enodes);

% an error in linemin help postponed the end of learn_params_elr
% development. the first output argument was described has the optimal
% value of the parameters (beta*).

% line search step
%[alpha,options] = linemin('global_nLCL',beta,gGrad,nLCL,options,bnet,data,cnode,enodes);
%nLCL = options(8); % retrieve optimal value of the function
%beta = beta + alpha * gGrad;

% the heavy task : gradient descent to find optimal softmax parameter
% values
[beta,options,flog,ptlog] = feval(gradfunc,'global_nLCL',beta,options,'grad_global_nLCL',bnet,data,cnode,enodes);

theta = beta2theta(bnet,beta');
bnet = bnet_pak(bnet,theta);

nLCL = flog(end);

end%function