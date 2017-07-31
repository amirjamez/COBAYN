# COBAYN: Compiler Autotuning Framework Using Bayesian Networks
COBAYN is partially funded by [ANTAREX](http://antarex-project.eu) European project. 
```
All rights reserved for the author. 
Any non-academic usage of COBAYN must be permitted by the author.

v1.0 July 2017              
Amir H. Ashouri             
aashouri@ece.utoronto.ca
```


This is a minimal working version of the COBAYN approach. It is a Matlab project that predicts the best set of compiler flags given a new unseen application. Evaluations showed that it can outperform the existing models, i.e., [Agakov et al. 2006], [Park et al. 2015], and GCC's standard optimization levels -O2 and -O3. COBAYN tackles the problem of **selecting the best compiler passes**, it does not consider the **phase-ordering problem**. See my other [publications](http://www.eecg.toronto.edu/~aashouri/#publications) for papers related to  finding the best ordering of optimization phases.

## Reference Journal
For the details of the methodology, [COBAYN](http://dl.acm.org/citation.cfm?id=2928270) can be found at ACM digital library.

*If you use any of the materials in this project, i.e., codes, provided ready-to-go datasets, methodology, etc.,  you should cite this work*: 

*Bibtex version: 
```
@article{Ashouri2016COBAYN,
author = {Ashouri, Amir Hossein and Mariani, Giovanni and Palermo, Gianluca and Park, Eunjung and Cavazos, John and Silvano, Cristina},
title = {COBAYN: Compiler Autotuning Framework Using Bayesian Networks},
journal = {ACM Trans. Archit. Code Optim.},
issue_date = {June 2016},
volume = {13},
number = {2},
month = jun,
year = {2016},
issn = {1544-3566},
pages = {21:1--21:25},
articleno = {21},
numpages = {25},
url = {http://doi.acm.org/10.1145/2928270},
doi = {10.1145/2928270},
acmid = {2928270},
publisher = {ACM},
address = {New York, NY, USA},
keywords = {compiler optimization, Bayesian networks, machine learning, statistical inference},
} 
```

*ACM version:
```
Amir Hossein Ashouri, Giovanni Mariani, Gianluca Palermo, Eunjung Park, John Cavazos, and Cristina Silvano. 
2016. COBAYN: Compiler Autotuning Framework Using Bayesian Networks. 
ACM Trans. Archit. Code Optim. 13, 2, Article 21 (June 2016), 25 pages. 
DOI: http://dx.doi.org/10.1145/2928270
```

# Project Tree
```
|── COBAYN/
|  ├── COBAYN.m                                  // automated script ro run and evaluate COBAYN
|  ├── README.txt
|  ├── data
|  │   ├── cBench_onPandaboard_24app_5ds.csv     // Execution-times dataset
|  │   ├── ft_MICA_cbench.csv                    // static characterization dataset
|  │   └── ft_Milepost_cbench.csv                // Dynamic characterization dataset
|  ├── dataProcessing
|  │   ├── getBestSet.m
|  │   ├── getBestSet2.m
|  │   └── take_db.m
|  ├── initMatEnv.m
|  ├── model
|  │   ├── enterEvidence.m
|  │   ├── generateModels.m
|  │   ├── getMLE.m
|  │   ├── getModel.m
|  │   ├── sampleModel.m
|  │   └── useModels.m
|  |── utils
|  |   ├── cell2csv.m
|  |   ├── pcaFromStatToolbox.m
|  |   |── predictionTableGenerator.m
├── Estimation_of_Distribution_Algorithms (*)  // Original Matlab BN package
│   ├── BNT
│   ├── BNT_SLP
│   ├── Mateda2.0
│   └── setupMatlabEnv_EDA.m
└── README.md

```

## Provided datasets

In order to facilitate the test and future comparisons, I have provided a dataset consisting of execution times for many application and two different characterization methods: (i) an exploration dataset, and, (ii) two different characterization datasets provided ready-to-go. They can be found at the ~COBAYN/COBAYN/data directory. 

*(i) Exploration dataset: It consists of 7 compiler passes (GCC flags) (mentioned in the COBAYN's paper) with 24 applications taken from [Cbench](http://ctuning.org/wiki/index.php?title=CTools:CBench) suite. Each application has been evaluated with 5 different datasets for its execution time and code-size. They are profiled in a [Pandaboard](https://archlinuxarm.org/platforms/armv7/ti/pandaboard)  embedded device running on Arch-linux.

*(ii) Characterization datasets are derived with [MICA](https://github.com/boegel/MICA) (dynamic instrumentation) and [Milepost](https://github.com/ctuning/reproduce-milepost-project) (static characterization).



# USAGE:

-Please set your absolute paths in these files: 

```
COBAYN/Estimation_of_Distribution_Algorithms/Mateda2.0/InitEnvironments.m
COBAYN/Estimation_of_Distribution_Algorithms/BNT_SLP/add_SLP.m
```

-Change this line to your needs: 

```
COBAYN/COBAYN/model/generateModels.m:25
bestPerBenchmark = X; // use X number of samples in each application
```

A quick automated script that takes the DBs (both the exploration and the characterization), does the import, train, and prediction (cross-validation) is available by just running the following command:

```
>>cd COBAYN
>>COBAYN.m
```

## Step-by-step Process
Modify the "take_db.m" file located at ~/BeliefNetwork/dataProcessing/take_db.m
based on you need as you have to mention the following:

```
1- Importing files:
    - Exploration Data set (default is cBench_onPandaboard_24app_5ds.csv)
    - Application characterization file  (default is ft_Milepost_cbench.csv)
2- Dimension Reduction Technique
    - Default is PCA
3- Dataset Normalization Technique
    - pick 1-5 and comment the others
```

### Importing the files 

*Exploration Data set:
Your input dataset.csv must be a N columns csv file and  conformed to the following structure:

```
FIRST_ROW     = Header
COL#{1}       = APP_NAME
COL#{2:M}     = COMPILER_FLAGS (binary (categorical) flags: 0 _or_ 1)
COL#{M+1:N-1} = EXEC_TIME per each datasets (Numbers)
COL#{N}       = CODE_SIZE
```

* Application characterization

You application characterization.csv set must be n columns csv and have 
the following structure:

```
FIRST_ROW     = Header
COL#{1}       = APP_NAME (i.e. automatic_bitcount)
COL#{2}       = DATA_SET_No (i.e: dataset1)
COL#{3:n}     = FEATURES (Number)
```



## Training COBAYN:
In order to train the COBAYN BN network, you should follow these steps:

```
>>init_MatEnv.m // setup the paths  
>>take_db.m  // imports the dataset
>>generateModels.m  // trains COBAYN
```


##  Testing COBAYN (Inference)
```
Cross-validation Mode
>>predictionTableGenerator.m  // predicts per application and generates --> Generates COBAYN prediction matlab structure

Standalone Test 
Currently not available.
```

####  (*) Original Bayesian network package in Matlab: 

The Bayesian network package is dervided from the work of "MATEDA-2.0":
```
@article{santana2010mateda,
title={Mateda-2.0: Estimation of distribution algorithms in MATLAB},
author={Santana, Roberto and Bielza, Concha and Larranaga, Pedro and Lozano, Jose A and Echegoyen, Carlos and Mendiburu, Alexander and Armananzas, Rub{\'e}n and Shakya, Siddartha},
journal={Journal of Statistical Software},
volume={35},
number={7},
pages={1--30},
year={2010}
}
```
# COBAYN 2016-2017 
```
All rights reserved for the author. 
Any non-academic usage of COBAYN must be permitted by the author.

v1.0 July 2017              
Amir H. Ashouri             
aashouri@ece.utoronto.ca
```
