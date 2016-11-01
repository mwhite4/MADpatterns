%%A function to calculate the distances between events and provide a statistical summary of their distribution

function [distance_between_adjacent_events_all,mean_distance,mean_norm_distance,gamma_shape,gamma_shape_CIs,gamma_scale,gamma_scale_CIs]=event_spacing(event_position,object_length)

%Step 1: normalize the event positions relative to object length
[row,column]=size(event_position);
object_length_matrix=zeros(row,column);
for i=1:column
    object_length_matrix(:,i)=object_length(:,1);
end
normalized_event_position=event_position./object_length_matrix;

%Step 2: create a list containing distances between neighboring events
distance_between_adjacent_events=event_position(:,2:end)-event_position(:,1:end-1);
distance_between_adjacent_events_norm=normalized_event_position(:,2:end)-normalized_event_position(:,1:end-1);
distance_between_adjacent_events_all=distance_between_adjacent_events(:);
distance_between_adjacent_events_all(isnan(distance_between_adjacent_events_all))=[];
distance_between_adjacent_events_all=distance_between_adjacent_events_all';
normalized_distance_between_adjacent_events_all=distance_between_adjacent_events_norm(:);
normalized_distance_between_adjacent_events_all(isnan(normalized_distance_between_adjacent_events_all))=[];

%Step 3: calculate the mean distance between adjacent events
mean_distance=mean(distance_between_adjacent_events_all);
mean_norm_distance=mean(normalized_distance_between_adjacent_events_all);

%Step 4: fit a gamma distribution to nearest neighbor distances
[phat,pci]=gamfit(distance_between_adjacent_events_all);
gamma_shape=phat(1);
gamma_shape_CIs=pci(:,1)';
gamma_scale=phat(2);
gamma_scale_CIs=pci(:,2)';
end
