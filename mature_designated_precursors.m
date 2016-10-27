function [mature_crossover_designations]=mature_designated_precursors(number_of_bivalents,number_of_precursors_per_bivalent,precursor_positions,crossover_designations,maturation_efficiency)
    % using this logic (i.e. LZs) CO designations that fail to mature can become a class II CO
for i=1:number_of_bivalents
    for j=1:number_of_precursors_per_bivalent(i)
        if crossover_designations(i,j)==1
            maturation=rand(1);
            if maturation>maturation_efficiency
                crossover_designations(i,j)=precursor_positions(i,j);
            end
        end
    end
end
mature_crossover_designations=crossover_designations;
end
