function [final_precursor_array,updated_total_number_of_precursors_per_bivalent]=mature_precursor_array(number_of_bivalents,number_of_precursors_per_bivalent,precursor_positions,maturation_efficiency)

updated_total_number_of_precursors_per_bivalent=number_of_precursors_per_bivalent;

%Step 1: make 0s into infs.  This is just for sorting purposes later.
precursor_positions(precursor_positions==0)=inf;

for i=1:number_of_bivalents
    for j=1:number_of_precursors_per_bivalent(i)
        maturation=rand(1);
        if maturation>maturation_efficiency
            precursor_positions(i,j)=inf;
            updated_total_number_of_precursors_per_bivalent(i)=updated_total_number_of_precursors_per_bivalent(i)-1;
        end
    end
end
final_precursor_array=precursor_positions;
final_precursor_array=sort(final_precursor_array,2);
final_precursor_array(isinf(final_precursor_array))=0;
end
