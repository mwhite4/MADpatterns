%This function takes variables composed of single row arrays and combines
%them into a table with defined variable names

function [output_table] = generate_report_table(number_of_objects,avg_object_length,avg_number_of_events,event_total_bins,norm_freq_total_events,interval,event_frequency,inter_interval_distance,average_CoC,mean_distance,distance_between_adjacent_events,gamma_shape,gamma_shape_CIs,gamma_scale,gamma_scale_CIs)
combined_matrix=padcat(number_of_objects,avg_object_length,avg_number_of_events,event_total_bins,norm_freq_total_events,interval,event_frequency,inter_interval_distance,average_CoC,mean_distance,distance_between_adjacent_events,gamma_shape,gamma_shape_CIs,gamma_scale,gamma_scale_CIs)';
output_table=array2table(combined_matrix,'VariableNames',{'Number_of_analyzed_objects' 'Mean_object_length' 'Mean_number_of_events_per_object' 'Total_number_of_events' 'Normalized_frequency' 'Interval' 'Frequency_of_events' 'Inter_interval_distance' 'Mean_CoC' 'Mean_distance_between_adjacent_events' 'Distance_between_adjacent_events' 'Gamma_shape_MLE' 'Gamma_shape_CIs' 'Gamma_scale_MLE' 'Gamma_Scale_CIs'});
end