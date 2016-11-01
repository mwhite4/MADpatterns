function [positions,total_number_of_precursors]=distribute_precursors_evenly_along_objects(total_number_of_precursors,evenness)
%create an array of perfectly spaced (but randomly positioned)
%precursors matching as closely as possible to the previously
%assigned total number of precursors
start_position=rand;
mean_interprecursor_distance=1/total_number_of_precursors;
down=start_position-mean_interprecursor_distance:(-1*mean_interprecursor_distance):0;
down=sort(down);
up=(start_position+mean_interprecursor_distance):mean_interprecursor_distance:1;
even_position=[down,start_position,up];
%add variation to the interflaw distance, only keeping precursors that
%remain within the boundary of the bivalent
total_number_of_precursors=size(even_position,2);
standard_deviation=mean_interprecursor_distance*(1-evenness);
positions(1:total_number_of_precursors)=inf;
dL=normrnd(0,standard_deviation);
for i=1:total_number_of_precursors
    if dL+even_position(i)>0 && dL+even_position(i)<1
        positions(i)=even_position(i)+dL;
        %If precursor was pushed off the end of the bivalent, reduce the total number of precursors by 1
    else total_number_of_precursors=total_number_of_precursors-1;
    end
    dL=normrnd(0,standard_deviation);
end

end
