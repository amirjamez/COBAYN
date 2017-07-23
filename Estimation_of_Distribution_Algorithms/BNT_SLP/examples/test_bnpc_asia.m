clear all
close all
load asia2000
data=asiab;
clear asiab

node = struct('visit', 1, ...
    'smoking', 2, ...
    'tuberculosis', 3, ...
    'bronchitis', 5, ...
    'lung', 4, ...
    'ou', 6, ...
    'Xray', 7, ...
    'dyspnoea', 8);

asia = zeros(8);
asia([node.visit], node.tuberculosis) = 1;
asia([node.smoking], node.lung) = 1;
asia([node.lung node.tuberculosis], node.ou) = 1;
asia([node.ou], node.Xray) = 1;
asia([node.smoking], node.bronchitis) = 1;
asia([node.bronchitis node.ou], node.dyspnoea) = 1;

N=8;
node_sizes=2*ones(1,N);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% $$$ tic
% $$$ [G, L, score_mat] = phaseI(data,node_sizes);
% $$$ toc

% $$$ tic
% $$$ G2 = learn_struct_mwst(data,node_sizes);
% $$$ toc

names={ 'A' , 'S' , 'T' , 'L' , 'B' , 'O' , 'X' , 'D' };
[xx yy] = draw_graph(asia,names,ones(N,1));
title('Asia');

% $$$ figure
% $$$ draw_graph(G,names,ones(N,1),xx,yy);
% $$$ title('PhaseI');
% $$$ figure
% $$$ draw_graph(G2,names,ones(N,1),xx,yy);
% $$$ title('MWST');
% $$$ [diff_P1_MWST_I nb_diff_P1_MWST_J] =find(G~=G2);
% $$$ differences_Phase1_MWST = [diff_P1_MWST_I nb_diff_P1_MWST_J]'
% $$$ score = score_dags(data, node_sizes, {G G2});
% $$$ score_Phase_1=score(1)
% $$$ score_MWST=score(2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% $$$ epsilon=0.05;
% $$$ tic
% $$$ G2 = phaseII(G,data,node_sizes,epsilon,L, score_mat)
% $$$ toc
% $$$ figure
% $$$ draw_graph(G2,names,ones(N,1),xx,yy);
% $$$ title('PhaseII');
% $$$ score_Phase_2 = score_dags(data, node_sizes, {G2})

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% $$$ tic
% $$$ G3 = phaseIII(G2,data,node_sizes,epsilon,0)
% $$$ toc

profile clear
profile on
G3 = learn_struct_bnpc(data, node_sizes, 0.05, 0);
profile off
profile report report

score_Phase_3 = score_dags(data, node_sizes, {G3})
figure
draw_graph(G3,names,ones(N,1),xx,yy);
title('PhaseIII');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Report genered in :');
pwd

