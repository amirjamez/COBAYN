clear all
close all
load heart2;
app(5,59)=5;node_sizes(5)=5;

data=[app test];
clear app BDMapp test melange

%profile clear
%profile on
G3 = learn_struct_bnpc(data, node_sizes, 0.05, 0);
%profile off
%profile report report_austr

score_Phase_3 = score_dags(data, node_sizes, {G3})
figure
draw_graph(G3);
title('PhaseIII');
