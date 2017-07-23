function bnet = bnet_pak(bnet,theta)

dim = length(bnet.CPD);
j = 0;
for d=1:dim
    s = cpt_size(bnet,d);
    bnet.CPD{d} = tabular_CPD(bnet,d,reshape(theta(j+(1:prod(s))),s));
    j = j + prod(s);
end%for

end%function