function BIC = get_BIC(bnet, data)
% BIC = get_BIC(bnet)

m = size(data,2);
%engine0 = pearl_inf_engine(bnet, 'protocol', 'tree');
engine0 = jtree_inf_engine(bnet);
%engine1 = engine0;
esc = get_espected_counts(data, engine0, engine0);
[BIC, BICi] = espected_BIC(bnet, esc, m);
