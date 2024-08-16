function participants_ambig_proportions = medical_mean_proportion(AMBIG_LEVEL, medical_data, IGNORE_SLIGHT_IMPROVEMENT_COLUMN)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


participants_ambig_proportions = table();

for ii = 1:length(AMBIG_LEVEL)
    ambig_level = AMBIG_LEVEL(ii);
    
    % Calculate the mean for the current ambiguity level
    current_ambig_data = medical_ambiguity_mean_choice_for_level(medical_data, ambig_level, IGNORE_SLIGHT_IMPROVEMENT_COLUMN);
    current_ambig_mean_choice = mean(table2array(current_ambig_data), 2);
    
    % Add the mean values to the table with the ambiguity level as the column name
    participants_ambig_proportions.(sprintf('Ambig_%d', ambig_level)) = current_ambig_mean_choice;
end
end

