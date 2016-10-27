function [precursor_sensitivity_matrix]=generate_precursor_sensitivities(number_of_bivalents,number_of_precursors_per_bivalent,determinant_of_precursor_sensitivities)

max_number_of_precursors=max(number_of_precursors_per_bivalent);

%If A=1 (or anything other than 2-7).
precursor_sensitivity_matrix=rand(number_of_bivalents,max_number_of_precursors);

if determinant_of_precursor_sensitivities==2, %MW:This is the distribution used in the original Beam-Film model
    precursor_sensitivity_matrix=sqrt(precursor_sensitivity_matrix);
end

if determinant_of_precursor_sensitivities==3
    precursor_sensitivity_matrix=sqrt(1./precursor_sensitivity_matrix/5);
end

if determinant_of_precursor_sensitivities==4
    precursor_sensitivity_matrix=sqrt(1./precursor_sensitivity_matrix);
end

if determinant_of_precursor_sensitivities==5
    precursor_sensitivity_matrix=1./precursor_sensitivity_matrix;
end

if determinant_of_precursor_sensitivities==6
    precursor_sensitivity_matrix=precursor_sensitivity_matrix.^4;
end

if determinant_of_precursor_sensitivities==7
    precursor_sensitivity_matrix=precursor_sensitivity_matrix.^6;
end

end