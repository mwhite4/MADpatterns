%% A function to extract object lengths and event positions from input table

function [event_position,object_length]=extract_information(input_file)

%Step 1: get input table
if isempty(input_file)
    input_file = uigetfile('*');
end
input=readtable(input_file,'ReadVariableNames',false);

%Step 2: format input
input_table=table2array(input);

%Step 3: seperate object lengths from event positions and order event
%positions within each object from smallest to largest 
object_length=input_table(:,1);
event_position=input_table(:,2:end);
event_position=sort(event_position,2);
end
