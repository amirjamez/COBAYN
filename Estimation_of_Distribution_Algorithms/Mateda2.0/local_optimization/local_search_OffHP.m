function[NewPop,NewFunVal,NumbEvals] =  local_search_OffHP(k,Pop,FunVal,local_opt_params)
% [NewPop,NumbEvals] =  local_search_OffHP(k,Pop,FunVal,local_opt_params)
% local_search_OffHP: Interface between Matlab local optimization methods  
%                     and the for the Off lattice HP model (Can be
%                     generalized to other functions)
% 
% INPUT
% k: Current generation
% Pop: Population
% FunVal: Function values for each individual in the population
% OUTPUT:
% NewPop: Population after local search
% NewFunVal: Function values for the population optimized
% NumbEvals: Number of evaluations made during the local optimization step

options = optimset('MaxFunEvals',20000);
options = optimset(options,'Display','off');
options = optimset(options,'MaxIter',10000);
options = optimset(options,'LargeScale','off');
options = optimset(options,'Diagnostics','off');
options = optimset(options,'HessUpdate','steepdesc'); % 'dfp','bfgs'

N = size(Pop,1);
NumbVar = size(Pop,2);
NumbEvals = 0;
for i=1:N
 aux = FunVal(i,1);
 X = Pop(i,:);
 [NewPop(i,:),val,EXITFLAG,OUTPUT]=fminunc(@(X) -1*EvaluateOffHPProtein(X),X,options);
 NewFunVal(i,1) = -1*val;
 %[aux,NewFunVal(i,1)]
 NumbEvals = NumbEvals + OUTPUT.funcCount;
end,

RangeValues =  [zeros(1,NumbVar);2*pi*ones(1,NumbVar)];
[NewPop] =   Trigom_repairing(NewPop,RangeValues,{});