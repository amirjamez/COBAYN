function theta = beta2theta(bnet,beta)

dim = length(bnet.CPD);
theta = exp(beta);
j = 0;
for d=1:dim
    % parents are expected to be first
    s = cpt_size(bnet,d);
    if s(1)==1 % no parents
        p = s(2);
        theta(j+(1:p)) = theta(j+(1:p))/sum(theta(j+(1:p)));
    else
        m = s(end); % == bnet.node_sizes(d)
        n = prod(s(1:end-1));
        p = prod(s);
        for i=1:n % n == #configurations for parents of d
            ind = j+(i:n:p); % p/n == m
            theta(ind) = theta(ind)/sum(theta(ind));
        end%for
    end%if
    j = j + p;
end%for

end%function



% function [dfval,f] = node_parent_pair_values(bnet,d)
% 
% % node N 's possible values are expected to be 1:bnet.node_sizes(N)
% f = parents(bnet.dag,d);
% dfval = ind2subv(bnet.node_sizes([f d]),1:prod(bnet.node_sizes([f d])));
% 
% end%function



% function [fval,f] = parent_values(bnet,d)
% 
% % node N 's possible values are expected to be 1:bnet.node_sizes(N)
% f = parents(bnet.dag,d);
% fval = ind2subv(bnet.node_sizes(f),1:prod(bnet.node_sizes(f)));
% 
% end%function



% function sind = vind2sind(vind,dsizes)
% 
% % Each row in vind is converted as an integer which is the single index of 
% % the element whose coordinates in a matrix of size(vind,2) dimensions - 
% % each dimension d is of size dsizes(d) - is that row in vind.
% % dsizes must be a row vector.
% 
% %sind=vind(:,1)+dsizes(1)*(vind(:,2)-1)+dsizes(1)*dsizes(2)*(vind(:,3)-1)+...
% 
% if length(dsizes)==2 && dsizes(2)==1
%     sind = vind;
% else
%     sind = vind(:,1) + (vind(:,2:end)-1) * cumprod(dsizes(1:end-1))';
% end%if
% 
% end%function



% function e = get_element(M,ind)
% 
% e = M(vind2sind(ind,size(M)));
% 
% end%function



% function M = set_element(M,ind,values)
% 
% M(vind2sind(ind,size(M))) = values;
% 
% end%function