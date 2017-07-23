function glcl = grad_LCL(theta,bnet,data,cnode,enodes)

% compute formula from proposition 4 in [Gre04]
% this function is therefore used by grad_global_LCL in batch mode

glcl = zeros(length(theta),1);
dim = length(data);

P_f_e = [];
P_df_e = [];
P_f_ec = [];
P_df_ec = [];

engine = jtree_inf_engine(bnet);
evidence = cell(1,dim);

evidence(enodes) = num2cell(data(enodes));
[engine_e,LL] = enter_evidence(engine,evidence); % _e
for dnode=1:dim
    P_f_e = [P_f_e; repmat( pa_infer(engine_e,bnet,dnode,false), bnet.node_sizes(dnode), 1 )]; % _f
    P_df_e = [P_df_e; pa_infer(engine_e,bnet,dnode,true)]; % _df
end%for

evidence{cnode} = data(cnode);
[engine_ec,LL] = enter_evidence(engine,evidence); % _ec
for dnode=1:dim
    P_f_ec = [P_f_ec; repmat( pa_infer(engine_ec,bnet,dnode,false), bnet.node_sizes(dnode), 1 )]; % _f
    P_df_ec = [P_df_ec; pa_infer(engine_ec,bnet,dnode,true)]; % _df
end%for

glcl = ( (P_df_ec - P_df_e) - theta .* (P_f_ec - P_f_e) )';

end%function



function p_x_y  = pa_infer(engine_y,bnet,d,with_d)
% PA_INFER(ENGINE_Y, BNET, D, WITH_D) computes P_X_Y.
% For an evidence Y, infer joint probabilities for parents of D (index of a
% node in BNET), with or without D according to the WITH_D boolean.

pa_d = parents(bnet.dag,d);
if with_d % x = {d pa(d)}
    %[xvalues,pa_d] = node_parents_pair_values(bnet,d);
    x = [pa_d d];
else
    %[xvalues,pa_d] = parents_values(bnet,d);
    x = pa_d;
end%if
if length(x)>0
    marg = marginal_nodes(engine_y,x,1);
    p_x_y = marg.T(:);%element(marg.T,xvalues); % format output
else
    p_x_y = 0;
end%if

end%function