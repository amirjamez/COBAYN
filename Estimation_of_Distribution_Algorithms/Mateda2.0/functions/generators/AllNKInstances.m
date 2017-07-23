function  AllNKInstances(NumberVar,k,Number_Inst,nam)
% AllNKInstances(NumberVar,k,Number_Inst,nam)
% AllNKInstances:   Generates Number_Inst instances of a random landscape model with
%                   NumberVars variables and k random neighbors for each variable
%                   The structure and function of the instances are saved
%                   in files beginning with 'nam'
% We assume all nodes have cardinality 2
% INPUTS
% NumbVar: Number of variables 
% k: Number of neighbors (0<k<NumbVar)
% Number_Inst: Number of instances to be generated
% nam: prefix name for the files that will store the structure and values
% of the functions
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       

Card = 2*ones(1,NumberVar);

for i=1:Number_Inst
 [ListFactors] =  CreateListFactorsNK(NumberVar,k)
 extfilename = [nam,'_str_N',num2str(NumberVar),'_k',num2str(k),'Inst_',num2str(i),'.txt'];
 SaveFunctionStructure(extfilename,NumberVar,ListFactors,Card);
 [Table] = CreateRandomFunctions(ListFactors,Card)
  extfilename = [nam,'_fnt_N',num2str(NumberVar),'_k',num2str(k),'Inst_',num2str(i),'.txt'];
 SaveFunctionValues(extfilename,NumberVar,ListFactors,Table);
end
