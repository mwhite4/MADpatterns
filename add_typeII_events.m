function [final_crossover_array]=add_typeII_events(number_of_objects,number_of_precursors_per_object,mature_designations,T2prob)
for i=1:number_of_objects
    for j=1:number_of_precursors_per_object(i)
        %if designated as a non-crossover
        if mature_designations(i,j)>0 && mature_designations(i,j)<1
            maturation=rand(1);
            if maturation<=T2prob
                mature_designations(i,j)=1;
            end
        end
    end
end
final_crossover_array=mature_designations;
end
