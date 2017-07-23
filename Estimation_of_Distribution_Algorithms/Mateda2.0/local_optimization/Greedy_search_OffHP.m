function[NewPop,NewFunVal,NumbEvals] =  Greedy_search_OffHP(k,Pop,FunVal,local_opt_params)
% [NewPop,NumbEvals] =  Greedy_search_OffHP(k,Pop,FunVal,local_opt_params)
% Greedy_search_OffHP: Greedy  local optimization method for the Off
% lattice HP model
% INPUT
% k: Current generation
% Pop: Population
% FunVal: Function values for each individual in the population
% trials:  = cell2num(local_opt_params{1}(1)) number of local optimization
%         moves for each solution
% OUTPUT:
% NewPop: Population after local search
% NewFunVal: Function values for the population optimized
% NumbEvals: Number of evaluations made during the local optimization step

trials = cell2num(local_opt_params{1}(1));

N = size(Pop,1);
NumbVar = size(Pop,2);
NumbEvals = 0;
for i=1:N
 BestX = Pop(i,:);
 BestV = FunVal(i,1);
 for j=1:trials,
    NewX = BestX;
    pos_a = fix(NumbVar*rand) + 1;
    pos_b = fix(NumbVar*rand) + 1;
    %inc_a  = pi*((fix(90*rand)+1)/90);
    %inc_b  = pi*((fix(90*rand)+1)/90);
    %NewX(pos_a) = BestX(pos_a) + (1 + 2*(fix(2*rand)-1))*inc_a;
    %NewX(pos_b) = BestX(pos_b) + (1 + 2*(fix(2*rand)-1))*inc_b;
    NewX(pos_a) = 2*pi*rand;
    NewX(pos_b) = 2*pi*rand;
    NewV = EvaluateOffHPProtein(NewX);
    %if(NewV >= BestV)
    if( (NewV - BestV) > -0.01)
      BestV = NewV;
      BestX = NewX;
      %[i,j,BestV]
    end
 end,
 %[i,FunVal(i,1),BestV]
 NewPop(i,:) = BestX;
 NewFunVal(i,1) = BestV;
 NumbEvals = NumbEvals + trials;
end,
RangeValues =  [zeros(1,NumbVar);2*pi*ones(1,NumbVar)];
[NewPop] =   Trigom_repairing(NewPop,RangeValues,{});



