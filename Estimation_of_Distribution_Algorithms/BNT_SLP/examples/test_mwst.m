% test MWST

clear all;

add_BNT_to_path;

fprintf('\n=== Structure Learning with Maximum Weight Spanning Tree\n');


bnet=mk_asia_bnet ;

n=8;
names={ 'A' , 'S' , 'T' , 'L' , 'B' , 'O' , 'X' , 'D' };
carre=ones(1,n);
node_type={'tabular','tabular','tabular','tabular','tabular','tabular','tabular','tabular'};

fn='asia10000.mat' ;
fprintf('\t- Loading Database : %s\n',fn);
load(fn) ;
data=asiab';
clear asiab;

tmp=cputime;
dag=learn_struct_mwst(data', ones(n,1), bnet.node_sizes, node_type,'mutual_info');
tmp=cputime-tmp;
fprintf('\t- Execution Time : %3.2f seconds\n\n',tmp);

figure; [xx yy] = make_layout(bnet.dag);
yy=(yy-0.2)*.8/.6+.1;
xx=(xx-0.2833)*.8/.517+.1;
subplot(1,2,1), [xx yy]=draw_graph(bnet.dag,names,carre,xx,yy); %,carre);
title('ASIA original graph');
subplot(1,2,2), draw_graph(dag,names,carre,xx,yy); %,carre);
title('MWST DAG');
drawnow;
