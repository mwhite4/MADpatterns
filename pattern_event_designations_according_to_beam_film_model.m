function [event_designations]=pattern_event_designations_according_to_beam_film_model(number_of_objects,number_of_precursors_per_object,precursor_positions,precursor_sensitivity_matrix,maximum_stress_per_object,stress_relief_distance,left_end_clamp,right_end_clamp)

max_number_of_precursors=max(number_of_precursors_per_object);
event_designations=precursor_positions;
cflaw(max_number_of_precursors)=0;
%MW: we refer to the local stress ('strc') as the local crossover potential
%(LCP)
strc(max_number_of_precursors)=0;

for i=1:number_of_objects
    precursor_sensitivities=precursor_sensitivity_matrix(i,1:max_number_of_precursors);
    cflaw(1,1:max_number_of_precursors)=0;
    for j=1:number_of_precursors_per_object(i)
        for k=1:number_of_precursors_per_object(i)
            if cflaw(k)==1
                strc(k)=-1;
            end
            if cflaw(k)==0
                strc(k)=conc(precursor_positions(i,k),precursor_sensitivities(k),precursor_positions(i,:),cflaw,maximum_stress_per_object(i),stress_relief_distance,left_end_clamp,right_end_clamp,number_of_precursors_per_object(i));
            end
        end
        %find the precursor with the highest local crossover potential (LCP)
        [vmax,jmax]=max(strc);
        %if the highest LCP is greater or equal to 1, designate it as a crossover
        if vmax>=1
            cflaw(jmax)=1;
            event_designations(i,jmax)=1;
        end
        %if the highest LCP is less than 1 then terminate the 'k' loop
        %(i.e. stop the designation patterning process)      
        if vmax<1
            break
        end
    end
end