function crossover_simulationv2(input_file)

%% Step 1: obtain parameter sets from input table
%MW: If table has no name, the user can select the file using finder.  Assume that table has headers

if isempty(input_file)
    input_file = uigetfile('*');
end
input=readtable(input_file);
input_table=table2array(input);

%% Step 2: Simulate crossover patterning for each paramater set (on each line of input table)

%Note that although this is a loop, each simulation could be computed in parallel. It may be possible to do this using the parfor function of MATLAB, but you would need the parallel computing toolbox

% Step 2.1: start a loop, reading a parameter set from each line of input
number_of_simulations=size(input_table,1);
for i=1:number_of_simulations
    
    %Step 2.2.1: get parameter set from appropriate line in table
    
    %Total number of simulated bivalents
    n=input_table(i,1);                                                     %MW: The total number of simulated objects (bivalents). n>=0
    
    %Precursor Patterning Parameters
    N=input_table(i,2);                                                     %MW: The mean number of precursors per simulated object (bivalent). N>=0
    B=input_table(i,3);                                                     %MW: The similarity in total precursor number between objects (bivalents). 0<=B<=1
    E=input_table(i,4);                                                     %MW: The evenness of precursor spacingff along objects (bivalents). 0<=E<=1
    Bs=input_table(i,5);                                                    %MW: The left co-ordinate of the region of precursor suppression ("black hole").  0<=Bs<=1
    Be=input_table(i,6);                                                    %MW: The right co-ordinate of the region of precursor suppression ("black hole").  0<=Be<=1
    Bd=input_table(i,7);                                                    %MW: Precursor density within the black hole, relative to regions outside the black hole.  0<=Bd<=1
    Y=input_table(i,8);                                                     %MW: Maturation efficiency of an observable precursor into a crossover designation-responsive precursor. 0<=Y<=1
    
    %Crossover Designation Patterning Parameters
    Smax=input_table(i,9);                                                  %MW: The mean maximum stress level per simulated object (bivalent). Smax>=0
    Bsmax=input_table(i,10);                                                 %MW: The similarity in maximum stress level between objects (bivalents). 0<=Bsmax<=1
    A=input_table(i,11);                                                    %MW: The determinant of precursor intrinsic sensitivities. 1<=A<=7    
    L=input_table(i,12);                                                    %MW: Stress relief distance.  0.001<=L<=1
    cL=input_table(i,13);                                                   %MW: Left end clamp.
    cR=input_table(i,14);                                                   %MW: Right end clamp.
    
    %Crossover Maturation Parameters
    M=input_table(i,15);                                                    %MW: Probability of a (crossover) designated precursor maturing into a detectable (crossover) product. 0<=M<=1
    T2prob=input_table(i,16);                                               %MW: Probability that a precursor that was not designated as a crossover, will become a detectable (Type II) crossover. 0<=T2prob<=1
    
    %% Step 2.2: For each simulated object (bivalent), generate an array of precursors with intrinsic stress sensitivity values
    
    %Step 2.2.1: generate the total number of precursors for each simulated object (bivalent), given either no variation, a Poisson distribution or a binomial distribution
    
    %If there is no variation in the total number of precursors, round N to the nearest integer
    if B==0
        N=round(N);
    end 
    [number_of_precursors_per_object]=event_per_object_from_population_mean(n,N,B);
    
    %Step 2.2.2: generate an array of precursor positions for each simulated object (bivalent) and update the total number of precursors per bivalent
    [precursor_positions,number_of_precursors_per_object]=generate_precursor_array(n,number_of_precursors_per_object,E,Bs,Be,Bd);
    
    %Step 2.2.3: Remove precursors with a probability determined by Y.
    [precursor_positions,number_of_precursors_per_object]=mature_precursor_array(n,number_of_precursors_per_object,precursor_positions,Y);
 
    % Step 2.2.4: Assign each precursor an intrinsic sensitivity to stress
    [precursor_sensitivity_matrix]=generate_precursor_sensitivities(n,number_of_precursors_per_object,A);
    
    %% Step 2.3: Apply stress and determine which precursors become designated to form (crossovers)
    
    % Step 2.3.1: decide how much stress to apply to each object (bivalent), given either no variation, a Poisson distribution or a binomial distribution
    [maximum_stress_per_object]=event_per_object_from_population_mean(n,Smax,Bsmax);
    
    % Step 2.3.2: Apply stress to each object and pattern events according to the Beam-Film model
    [event_designations]=pattern_event_designations_according_to_beam_film_model(n,number_of_precursors_per_object,precursor_positions,precursor_sensitivity_matrix,maximum_stress_per_object,L,cL,cR);
    
    %% Step 2.4: mature designated precursors into (the detectable) products
    [mature_designations]=mature_designated_precursors(n,number_of_precursors_per_object,precursor_positions,event_designations,M);
    
    %% Step 2.5: Add type II events (mature non-designated precursors into detectable products with some probability)
    %MW: note that in the current version of the program, designated precursors that fail to mature (step 2.4) have the potential to become a type II event
    [final_array_of_events]=add_typeII_events(n,number_of_precursors_per_object,mature_designations,T2prob);
    
    %% Step 2.6: generate final table of event (crossover) positions, append object length (for future analysis) and output results
    final_array_of_events=final_array_of_events-precursor_positions;
    final_array_of_events=1-final_array_of_events;
    final_array_of_events(final_array_of_events==1)=0;
    final_array_of_events(final_array_of_events==0)=NaN;
    final_array_of_events=sort(final_array_of_events,2);
    object_length(1:n,1)=1;
    final_array_of_events=horzcat(object_length,final_array_of_events);   
    seperate='_';
    append1='line';
    append2=num2str(i+1);
    file_type='.csv';
    output_name=strcat(input_file,seperate,append1,append2,file_type);
    csvwrite(output_name,final_array_of_events);
    
end

end
