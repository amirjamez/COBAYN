function [NewPop] = SampleFDA(NumbVar,model,Card,AuxPop,AuxFunVal,sampling_params)
% [NewPop] = SampleFDA(NumbVar,model,Card,AuxPop,AuxFunVal,sampling_params)
% SampleFDA:         Samples a population of individuals from a factorized model
% INPUTS
% NumbVar:   Number of variables
% model:     Markov network model containing the structure (model{1} = Cliques)
%            and the parameters (model{2} = Tables)
% Card:      Vector with the dimension of all the variables. 
% AuxPop:    Auxiliary (selected) population (May be use for partial sampling or resampling)
% AuxFunVal: Evaluation of the data set (required for some sampling algorithms, not for this one)
% sampling_params{1}(1) = N: Number of generated individuals 
% OUTPUTS
% NewPop: Sampled individuals
%
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)    

N = cell2num(sampling_params{1}(1)); 

Cliques = model{1};
Tables = model{2};
NumberCliques = size(Cliques,1);


 NewPop=zeros(N,NumbVar);

 % The new population is generated
 
 for i=1:NumberCliques
  eval(['aux = Tables{',num2str(i),'};']);
  sizeCliqOther = Cliques(i,2);
  sizeCliqSolap = Cliques(i,1);
 

  if(sizeCliqSolap > 0)
    CliqSolap = Cliques(i,3:Cliques(i,1)+2);
    AccCardSolap = FindAccCard(sizeCliqSolap,Card(CliqSolap));
    dimSolap =   NumconvertCard(Card(CliqSolap)-1,sizeCliqSolap,AccCardSolap)+1;
  else 
    CliqSolap = [];
    AccCardSolap = [];
    dimSolap = 1;
  end
   
  CliqOther = Cliques(i,Cliques(i,1)+3:Cliques(i,1)+Cliques(i,2)+2);
  AccCardOther = FindAccCard(sizeCliqOther,Card(CliqOther));
  dimOther =   NumconvertCard(Card(CliqOther)-1,sizeCliqOther,AccCardOther)+1;

  AllVars = [CliqSolap,CliqOther];

  if sizeCliqSolap==0          % If it is a root node  
     index=sus(N,cumsum(aux)); % Values are chosen using SUS
     for j=1:N
       allvarvalues = IndexconvertCard(index(j)-1,sizeCliqOther,AccCardOther);
       NewPop(j,CliqOther) = allvarvalues;
     end
  else

	  auxNewPop=NewPop(:,CliqSolap);

	  % For each of the overlappings, non-overlapped variables are 
      % assigned its values using SUS
	
	  for k=1:dimSolap
                solapval = IndexconvertCard(k-1,sizeCliqSolap,AccCardSolap);
	        % which stores all the individuals for which the overlapping
	        % has the same value k-1
              
               
        if sizeCliqSolap==1
		 which=find( (auxNewPop==repmat(solapval,N,1)) == sizeCliqSolap);
		else
		 which=find(sum((auxNewPop==repmat(solapval,N,1))') == sizeCliqSolap)';
		end

		% In index are stored the values that will be assigned to non-overlapped 
        % variables whose overlapping is k

		 if size(which,1)>0
		  % It might be normalize before generation
		  %aux(k,:)=aux(k,:)/sum(aux(k,:));
		  index=sus(size(which,1),cumsum(aux(k,:)));
		  for j=1:size(which,1)
                          solapval = IndexconvertCard(index(j)-1,sizeCliqOther,AccCardOther);
			  NewPop(which(j),CliqOther)=solapval;
		  end
         end    
     end         % End del for de la variabla k
    end          % End del Else
  end            % End del for de la variable i

   
 
 
% Last version 10/05/2005. Roberto Santana (rsantana@si.ehu.es) 
