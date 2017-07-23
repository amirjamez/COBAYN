% Description of the Ising instances included in this directory and
% example of the application of the functions for loading the instances
% and evaluating a solution

% Maximum value for the 24 instances
MaxIsing=[18,20,24,18, 50,52,48,50, 86,84,88,94, 136,142,142,138,348,368,356,352, 572,556,554,576];
 
% Number of variables
allvars24=[16,16,16,16, 36,36,36,36, 64,64,64,64, 100,100,100,100,256,256,256,256, 400,400,400,400];

% Problem size
n=16;

% Number of instance for the problem size
inst=1;

% Generate a random individual
ind = fix(2*rand(1,n));

[J,Inters]=LoadIsing(n, inst); % The instance is loaded

result = EvalIsing(ind, J, Inters); % The individual is evaluated