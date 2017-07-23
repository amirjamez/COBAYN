function resu = partialconnected(G,Y,X)

tmp=expm(G);

resu = (tmp(Y,X)~=0);
