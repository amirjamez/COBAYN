function bnet = mk_asia_bnet()
% make bnet of ASIA net

node = struct('visit', 1, ...
    'smoking', 2, ...
    'tuberculosis', 3, ...
    'bronchitis', 5, ...
    'lung', 4, ...
    'ou', 6, ...
    'Xray', 7, ...
    'dyspnoea', 8);

adjacency = zeros(8);
adjacency([node.visit], node.tuberculosis) = 1;
adjacency([node.smoking], node.lung) = 1;
adjacency([node.lung node.tuberculosis], node.ou) = 1;
adjacency([node.ou], node.Xray) = 1;
adjacency([node.smoking], node.bronchitis) = 1;
adjacency([node.bronchitis node.ou], node.dyspnoea) = 1;

bnet = mk_bnet(adjacency, [2 2 2 2 2 2 2 2]);
bnet.CPD{node.visit} = tabular_CPD(bnet, node.visit, [0.01 0.99]);
bnet.CPD{node.tuberculosis} = tabular_CPD(bnet, node.tuberculosis, [0.05 0.01 0.95 0.99]);
bnet.CPD{node.smoking} = tabular_CPD(bnet, node.smoking, [0.5 0.5]);
bnet.CPD{node.lung} = tabular_CPD(bnet, node.lung, [0.1 0.01 0.9 0.99]);
bnet.CPD{node.ou} = tabular_CPD(bnet, node.ou, [1.0 1.0 1.0 0.0 0.0 0.0 0.0 1.0]);
bnet.CPD{node.Xray} = tabular_CPD(bnet, node.Xray, [0.98 0.05 0.02 0.95]);
bnet.CPD{node.bronchitis} = tabular_CPD(bnet, node.bronchitis, [0.6 0.3 0.4 0.7]);
bnet.CPD{node.dyspnoea} = tabular_CPD(bnet, node.dyspnoea, [0.9 0.7 0.8 0.1 0.1 0.3 0.2 0.9]);

