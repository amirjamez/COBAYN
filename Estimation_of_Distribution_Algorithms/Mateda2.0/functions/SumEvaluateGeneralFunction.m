function[val] = SumEvaluateGeneralFunction(vector)
% [val] =  SumEvaluateGeneralFunction(vector):
%          Evaluates a vector on a multimodal function whose structure and
%          values are respectively defined as global variables
%          FunctionStructure and FunctionTables. The sum of the objectives
%          evaluations is given as output
% INPUT:
% vector: Solution to be evaluated
% FunctionStructure: A global variable. FunctionStructure{i} is a vector of
%                    those variables indices where the function i depends on.
% FunctionTables: A global variable. FunctionTables{i}(j) is the value
%                 given by the objective i to the configuration indexed by j.
% FunctionAccCard: A global variable. FunctionAccCard{i} stores the
%                  accumulated cardinality of variables that belong to objective i.
% OUTPUT 
% val: A vector of number_objective values 
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)

val = sum(EvaluateGeneralFunction(vector));
