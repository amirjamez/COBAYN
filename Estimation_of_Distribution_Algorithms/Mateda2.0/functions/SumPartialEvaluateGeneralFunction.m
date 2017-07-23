function[val] = SumPartialEvaluateGeneralFunction(vector)
% [val] = SumPartialEvaluateGeneralFunction(vector):
%          Evaluates a vector on a multimodal function whose structure and
%          values are respectively defined as global variables
%          But only a subset of the objectives are evaluated and the Sum of
%          this objectives is given as OUTPUT
% INPUT:
% vector: Solution to be evaluated
% FunctionStructure: A global variable. FunctionStructure{i} is a vector of
%                    those variables indices where the function i depends on.
% FunctionTables:  A global variable. FunctionTables{i}(j) is the value
%                  given by the objective i to the configuration indexed by j.
% FunctionAccCard: A global variable. FunctionAccCard{i} stores the
%                  accumulated cardinality of variables that belong to objective i.
% SelectedObjectives: A global variable. Specifies with objectives will be
%                     evaluated
% OUTPUT 
% val: A value with the sum of the evaluations of the objetives in SelectedObjectives
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)

  val = sum(PartialEvaluateGeneralFunction(vector));
 
 
 
 