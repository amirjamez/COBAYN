 % EXAMPLE 7:  Gaussian UMDA for  the Offline HP Model continuous function 
 % For reference on the Offline HP model see:
 %-- H. P. Hsu, V. Mehra and  P. Grassberger (2003)  Structure optimization in an off-lattice protein model.
 %-- Phys Rev E Stat Nonlin Soft Matter Phys. 2003 Sep;68(3 Pt 2):037703. Epub 2003 Sep 30. 
 %-- http://scitation.aip.org/getabs/servlet/GetabsServlet?prog=normal&id=PLEEE8000068000003037703000001&idtype=cvips&gifs=yes   
  
 Fibbonacci_n = 7; % Fibbonacci_n: Value n for the construction of the Fibbonacci sequence. NumbVar = F(n)
 global HPInitConf;
 HPInitConf = CreateFibbInitConf(Fibbonacci_n); % HP Fibbonacci configuration 
 NumbVar = size(HPInitConf,2);
 PopSize = 1000; 
 F = 'EvaluateOffHPProtein';
 cache  = [0,0,0,0,0]; Card = [zeros(1,NumbVar);2*pi*ones(1,NumbVar)];
 edaparams{1} = {'learning_method','LearnGaussianUnivModel',{}};
 edaparams{2} = {'sampling_method','SampleGaussianUnivModel',{PopSize,3}};
 edaparams{3} = {'replacement_method','elitism',{1,'fitness_ordering'}};
 edaparams{4} = {'selection_method','prop_selection',{2}};
 edaparams{5} = {'repairing_method','SetInBounds_repairing',{}};
 [AllStat,Cache]=RunEDA(PopSize,NumbVar,F,Card,cache,edaparams) 
 % To draw the resulting solution use function OffPrintProtein(vector),
 % where vector is the best solution found.