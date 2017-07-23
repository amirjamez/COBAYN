function SAMPLE_USE_SCREEN_OUTPUT 

% Sample file for the use of the LinkStrength package - OUTPUT ON SCREEN 

% By Imme Ebert-Uphoff
    

BN = mk_asia_bnet_with_names('orig');
%BN = mk_alarm_bnet();

print_DAG_structure(BN);
print_all_entropy(BN);
print_all_mutual_information(BN);
print_all_link_strength(BN);

end  % end of function
