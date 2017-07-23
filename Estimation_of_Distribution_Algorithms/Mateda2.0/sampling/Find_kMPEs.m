function[k_solutions,k_probvalues] =  Find_kMPEs(bnet,k,Card)
% [k_solutions,k_probvalues] =  Find_kMPEs(bnet,k,Card)
% Find_kMPEs:  Given a Bayesian network, find the k most probable
%              configurations of the network.
%              This is essentially the algorithm introduced by Nilsson in:
%              D. Nilsson. An efficient algorithm for finding the {M} most probable configurations in probabilistic expert systems},
%              Statistics and Computing, Vol 2., 1998, Pp. 159--173
%              The algorithm computes the junction tree of the BN and apply max-propagation and dynamic programming 
%              for finding the k MPCs.  Nilsson proposed two schedules for
%              finding the subsequent maxima. This implementation
%              corresponds to the first proposed schedule. Currently, it
%              works for binary variables
% INPUTS
% bnet: Bayesian network
% k: Number of most probable configurations to find
% Card: Cardinality of the variables 
% OUTPUTS
% k_solutions: List of k most probable configurations
% k_probvalues: Probalities given to each configuration during the process
%               (Not necessarily the exact probabilities given by the original JT)
% Last version 8/26/2008. Roberto Santana (roberto.santana@ehu.es)       

n = size(Card,2); % Number of variables
[AccCard] = FindAccCard(n,Card);
 
JT = jtree_inf_engine(bnet, 'maximize', 1);  % The original JT is found from the BN
 for i=1:n,
  auxvar{i} = [];           %      All variables are hidden
 end,
 
 mpe_solution = find_mpe(JT,auxvar);                % The most probable configuration is computed
 [JT, logprob] = enter_evidence(JT, mpe_solution); % The probability is computed
 prob_value = exp(logprob);   
 
 DataJTs(1,:) = [0,0,prob_value];  % The fields of DataJTs are: index,marca,prob_value of the JT
 AllJTs{1} = JT;
 AllConfs{1} = mpe_solution;
 nJT = 1;
 first = 1;
 no_visited = 1;
 while ( first <= k & ~isempty(no_visited))   % The procedure ends when the next JT is k or all JTs have been visited
                                              % i.e. many potential configurations have probability zero                                                                                                  
    no_visited = find(DataJTs(:,1)==0);       % All JTs that have not been visited
    if(~isempty(no_visited))
      [val,Best_JT_index] = max(DataJTs(no_visited,3));  % The index of the  JT with highest probability 
    
      k_probvalues(first) = val;
      k_solutions(first,:) = AllConfs{no_visited(Best_JT_index)}(:);
      Best_JT = AllJTs{no_visited(Best_JT_index)};          % The  JT with highest probability 
      Marca = DataJTs(no_visited(Best_JT_index),2);
      DataJTs(no_visited(Best_JT_index),1) = 1;             % Now it has been visited 
    
      for i=1:n,
         auxvar{i} = [];           %      All variables are hidden
      end,
       
      best_conf = k_solutions(first,:);   %find_mpe(Best_JT,auxvar);
        [valindex] = NumconvertCard(cell2num(k_solutions(first,:))-1,n,AccCard)+1;
    
       
      for i=Marca+1:n
             
             NewJT = Best_JT;             
             
             % To extend to the discrete case, the next steps should be
             % modified to enter not only positive envidence (p(x_i)=1)
             % but also negative evidence (p(x_i)=0) 
             for j=1:i,
		       if (j<i) 
                 auxvar{j} = cell2num(best_conf(j));  
               else
                 auxvar{j} = (3 - cell2num(best_conf(j)));
               end
             end
           
            mpe_solution = find_mpe(NewJT,auxvar);         % The most probable configuration is computed
            [NewJT, logprob] = enter_evidence(NewJT, mpe_solution);   % The probability is computed
            prob_value = exp(logprob);

            if prob_value>0  % Only configurations with positive probabilities are considered
              nJT = nJT + 1;  
              AllConfs{nJT} = mpe_solution;
              AllJTs{nJT} = NewJT; % The JT has been updated with the evidence 
              DataJTs(nJT,:) = [0,i,prob_value];     
            end          
     end,	
     first = first + 1;
    end
 end
 
 k_solutions = cell2num(k_solutions);
  return
  
