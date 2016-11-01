%%A function to provide summary statistics of the objects and events

function [number_of_objects,avg_object_length,avg_number_of_events,event_total_bins,norm_freq_total_events]=summarystatistics(event_position,object_length)
%Step 1: calculate the total number of objects measured
[number_of_objects,~]=size(object_length);

%Step 2: calculate the average object length
avg_object_length=mean(object_length);

%Step 3: calculate the total number of events for each object
event_position(isnan(event_position))=0;
total_event_per_object=event_position;
total_event_per_object(total_event_per_object>0)=1;
total_event_per_object=sum(total_event_per_object,2);

%Step 4: calculate the average number of events per object
avg_number_of_events=mean(total_event_per_object);

%Step 5: Calculate the frequency of total events
max_events_observed=max(total_event_per_object);
event_total_bins=0:max_events_observed;
freq_total_events = hist(total_event_per_object,(0:1:max_events_observed));
norm_freq_total_events=freq_total_events./number_of_objects;
end
