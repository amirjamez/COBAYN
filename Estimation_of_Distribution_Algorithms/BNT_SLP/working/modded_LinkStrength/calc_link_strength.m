function [LS,LS_perc] = calc_link_strength (bnet, arc_parent, arc_child, formula)

% calc_link_strength calculates the Blind/True Average Link Strength 
% of the edge from parent to child
% Returns Link Strength Value and Link Strength Percentage.

% By Imme Ebert-Uphoff
                   
   % =================== INITIALIZATION ==================
   EPSILON = AUX_set_epsilon;
   adj = bnet.dag;
   parents = find(adj(:,arc_child));  % Find parents of child
   % find index of arc_parent within vector of ALL parents
   arc_parent_index = find (parents == arc_parent); 

   % Read max_states for parents.  
   for index = 1:length(parents)
      ds = dom_sizes(bnet.CPD{parents(index)});
      % max state is last element of ds:
      parents_max_states(index) = ds(length(ds)); 
   end
   arc_parent_max_state = parents_max_states(arc_parent_index);

   % Read max_state for child
   ds = dom_sizes(bnet.CPD{arc_child});
   arc_child_max_state = ds(length(ds));  % max state is last element of ds

   % =========== GET Conditional Probability Table for child node ===========
   child_CPT = get_field(bnet.CPD{arc_child},'cpt');  % get CPT for arc_child
      % CPT is now D-dimensional array, where D = 1 + # of parents.
      % Parent states come in order of node numbers,
      % Child states are listed LAST, 
      % i.e. CPT of state combination can be accessed as
      %    CPT(p_1_state, p_2_state, ..., child_state)

   % =========== GET Joint Probability P(all parents) for True Average Calc
   if (strcmp(formula,'TrueAverage')) 
     % Assign inference engine and set up to get joint probability P(all parents)
      Nnds = length(bnet.dag);
      % engine = var_elim_inf_engine(bnet);  % Alternative
      engine = jtree_inf_engine(bnet,'clusters',{parents});
      evidence = cell(1,Nnds);  % create empty evidence vector
      engine = enter_evidence(engine,evidence);

      % Now get joint probability P(all parents)
      P_parents = marginal_nodes(engine, parents); 
   end

   % ============ CALCULATIONS ===============================
   U1 = 0; U2 = 0;

   % Use while loop to go through all states of parents
   % ================ TRUE AVERAGE CALCULATIONS =======================
   switch formula
    case 'TrueAverage'

      % Start with parent states of all ones (initial states)
      parents_current_states = ones(size(parents));
      new_state_reached = true;

      while (new_state_reached)

         % pre-calculate P(other parents)=sum_over_arc_parent_states P(parents)
         P_other_parents_value = 0;
         for arc_parent_state = 1:arc_parent_max_state  
            dummy_states = parents_current_states;
            dummy_states(arc_parent_index) = arc_parent_state;
            dummy_value = P_parents.T( AUX_lin_index(P_parents.T,dummy_states));
            P_other_parents_value = P_other_parents_value + dummy_value;
         end

	 % pre-calculate P(arc_child | other parents) and store in array
         for arc_child_state = 1:arc_child_max_state 

	    % First deal with degenerate case:
	    if (P_other_parents_value < EPSILON)
               % For P(z)=0, the value of P(y|z) is undefined. 
	       % We set P(y|z) to 1 in this case, because that forces the 
	       % U1-term for this z to be zero. 
	       % Which is exactly what it should be, since U1-> 0 for P(z)->0.
	       P_child_given_other_parents(arc_child_state) = 1;
            else
               % For EACH child state, SUM over all arc_parent states like this:
	       % P(child|other) = sum_over_arc_parent_states 
               %                  P(child|parents) * P(parents)/P(other parents)
               %
	       P_child_given_other= 0;
               for arc_parent_state = 1:arc_parent_max_state  
                  dummy_states = parents_current_states;
                  dummy_states(arc_parent_index) = arc_parent_state;
                  dummy_CPT_value = AUX_CPT_value( child_CPT, dummy_states, ...
                                      arc_child_state);
                  dummy_P_parents_value = ...
                     P_parents.T( AUX_lin_index(P_parents.T, dummy_states) );
                  P_child_given_other = P_child_given_other + ...
                    dummy_CPT_value*dummy_P_parents_value/P_other_parents_value;
               end
               P_child_given_other_parents(arc_child_state) = P_child_given_other;
            end % end of if-statement
         end

         % Now calculate contributions to 
         %    U1 = U( child | parents ) 
	 %    U2 = U( child | other parents )

         for arc_parent_state = 1:arc_parent_max_state  
	    parents_current_states(arc_parent_index) = arc_parent_state;

            % get value of P(parents) for current parent states
            lin_index = AUX_lin_index( P_parents.T, parents_current_states );
            P_parents_value = P_parents.T(lin_index);
      
            U1_term =0; U2_term =0;
            for arc_child_state = 1:arc_child_max_state 

	       % First get P(child|parents) from CPT table           
               CPT_value = AUX_CPT_value( child_CPT, parents_current_states, ...
                                         arc_child_state);

               % ========= Update U2_term ==============
               if (CPT_value > EPSILON)
                  U2_term = U2_term + CPT_value * log2( CPT_value );
               end

               % ========= Update U1_term ==============
	       if (P_child_given_other_parents(arc_child_state) > EPSILON)
                  U1_term = U1_term + CPT_value * ...
	 	     log2( P_child_given_other_parents(arc_child_state) );
               end
            end

            U1 = U1 + U1_term * P_parents_value;
            U2 = U2 + U2_term * P_parents_value;

         end % of arc_parent loop

         % increment states for all other parents
         [parents_current_states,new_state_reached] = AUX_increment_state( ...
	    parents_current_states, parents_max_states, arc_parent_index);

         % Exit while loop if no new state was reached above.
      end % end of while

      % =============== NORMALIZE RESULTS ======================
      U1 = -U1;
      U2 = -U2;

   % ================ BLIND AVERAGE CALCULATIONS =======================
    case 'BlindAverage' 
      % Start with parent states of all ones (initial states)
      parents_current_states = ones(size(parents));
      new_state_reached = true;

      while (new_state_reached)
         % loop through ALL parent states to calculate U2
         for arc_child_state = 1:arc_child_max_state % for all states of child
            CPT_value = AUX_CPT_value( child_CPT, parents_current_states, ...
                                      arc_child_state);
            if (CPT_value > EPSILON)
               U2 = U2 + CPT_value * log2(CPT_value);
            end
         end

            % increment states for all parents
         [parents_current_states,new_state_reached] = AUX_increment_state( ...
                                 parents_current_states, parents_max_states);
            % Exit while loop if no new state was reached above.
      end % end of while

      % Now calculate U1
      % Restart with parent states of all ones (initial states)
      parents_current_states = ones(size(parents));
      new_state_reached = true;

      while (new_state_reached)
         % this while loop only goes through states of all OTHER parents

         for arc_child_state = 1:arc_child_max_state % for all states of child

	    % Sum P(y|x,z) over all states of x
	    CPT_sum=0;
            for arc_parent_state = 1:arc_parent_max_state  
               dummy_states = parents_current_states;
               dummy_states(arc_parent_index) = arc_parent_state;
               CPT_sum = CPT_sum + AUX_CPT_value(child_CPT,dummy_states, ...
						arc_child_state);
            end

            if (CPT_sum > EPSILON)
               U1 = U1 + CPT_sum * log2(CPT_sum/arc_parent_max_state);
            end
         end
            % increment states for all OTHER parents
         [parents_current_states,new_state_reached] = AUX_increment_state( ...
	         parents_current_states, parents_max_states,arc_parent_index);
            % Exit while loop if no new state was reached above.
      end % end of while

      % =============== NORMALIZE RESULTS ======================
      % calculate number of state combinations of all parents
      n_parent_state_combinations = 1; 	
      for index = 1:length(parents)
         n_parent_state_combinations = ...
            n_parent_state_combinations * parents_max_states(index);
      end
      U1 = -U1 / n_parent_state_combinations;
      U2 = -U2 / n_parent_state_combinations;

   end % of switch formula

   % =============== ASSIGN Link Strength & Percentage =========================
   LS = U1-U2;

   % Deal with numerical error: 
   %  if LS within [-EPSILON,0], set to 0.
   if (LS < 0 && LS > -EPSILON) 
      LS = 0;
   end

   if (abs(U1) > EPSILON)
      LS_perc = 100.0 * LS/U1;
   else         
      LS_perc = -100; % assign impossible value
      fprintf(1,' Warning --');
      fprintf(1,' Degeneracy in Link Strength for  child node=%d  parent node=%d\n', ...
		   arc_child, arc_parent);
      fprintf(1,'  Degeneracy:   U(child|other parents) = 0\n');
      fprintf(1,'  This means given all OTHER parents there is NO');
      fprintf(1,' uncertainty left in child state.\n');
      fprintf(1,'  Thus Link Strength PERCENTAGE is undefined!\n');  
      fprintf(1,'  (Assigned impossible value (-100) to percentage instead.)\n\n');  
   end

%U1
%U2
%LS
%LS_perc

end  % end of function
