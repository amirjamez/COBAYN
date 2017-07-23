function[val] = PartialEvaluateGeneralFunction(vector)
% [val] = PartialEvaluateGeneralFunction(vector):
%          Evaluates a vector on a multimodal function whose structure and
%          values are respectively defined as global variables
%          But only a subset of the objectives are evaluated 
% INPUT:
% vector: Solution to be evaluated
% FunctionStructure: A global variable. FunctionStructure{i} is a vector of
%                    those variables indices where the function i depends on.
% FunctionTables: A global variable. FunctionTables{i}(j) is the value
%                 given by the objective i to the configuration indexed by j.
% FunctionAccCard: A global variable. FunctionAccCard{i} stores the
%                  accumulated cardinality of variables that belong to objective i.
% SelectedObjectives: A global variable. Specifies with objectives will be
%                     evaluated
% OUTPUT 
% val: A vector of with the same size that SelectedObjectives
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)

 global FunctionTables;
 global FunctionStructure;
 global FunctionAccCard;
 global SelectedObjectives;

 nfactors = size(SelectedObjectives,2);
 val = zeros(1,nfactors);
 for k=1:nfactors,
   i = SelectedObjectives(k);
   length = size(FunctionStructure{i},2);
   j = NumconvertCard(vector(FunctionStructure{i}),length,FunctionAccCard{i})+1;
   val(k) = val(k) + FunctionTables{i}(j); 
 end
 
 
 
 
 