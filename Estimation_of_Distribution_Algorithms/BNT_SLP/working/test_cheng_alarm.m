clear all
close all
load -ascii alarm5000.mat
load -ascii alarmdag.mat
data=alarm;
clear alarm

names={'1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37'};
N=length(alarmdag);
carre=zeros(1,N);
whos

node_sizes = [2 2 2 3 3 3 3 2 3 2 2 3 4 4 4 4 3 2 2 3 2 2 3 2 3 2 3 3 2 3 3 4 4 3 4 3 3];
epsilon = 0.05;

data=data(:,1:1000);

%if 1
  %tic
  %MWST = learn_struct_mwst(data,node_sizes);
  %toc
  profile clear
  profile on
  [ Phase_3 Phase_2 Phase_1 ] = learn_struct_bnpc(data, node_sizes, epsilon, 1);
  Phase_3
  profile off
  profile report report_alarm
  
% $$$ else 
% $$$ 
% $$$ tic
% $$$ [Phase_1, L, score_mat] = phaseI(data,node_sizes);
% $$$ toc
% $$$ tic
% $$$ MWST = learn_struct_mwst(data,node_sizes);
% $$$ toc
% $$$ [diff_P1_MWST_I nb_diff_P1_MWST_J] =find(Phase_1~=MWST);
% $$$ differences_Phase1_MWST = [diff_P1_MWST_I nb_diff_P1_MWST_J]'
% $$$ score = score_dags(data, node_sizes, {Phase_1 MWST});
% $$$ score_Phase_1=score(1)
% $$$ score_MWST=score(2)
% $$$ 
% $$$ tic
% $$$ Phase_2 = phaseII(Phase_1,data,node_sizes,epsilon,L, score_mat)
% $$$ toc
% $$$ score_Phase_2 = score_dags(data, node_sizes, {Phase_2});
% $$$ 
% $$$ tic
% $$$ Phase_3 = phaseIII(Phase_2,data,node_sizes,epsilon);
% $$$ toc
% $$$ score_Phase_2 = score_dags(data, node_sizes, {Phase_3});
% $$$ 
% $$$ end

figure
[xx, yy] = draw_graph(alarmdag,names,carre);
title('alarm');
% $$$ figure
% $$$ draw_graph(Phase_1,names,carre,xx,yy);
% $$$ title('Phase 1');
% $$$ figure
% $$$ draw_graph(MWST,names,carre,xx,yy);
% $$$ title('MWST');
% $$$ figure
% $$$ draw_graph(Phase_2,names,carre,xx,yy);
% $$$ title('Phase 2');
figure
draw_graph(Phase_3,names,carre,xx,yy);
title('Phase 3');
