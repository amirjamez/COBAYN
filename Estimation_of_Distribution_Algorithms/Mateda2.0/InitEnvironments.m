function[] = InitEnvironments()
% [] = InitEnvironments()
%
% InitEnvironments:           Initialize the environment of mateda
%                   After installing the BNT, BNT_SLP learning matlab, and
%                   mateda toolboxs, update the paths below according the
%                   location of the programs in your computer.             
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       

initialPath =pwd;

path_mateda =  '/Users/amir/Documents/phd_stuffs/phd_scripts/Bayesian_Model/Estimation_of_Distribution_Algorithms/Mateda2.0';
path_FullBNT = '/Users/amir/Documents/phd_stuffs/phd_scripts/Bayesian_Model/Estimation_of_Distribution_Algorithms/BNT';
path_BNT_SLP = '/Users/amir/Documents/phd_stuffs/phd_scripts/Bayesian_Model/Estimation_of_Distribution_Algorithms/BNT_SLP';

%path_mateda =  'C:\Roberto\Centro\Matlab\Mateda2.0';
%path_FullBNT = 'C:\Roberto\Centro\Matlab\FullBNT-1.0.4\FullBNT-1.0.4';
%path_BNT_SLP = 'C:\Roberto\Centro\Matlab\FullBNT-1.0.4\BNT_StructureLearning_v1[1].4c\BNT_SLP';


   cd(path_FullBNT);
   addpath(genpathKPM(pwd));
   cd(path_BNT_SLP);
   add_SLP;   


P = genpath(path_mateda);
addpath(P);
%cd(path_mateda);
cd(initialPath);



% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es) 
