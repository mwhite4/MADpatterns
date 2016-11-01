function[interval_label,event_frequency,inter_interval_distance,average_coefficient_of_coincidence]=interval_analysis(intervals,event_position,object_length)
%% Notes

%The Coefficient of Coincidence is a measure of the probability of observing a particular pattern of
%events in two intervals given the frequency of each component of the
%pattern within the 2 intervals.  

%For example, for crossover pattern analysis, we calculate the expected
%frequency of seeing (at least) one event in both intervals  given the 
%frequency of seeing an event in each of the intervals across the population 

%Dividing the object into intervals:
%it is not obvious what the best way to do this is.  Ideally, the start
%and the end of each interval will be in the same place for all objects.
%Since there is variation in the length of each object, the absolute
%size of the intervals have to change for each object.  In the absence of
%any information explaining the variation in object length, it is
%reasonable to scale the size of all intervals relative to object length.

%At the moment, the interval positions are all relative to object length.
%This could be changed.


%% Step 1: Calculate the interval boundaries
if size(intervals,2)==1
    period=1/intervals;
    interval_boundaries=(0:period:1);
else interval_boundaries=intervals;
end

%% Step 2: Calculate the total number of intervals
number_of_intervals=size(interval_boundaries,2)-1;

%% Step 3: Calculate the mid-point of each interval (for labels)
interval_label(1:number_of_intervals)=0;
for i=1:number_of_intervals
    interval_label(i)=(interval_boundaries(i+1)-interval_boundaries(i))/2+interval_boundaries(i);
end

%% Step 4: Normalize the event positions relative to object length 
[number_of_objects,max_number_of_events]=size(event_position);
object_length_matrix=zeros(number_of_objects,max_number_of_events);
for i=1:max_number_of_events
    object_length_matrix(:,i)=object_length(:,1);
end
normalized_event_position=event_position./object_length_matrix;

%% Step 5: Bin each object into intervals and calculate the frequency of events per interval

% Step 5.1: for every object, count the number of observed events within
% each interval
event_per_interval(number_of_objects,number_of_intervals)=0;
for i=1:number_of_objects
    for j=1:max_number_of_events
        for k=1:number_of_intervals
            if normalized_event_position(i,j)>=interval_boundaries(k) && normalized_event_position(i,j)<interval_boundaries(k+1)
                event_per_interval(i,k)=event_per_interval(i,k)+1;
            end
        end
    end
end
event_frequency=mean(event_per_interval);

%Step 5.2: for each interval, calculate the proportion of objects that
%had one or more events within that interval
pattern_per_interval=event_per_interval;
pattern_per_interval(pattern_per_interval>1)=1;
observed_pattern_frequency_per_interval=mean(pattern_per_interval);

%%Step 6: Calculate the proportion of objects that had one or more events in each interval for every possible pair or intervals
observed_pattern_frequency(number_of_intervals-1,number_of_intervals-1)=0;
for i=1:number_of_intervals-1
    for j=i+1:number_of_intervals
        observed_pattern_frequency(i,j-i)=(sum(pattern_per_interval(:,i).*pattern_per_interval(:,j)))./number_of_objects;
    end
end

%%Step 7: Calculate the predicted number of objects with an event in both intervals for every possible pair of intervals, assuming that events occur independently
%multiply the average pattern frequency in interval i by the averge frequency
%in the interval, j columns away.  In the results matrix, data for each
%interval is contained in a row, with a seperate column for each possible
%inter-interval distance
expected_pattern_frequency(number_of_intervals-1,number_of_intervals-1)=0;
for i=1:number_of_intervals-1
    for j=i+1:number_of_intervals
        expected_pattern_frequency(i,j-i)=observed_pattern_frequency_per_interval(i)*observed_pattern_frequency_per_interval(j);
    end
end

%%Step 8: Calculate the coefficient of coincidence for each pair of intervals
coefficient_of_coincidence=observed_pattern_frequency./expected_pattern_frequency;
total_CoC_per_distance=nansum(coefficient_of_coincidence,1);
total_pairs_per_distance=coefficient_of_coincidence;
total_pairs_per_distance(~isnan(total_pairs_per_distance))=1;
total_pairs_per_distance=nansum(total_pairs_per_distance,1);
average_coefficient_of_coincidence=total_CoC_per_distance./total_pairs_per_distance;

inter_interval=1:number_of_intervals-1;
relative_inter_interval_distance=1/number_of_intervals*inter_interval;
avg_object_length=mean(object_length);
inter_interval_distance=relative_inter_interval_distance*avg_object_length;
end
