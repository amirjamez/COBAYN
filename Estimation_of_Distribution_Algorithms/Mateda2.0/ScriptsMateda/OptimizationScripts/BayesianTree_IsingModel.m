 % EXAMPLE 10:  
 % Bayesian tree EDA for the Ising Model using MPE-sampling (i.e.
 % the most probable individual from the net is added to the population
 % during sampling). The algorithm stops when the optimum is found or the
 % max number of generations is reached
 
 global Isinglattice;
 global Isinginter;
 PopSize = 500; n = 64; cache  = [0,0,0,0,0]; Card = 2*ones(1,n); 
 F = 'EvalIsing'; MaxGen = 150; MaxVal = 86;
 [Isinglattice, Isinginter] = LoadIsing(n, 1);
 stop_cond_params = {MaxGen,MaxVal};
 edaparams{1} = {'stop_cond_method','maxgen_maxval',stop_cond_params};
 edaparams{2} = {'sampling_method',' SampleMPE_BN',{PopSize}};
 [AllStat,Cache]=RunEDA(PopSize,n,F,Card,cache,edaparams);
 