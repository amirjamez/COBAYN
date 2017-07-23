function SAMPLE_USE_GRAPHS 

% Sample file for the use of the LinkStrength package - generating graphs

% By Imme Ebert-Uphoff
    
shape1='ellipse';
shape2='doubleoctagon';

BN = mk_asia_bnet_with_names('orig');
%BN = mk_alarm_bnet();


graph_plain_to_dot( BN, 'plain.dot', 'want_names', true, 'shape1', shape1, 'shape2', shape2 );

graph_plain_to_dot( BN, 'plain.dot');

graph_with_entropy_to_dot( BN, 'entropy.dot' );

graph_with_mutual_info_to_dot( BN, 'MI3.dot', 3, false )
graph_with_mutual_info_to_dot( BN, 'MI3_perc.dot', 3 ,true )

graph_with_link_strength_to_dot( BN, 'LSBA.dot', 'BlindAverage', false)
graph_with_link_strength_to_dot( BN, 'LSBA_perc.dot', 'BlindAverage', true)
graph_with_link_strength_to_dot( BN, 'LSTA.dot', 'TrueAverage', false)
graph_with_link_strength_to_dot( BN, 'LSTA_perc.dot', 'TrueAverage', true)

end  % end of function
