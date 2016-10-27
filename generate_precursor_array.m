function [precursor_positions,number_of_precursors_per_object]=generate_precursor_array(number_of_objects,number_of_precursors_per_object,evenness,region_of_precursor_suppression_start,region_of_precursor_suppression_end,relative_precursor_density_within_suppressed_region)


% Step 1: deal with inappropriate inputs

%the value for the 'start' of the region of precursor suppression must be
%smaller than the value for the 'end' of the region.  If not, switch them.

if region_of_precursor_suppression_start>region_of_precursor_suppression_end
    a=region_of_precursor_suppression_start;
    region_of_precursor_suppression_start=region_of_precursor_suppression_end;
    region_of_precursor_suppression_end=a;
end

%The region of precursor suppression must be within the bivalent
% (i.e. between 0 and 1). Remove region of precursor suppression if it is
% outside the bivalent

if region_of_precursor_suppression_start>1
    region_of_precursor_suppression_start=1;
end

if region_of_precursor_suppression_end>1
    region_of_precursor_suppression_end=1;
end

%The region of precursor suppression cannot be the entire length of the
%chromosome.  If user inputs full length, convert to 0.001-0.999

if region_of_precursor_suppression_start==0
    if region_of_precursor_suppression_end==1
        region_of_precursor_suppression_start=0.001;
        region_of_precursor_suppression_end=0.999;
    end
end

%% Step 2:

%need to update the max_number_of_precursors

max_number_of_precursors=max(number_of_precursors_per_object);
max_possible_number_of_precursors=max_number_of_precursors*(1+(region_of_precursor_suppression_end-region_of_precursor_suppression_start));
max_possible_number_of_precursors=round(max_possible_number_of_precursors);

precursor_positions(number_of_objects,max_possible_number_of_precursors)=0;
for i=1:number_of_objects
    precursor_positions(i,max_possible_number_of_precursors)=0;
    total_number_of_precursors=number_of_precursors_per_object(i);
    
    %Step2.1: update total number of precursors to account for any that will be lost in the blackhole
    %NB: blackhole currently written that input of 0 means no precursors in blackhole and 1 means precursors normal in the blackhole
    
    %step2.1.1: increase precursors to extent that blackhole has none
    temp_total_number_of_precursors=total_number_of_precursors*(1+(region_of_precursor_suppression_end-region_of_precursor_suppression_start));
    %step2.1.2: subtract precursors to account for the few precursor that will appear in the blackhole
    total_number_of_precursors=temp_total_number_of_precursors-(temp_total_number_of_precursors-total_number_of_precursors)*relative_precursor_density_within_suppressed_region;
    %step2.1.3: make sure you end up with an integer
    total_number_of_precursors=round(total_number_of_precursors);
    %step 2.1.4: Position precursors along the bivalent:
    
    %If evenness value is 0, pick precursor positions at random from
    %uniform distribution
    if evenness==0
        positions=rand(1,total_number_of_precursors);
    else
        %If evenness value is not 0, create an array of perfectly spaced (but randomly positioned)
        %precursors matching as closely as possible to the previously
        %assigned total number of precursors
        [positions,total_number_of_precursors]=distribute_precursors_evenly_along_objects(total_number_of_precursors,evenness);
    end
    
    %step 2.1.5: remove precursors that fall within the blackhole with some
    %probability related to input relative_precursor_density_within_suppressed_region
    updated_total_number_of_precursors=total_number_of_precursors;
    for j=1:total_number_of_precursors
        if positions(j)>=region_of_precursor_suppression_start && positions(j)<=region_of_precursor_suppression_end
            suppression=rand(1);
            if suppression>relative_precursor_density_within_suppressed_region
                positions(j)=inf;
                updated_total_number_of_precursors=updated_total_number_of_precursors-1;
            end
        end
    end
    
    number_of_precursors_per_object(i)=updated_total_number_of_precursors;
    positions=sort(positions);
    positions(isinf(positions))=0;
    size_positions=size(positions,2);
    precursor_positions(i,1:size_positions)=positions;
end

end
