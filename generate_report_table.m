%This function takes variables composed of single row arrays and combines
%them into a table with defined variable names

%This function uses the function padcat.m, written by Jos van der Geest.  License is present in the folder as the file 'padcat license.txt' and copied below.

function [output_table] = generate_report_table(number_of_objects,avg_object_length,avg_number_of_events,event_total_bins,norm_freq_total_events,interval,event_frequency,inter_interval_distance,average_CoC,mean_distance,distance_between_adjacent_events,gamma_shape,gamma_shape_CIs,gamma_scale,gamma_scale_CIs)
combined_matrix=padcat(number_of_objects,avg_object_length,avg_number_of_events,event_total_bins,norm_freq_total_events,interval,event_frequency,inter_interval_distance,average_CoC,mean_distance,distance_between_adjacent_events,gamma_shape,gamma_shape_CIs,gamma_scale,gamma_scale_CIs)';
output_table=array2table(combined_matrix,'VariableNames',{'Number_of_analyzed_objects' 'Mean_object_length' 'Mean_number_of_events_per_object' 'Total_number_of_events' 'Normalized_frequency' 'Interval' 'Frequency_of_events' 'Inter_interval_distance' 'Mean_CoC' 'Mean_distance_between_adjacent_events' 'Distance_between_adjacent_events' 'Gamma_shape_MLE' 'Gamma_shape_CIs' 'Gamma_scale_MLE' 'Gamma_Scale_CIs'});
end

% Copyright (c) 2009, Jos van der Geest
%All rights reserved.

%Redistribution and use in source and binary forms, with or without
%modification, are permitted provided that the following conditions are
%met:

%    * Redistributions of source code must retain the above copyright
%      notice, this list of conditions and the following disclaimer.
%    * Redistributions in binary form must reproduce the above copyright
%      notice, this list of conditions and the following disclaimer in
%      the documentation and/or other materials provided with the distribution

%THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
%AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
%IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
%ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
%LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
%CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
%SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
%INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
%CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
%ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
%POSSIBILITY OF SUCH DAMAGE.
