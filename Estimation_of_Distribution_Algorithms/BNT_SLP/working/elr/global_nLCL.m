function nLCL = global_nLCL(beta,bnet,data,cnode,enodes)

if length(beta)>0 % else use existing bnet.CPD - externalizing beta is a way to make that function compliant to gradient descent functions from NetLab
    theta = beta2theta(bnet,beta);
    bnet = bnet_pak(bnet,theta); % the input beta is internalized
end%if

eps = 1e-6;

[n,dim] = size(data);
nLCL = 0;
engine = jtree_inf_engine(bnet);
for i=1:n
    % for each evidence, compute the LCL (log(p_c_e))
    evidence = cell(1,dim);
    evidence(enodes) = num2cell(data(i,enodes));
    [aux_engine,LL] = enter_evidence(engine,evidence);
    marg = marginal_nodes(aux_engine,cnode,1);
    p_c_e = marg.T(data(i,cnode));
    if p_c_e < eps
        p_c_e = eps;
    end%if
    nLCL = nLCL - log(p_c_e); % global empirical negative LCL
end%for
nLCL = nLCL/n; % see equation 5 of the refered article

end%function