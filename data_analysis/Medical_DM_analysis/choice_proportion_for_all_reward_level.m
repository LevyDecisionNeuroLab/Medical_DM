function [choice_proportion_per_reward_level, unique_values] =...
    choice_proportion_for_all_reward_level(choice_data, only_risk, only_ambig)
%CHOICE_PROPORTION_PER_REWARD_LEVEL Summary of this function goes here
%   Detailed explanation goes here

column_names = choice_data.Properties.VariableNames;
split_names = cellfun(@(x) strsplit(x, '_'), column_names, 'UniformOutput', false);

valid_columns = cellfun(@(x) length(x) >= 4, split_names);
if nargin > 1
    if only_risk
        valid_columns = valid_columns & cellfun(@(x) any(strcmpi(x, 'Risk')), split_names);
    end
    if only_ambig
        valid_columns = valid_columns & cellfun(@(x) any(strcmpi(x, 'Ambig')), split_names);
    end
end

filtered_split_names = split_names(valid_columns);
filtered_column_names = column_names(valid_columns);
fourth_elements = cellfun(@(x) x{4}, filtered_split_names, 'UniformOutput', false);

unique_values = unique(fourth_elements);
% Sort the outcome levels
try
    % Attempt to convert to numeric and sort
    numeric_values = str2double(unique_values);
    if any(isnan(numeric_values))
        error('Conversion to numeric failed.');
    end
    % unique_values = sort(numeric_values);
    unique_values = {'500', '800', '1200', '2500'};

catch
    % Medical outcome levels
    % mild improvement, Slight improvement, moderate improvement, major
    % improvement, Recovery
    custom_order = {'MI', 'SI', 'ModI',  'MajI', 'R'};

    % Ensure the input contains all the custom sort values
    if all(ismember(unique_values, custom_order))
        [~, idx] = ismember(unique_values, custom_order);
        [~, sort_idx] = sort(idx);
        unique_values = unique_values(sort_idx);
    else
        error('Unexpected values in unique_values.');
    end
end

num_rows = size(choice_data, 1);
averaged_data = zeros(num_rows, length(unique_values));

for i = 1:length(unique_values)
    columns_to_average = strcmp(fourth_elements, unique_values(i));
    averaged_data(:, i) = mean(table2array(choice_data(:, filtered_column_names(columns_to_average))), 2);
end
choice_proportion_per_reward_level = ...
    array2table(averaged_data, 'VariableNames', cellstr(unique_values'));
end

