function avg_choice_proportion = choice_proportion(choice_data, first_entry, second_entry, third_entry, fourth_entry)
    % Get the column names
    column_names = choice_data.Properties.VariableNames;
    
    % Split the column names into parts based on underscores
    split_names = cellfun(@(x) strsplit(x, '_'), column_names, 'UniformOutput', false);
    
    % Initialize a logical array to select valid columns
    valid_columns = cellfun(@(x) length(x) == 5, split_names);
    
    % Filter based on first entry (e.g., 'Mon' or 'Med')
    if ~strcmp(first_entry, 'all')
        valid_columns = valid_columns & cellfun(@(x) length(x) >= 1 && strcmpi(x{1}, first_entry), split_names);
    end
    
    % Filter based on second entry (e.g., 'Risk' or 'Ambig')
    if ~strcmp(second_entry, 'all')
        valid_columns = valid_columns & cellfun(@(x) length(x) >= 2 && strcmpi(x{2}, second_entry), split_names);
    end
    
    % Filter based on third entry (risk or ambiguity level)
    if ~strcmp(third_entry, 'all')
        valid_columns = valid_columns & cellfun(@(x) length(x) >= 3 && strcmpi(x{3}, third_entry), split_names);
    end
    
    % Filter based on fourth entry (outcome level)
    if ~strcmp(fourth_entry, 'all')
        valid_columns = valid_columns & cellfun(@(x) length(x) >= 4 && strcmpi(x{4}, fourth_entry), split_names);
    end
    
    % Calculate the average of the valid columns
    if any(valid_columns)
        avg_choice_proportion = mean(table2array(choice_data(:, valid_columns)), 2);
    else
        error('No matching columns found.');
    end
end
