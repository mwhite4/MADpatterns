function [value_per_object]=event_per_object_from_population_mean(number_of_objects,population_mean,distribution_determinant)

% MW: Users should not combine a population mean between 0 and 1 with a
% distribution determinant between 0 and 1.  Larger values means less
% variability

% Step 1: get rid of anomylous values
if distribution_determinant<0
    distribution_determinant=0;
end

if distribution_determinant>1
    distribution_determinant=1;
end  

% Step 2: generate values for each simulated object

%MW: if distribution_determinant=0, draw values from a Poisson distribution
if distribution_determinant==0
    value_per_object=poissrnd(population_mean,number_of_objects,1);
end
%MW: if distribution_determinant=1, all objects get the same value
if distribution_determinant==1
    value_per_object(1:number_of_objects,1)=population_mean;
end
%MW: if 0<distribution_determinant<1, draw values from a Binomial
%distribution.
if distribution_determinant>0 && distribution_determinant<1
    imax=log(1000)/log(population_mean);
    imin=1;
    if population_mean==1
        imax=10;
    end
    step=(imax-imin)/10;
    step=step*distribution_determinant*10;
    distribution_determinant=imin+step;
    distribution_determinant=1/distribution_determinant;
    number_of_trials=round(1000^distribution_determinant);
    probability_of_success=population_mean/number_of_trials;
    if probability_of_success>=1
        probability_of_success=1;
        number_of_trials=population_mean*probability_of_success;
    end
    if probability_of_success==0
        number_of_trials=1;
    end
    value_per_object=binornd(number_of_trials,probability_of_success,number_of_objects,1);
end

end
