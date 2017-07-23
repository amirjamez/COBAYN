# COBAYN: Compiler Autotuning Framework Using Bayesian Networks
COBAYN is partialy funded by [ANTAREX](http://antarex-project.eu) European project. 
```
All rights reserved for the author. 
Any non-academic usage of COBAYN must be permitted by the author.

v1.0 July 2017              
Amir H. Ashouri             
aashouri@ece.utoronto.ca
```



This is a minimal working version of the COBAYN approach. It is a Matlab project that predicts the 
best set of compiler flags given a new unseen application. There are one exploration dataset and two different characterization dataset provided ready-to-go. They can be found at the ~COBAYN/COBAYN/data directory.

## Reference Journal
For the details of the methodology, [COBAYN](http://dl.acm.org/citation.cfm?id=2928270) can be found at ACM digital library.
Make sure to cite this work when you use the code: 

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
keywords = {Bayesian networks, design space exploration, statistical inference},
} 
```

*ACM version:
```
Amir Hossein Ashouri, Giovanni Mariani, Gianluca Palermo, Eunjung Park, John Cavazos, and Cristina Silvano. 
2016. COBAYN: Compiler Autotuning Framework Using Bayesian Networks. 
ACM Trans. Archit. Code Optim. 13, 2, Article 21 (June 2016), 25 pages. 
DOI: http://dx.doi.org/10.1145/2928270
```

# USAGE:

A quick automated script that takes the db, does the import, train and prediction 
is available by just running the following command:

```
>>cd COBAYN
>>COBAYN.m
```

## Step-by-step Process
Modify the "take_db.m" file located at ~/BeliefNetwork/dataProcessing/take_db.m
based on you need as you have to mention the following:

```
1- Importing files:
- Exploration Data set
- Application characterization file
2- Dimension Reduction Technique
- Default is PCA
3- Dataset Normalization Technique
- pick 1-5 and comment it out
```

### 1- Importing the files 

*Exploration Data set:
Your input dataset.csv must be a N columns csv file and  conformed to the following structure:

```
FIRST_ROW     = Header
COL#{1}       = APP_NAME
COL#{2:M}     = COMPILER_FLAGS (binary (categorical) flags: 0 _or_ 1)
COL#{M+1:N-1} = EXEC_TIME per each datasets (Numbers)
COL#{N}       = CODE_SIZE
```

* Appliction characterization

You application characterization.csv set must be n columns csv and have 
the following structure:

```
FIRST_ROW     = Header
COL#{1}       = APP_NAME (i.e. automatic_bitcount)
COL#{2}       = DATA_SET_No (i.e: dataset1)
COL#{3:n}     = FEATURES (Number)
```

* Training the BN:
In order to train the COBAYN BN network, you should follow these steps:

```
>>init_MatEnv.m // setup the paths  
>>take_db.m  // imports the dataset
>>generateModels.m  // trains COBAYN
```

##  4- Testing the BN (Inference)
```
Cross-validation Mode
>>predictionTableGenerator.m  // predicts per application and generates --> COBAYN structure

Standalone Test 
Not available in the current project.
```

#### Original Bayesian network package in Matlab: 

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
