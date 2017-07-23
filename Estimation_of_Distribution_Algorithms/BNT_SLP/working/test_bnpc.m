% test BNPC
close all;
clear all;

add_BNT_to_path;

%test='pearson'; % Pearson's Chi2
%test='LRT';     % Likelihood ratio test G2
fprintf('\n=== Structure Learning with BN-PC (Power Constructor) algorithm\n');


bnet=mk_asia_bnetPL ;

n=8;
names={ 'A' , 'S' , 'T' , 'L' , 'B' , 'O' , 'X' , 'D' };
names={ '1' , '2' , '3' , '4' , '5' , '6' , '7' , '8' };
carre=ones(1,n);

fn='asia10000.mat' ;
fprintf('\t- Loading Database : %s\n',fn);
load(fn) ;
data=asiab;
clear asiab;

  
tmp=cputime;
[Phase_3 Phase_2 Phase_1 U] = learn_struct_bnpc(data);
%,2*ones(1,n),0.05,1);
tmp=cputime-tmp;
fprintf('\t- Execution time : %3.2f seconds\n',tmp);

figure;
[xx yy] = make_layout(bnet.dag);
yy=(yy-0.2)*.8/.6+.1;
xx=(xx-0.2833)*.8/.517+.1;
subplot(2,3,1), [xx yy]=draw_graph(bnet.dag,names,carre,xx,yy); %,carre);
title('ASIA original graph');
subplot(2,3,2), draw_graph(Phase_1,names,carre,xx,yy); %,carre);
title('BNPC Phase 1');
subplot(2,3,3), draw_graph(Phase_2,names,carre,xx,yy); %,carre);
title('BNPC Phase 2');
subplot(2,3,4), draw_graph(U,names,carre,xx,yy); %,carre);
title('BNPC Phase 3a');
subplot(2,3,5), draw_graph(Phase_3,names,carre,xx,yy); %,carre);
title('BNPC Phase 3b');
subplot(2,3,6), draw_graph(pdag_to_dag(Phase_3),names,carre,xx,yy); %,carre);
title('BNPC DAG');
drawnow;

