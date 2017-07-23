function theta = bnet_unpak(bnet)

dim = length(bnet.CPD);
theta = [];
for d=1:dim
    s = struct(bnet.CPD{d});
    theta = [theta; s.CPT(:)];
end%for

end%function