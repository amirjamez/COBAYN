function s = cpt_size(bnet,d)

% returns the size of the CPT of node d

f = parents(bnet.dag,d);
s = bnet.node_sizes([f d]);
if isempty(f)
    s = [1 s]; % parents are first
end%if

end%function