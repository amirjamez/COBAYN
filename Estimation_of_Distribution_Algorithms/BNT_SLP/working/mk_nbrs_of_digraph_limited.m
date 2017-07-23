function [Gs, op, nodes, A] = my_mk_nbs_of_digraph(G0,A,limite)
% MY_MK_NBRS_OF_DIGRAPH Make all digraphs that differ from G0 by a single edge deletion, addition or reversal, subject to acyclicity
% [Gs, op, nodes, A] = my_mk_nbrs_of_digraph(G0, A, max_nbr_parents)
%
% G0 is an adj matrix s.t. G0(i,j)=1 iff i->j in graph
% A is the ancestor matrix for G0  (opt, creates if necessary)
% max_nbr_parents (opt, ==24 if absent)
%
% Gs(:,:,i) is the i'th neighbor
% op{i} = 'add', 'del', or 'rev' is the operation used to create the i'th neighbor. 
% nodes(i,1:2) are the head and tail of the operated-on arc.
% Modified from mk_nbrs_of_digraph by Sonia Leach
%
% Modified by Sonia Leach Feb 02
% addition of a maximum of parents per node : olivier.francois@insa-rouen.fr jun 05

if nargin ==2, limite = 20; end
if nargin ==1, A = reachability_graph(G0'); limite = 20; end

n = length(G0);
[I,J] = find(G0); % I(k), J(k) is the k'th edge
E = length(I);    % num edges present in G0


% SINGLE EDGE DELETIONS
% all deletions are valid wrt acyclity

Grep = repmat(G0(:), 1, E); % each column is a copy of G0
% edge_ndx(k) is the scalar location of the k'th edge 
edge_ndx = find(G0);

% edge_ndx = subv2ind([n n], [I J]); % equivalent
% We set (ndx(k), k) to 0 for k=1:E in Grep
ndx = subv2ind(size(Grep), [edge_ndx(:) (1:E)']);
G1 = Grep;
G1(ndx) = 0;
Gdel = reshape(G1, [n n E]);


% SINGLE EDGE REVERSALS

% SML: previously Kevin had that legal structure was if
% A(P,i)=1 for any P = { p | p in parents(j), p~=i}
% specifically he said 
%  "if any(A(ps,i)) then there is a path i -> parent of j -> j
%   so reversing i->j would create a cycle"
% Thus put in another way:
%    for each i,j if sum(G0(:,j)' * A(:,i)) > 0, reversing i->j
% is not legal.
%
% Ex. Suppose we want to check if 2->4 can be reversed in the 
% following graph: 
% G0 =                               A =
%     0     0     1     0               0     0     0     0
%     0     0     1     1               0     0     0     0
%     0     0     0     1               1     1     0     0
%     0     0     0     0               1     1     1     0
% 
% Then parents(4) = G0(:,4) = [0 1 1 0]'
% and A(:,2) = [0 0 1 1]. Thus G0(:,4)'*A(:,2) = 1 b/c 3 is
% an ancestor of 4 and a child of 2. Note that this works b/c
% matrix multiplication has the effect of ANDing the two vectors 
% and summing up the result (equiv. to the any(A(ps,i)) in kevin's code)
%
% So, we vectorize and check for all i,j pairs by looking for
% 1's in L = (G0'*A)' which has L(i,j)=1 if rev(i,j) not legal
% Note that this will give 1's where there are none in the G0
% so we do a L=max(0, G0-L) to cancel out only the existing edges that 
% aren't legal (subtracting where both are 1 and setting where
% G0=0 and A=1 back to 0).

L = max(0, G0-(G0'*A)');
[IL, JL] = find(L);  % I(k), J(k) is the k'th legal edge to rev.
EL = length(IL);


% SML: First we have to DELETE THE EDGES WE ARE REVERSING
% We can't use G1 w/ reversed edges already deleted (as
% Kevin did) b/c the space of possible deletions are different 
% now (some reverses aren't legal)

Grep = repmat(G0(:), 1, EL); % each column is a copy of G0
% edge_ndx(k) is the scalar location of the k'th edge 
edge_ndx = subv2ind([n n], [IL JL]); 
% We set (ndx(k), k) to 0 for k=1:E in Grep
ndx = subv2ind(size(Grep), [edge_ndx(:) (1:EL)']);
G1 = Grep;
G1(ndx) = 0;

% SML: Now we add in our REVERSED EDGES
% rev_edge_ndx(k) is the scalar location of the k'th legal reversed edge
rev_edge_ndx = subv2ind([n n], [JL IL]);

% We set (rev_edge_ndx(k), k) to 1 for k=1:EL in G1
% We have already deleted i->j in the previous step
ndx = subv2ind(size(Grep), [rev_edge_ndx(:) (1:EL)']);
G1(ndx) = 1;
Grev = reshape(G1, [n n EL]);

% SINGLE EDGE ADDITIONS

% SML: previously Kevin had that any addition was legal if A(i,j)=0
% however, you can not add i->j  if j is a descendent of i.
% Thus, we create all possible additions in Gbar and then
% subtract the descendants of each edge as possible parents
% This means the potential parents of i (i.e. Gbar(:,i))
% can not also be descendants if i i.e. (A(:,i)) which is accomplished
% by subtracting (Gbar-A == 1 iff Gbar=1 & A=0)

Gbar = ~G0;  % Gbar(i,j)=1 iff there is no i->j edge in G0
Gbar = setdiag(Gbar, 0); % turn off self loops

GbarL = Gbar-A;
[IbarL, JbarL] = find(GbarL);  % I(k), J(k) is the k'th legal edge to add
EbarL = length(IbarL);

bar_edge_ndx = find(GbarL);

Grep = repmat(G0(:), 1, EbarL); % each column is a copy of G0
ndx = subv2ind(size(Grep), [bar_edge_ndx(:) (1:EbarL)']);
Grep(ndx) = 1;
Gadd = reshape(Grep, [n n EbarL]);

% BRIDE %%%%%%%%%%%%%%%%%%%%%
% Gdel no pb
% Grev
narcs = sum(Grev);
toobig = find(narcs>limite);
[tmp, too_big_dag] = ind2sub([n EL], toobig);
EL2 = mysetdiff(1:EL, too_big_dag);
Grev2 = Grev(:, :, EL2);
% Gadd
narcs = sum(Gadd);
toobig = find(narcs>limite);
[tmp, too_big_dag2] = ind2sub([n EbarL], toobig);
EbarL2 = mysetdiff(1:EbarL, too_big_dag2);
Gadd2 = Gadd(:, :, EbarL2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Gs = cat(3, Gdel, Grev, Gadd);
Gs = cat(3, Gdel, Grev2, Gadd2);

%  nodes = [I J;
%       IL JL;
%     IbarL JbarL];
%  
%  op = cell(1, E+EL+EbarL);
%  op(1:E) = {'del'};
%  op(E+(1:EL)) = {'rev'};
%  op((E+EL+1):end) = {'add'};

nodes = [I J;
     IL(EL2) JL(EL2);
   IbarL(EbarL2) JbarL(EbarL2)];

op = cell(1, E+length(EL2)+length(EbarL2));
op(1:E) = {'del'};
op(E+(1:length(EL2))) = {'rev'};
op((E+length(EL2)+1):end) = {'add'};
