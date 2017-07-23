function ggnlcl = grad_global_nLCL(beta,bnet,data,cnode,enodes)

if length(beta)>0 % else use existing bnet.CPD
    theta = beta2theta(bnet,beta');
    bnet = bnet_pak(bnet,theta);
else
    theta = bnet_unpak(bnet);
end%if

[n,dim] = size(data);
ggnlcl = zeros(1,length(theta));
for i=1:n
    ggnlcl = ggnlcl - grad_LCL(theta,bnet,data(i,:),cnode,enodes);
end%for

end%function