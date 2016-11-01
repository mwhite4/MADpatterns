%% A collection of functions written in MATLAB for the automated analysis of 1D patterning of events along linear objects

function analyze_events_on_linear_objects(input_file,number_of_intervals)
%Step 1: get the input file, format it and extract information
[event_position,object_length]=extract_information(input_file);

%Step 2: measure distances between adjacent events and provide a quantitative
%description
[distance_between_adjacent_events,mean_distance,mean_norm_distance,gamma_shape,gamma_shape_CIs,gamma_scale,gamma_scale_CIs]=event_spacing(event_position,object_length);

%Step 3: Perform summary statistics
[number_of_objects,avg_object_length,avg_number_of_events,event_total_bins,norm_freq_total_events]=summarystatistics(event_position,object_length);

%Step 4: Interval analyses: calculate average Coefficient of Coincidence and average number of events per interval
%Step 4.1 calculate the default number of intervals for interval analysis using the average (normalized) distance between adjacent events
if isempty(number_of_intervals)
    number_of_intervals=ceil(1/mean_norm_distance*5);
end

%Step 4.2: Perform interval analysis
[interval_label,event_frequency,inter_interval_distance,average_CoC]=interval_analysis(number_of_intervals, event_position,object_length);

%Step 5: Generate output report table and save
output_table = generate_report_table(number_of_objects,avg_object_length,avg_number_of_events,event_total_bins,norm_freq_total_events,interval_label,event_frequency,inter_interval_distance,average_CoC,mean_distance,distance_between_adjacent_events,gamma_shape,gamma_shape_CIs,gamma_scale,gamma_scale_CIs);
seperate='_';
append1=num2str(number_of_intervals);
append2='intervals';
file_type='.csv';
output_name=strcat(input_file,seperate,append1,append2,file_type);
writetable(output_table,output_name)
end
