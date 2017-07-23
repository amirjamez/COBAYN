function [Formulas] = loadSAT(n, num_i, Formulas)
% [Formulas] = loadSAT(n, mum_i)
% loadMaxSAT: This function loads SAT instances from the SATLIB- benchmark
%             problems site (http://www.cs.ubc.ca/~hoos/SATLIB/benchm.html). 
%             It is only valid for the set of instances called Uniform
%             Random-3-SAT. In 'functions/sat/sat_instances' there are some examples.
%
% INPUT
% n: number of variables
% num_i: instance identifier
% Formula{i,j}: Global variable that contains j clauses for the i formula (instance). A clause is a six
%               component vector. The first three components are the numbers of the
%               variables in the clause. The rest three component indicate whether the
%               literal is negated (0) or not (1).
%
% OUTPUT
% Formula{i,j}
%
% Last version 2/17/2009. Carlos Echegoyen (carlos.echegoyen@ehu.es)

file = ['uf', num2str(n), '-0',num2str(num_i),'.cnf'];

f = fopen(file, 'r');

for i=1:8
    Text{i} = fgetl(f);
end

% Obtaining data form the text
aux_s = size(Text{6}, 2);
aux_cl = strcat(Text{6}(aux_s-2), Text{6}(aux_s-1), Text{6}(aux_s));
cl = str2num(aux_cl); % Clause length. (Max two digits for the length)

aux_s = size(Text{8},2);
aux_nc = strcat(Text{8}(aux_s-4), Text{8}(aux_s-3), Text{8}(aux_s-2), Text{8}(aux_s-1), Text{8}(aux_s));
nc = str2num(aux_nc); % Number of clauses (Max four digits and min two digits for the number of clauses)

nf = size(Formulas,1); % number of formulas

% Obtaining the clauses.
for j=1:nc
    aux = fgetl(f);
    aux = str2num(aux);
    Formulas{nf+1,j}(1:3) = abs(aux(1:cl));
    Formulas{nf+1,j}(4:6) = aux(1:cl) > 0;
end

fclose(f);

