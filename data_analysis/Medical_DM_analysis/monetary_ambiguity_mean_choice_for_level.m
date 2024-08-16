function extracted_columns = ...
    monetary_ambiguity_mean_choice_for_level(monetary_choice, ambig_level, IGNORE_SLIGHT_IMPROVEMENT_COLUMN, is_verbose)
%MEDICAL_DM_ANALYSIS_MEAN_AMBIGUITY_CHOICE_FOR_LEVEL Analyzes ambiguity choice proportions
%   This function extracts the columns related to a specific ambiguity level
%   from the medical_choice table. If specified, it can ignore columns that
%   include "slight improvement" data.

if nargin < 3
    IGNORE_SLIGHT_IMPROVEMENT_COLUMN = true;
end

if nargin < 4
    is_verbose = true;
end

prefix = ['Mon_Ambig_' num2str(ambig_level)]; % e.g. 'Mon_Ambig_24'

% Get the logical index for columns that start with the specified prefix
col_idx = startsWith(monetary_choice.Properties.VariableNames, prefix);

% Extract the columns with the specified prefix
extracted_columns = monetary_choice(:, col_idx);

prefix_to_remove = [prefix '_500']; % e.g. 'Mon_Ambig_24_SI'
if IGNORE_SLIGHT_IMPROVEMENT_COLUMN
    
    % Find the columns that start with the specified prefix
    col_idx_remove = startsWith(extracted_columns.Properties.VariableNames, prefix_to_remove);
    
    % Remove those columns from the extracted_columns table
    extracted_columns(:, col_idx_remove) = [];
end

% Verbose output
if is_verbose
    num_rows = size(extracted_columns, 1);
    column_names = extracted_columns.Properties.VariableNames;
    columns_list_str = strjoin(column_names, ', ');
    
    if IGNORE_SLIGHT_IMPROVEMENT_COLUMN
        ignore_msg = 'ignored';
    else
        ignore_msg = 'not ignored';
    end
    
    fprintf('## Message from function: <strong>%s</strong> ##\n', mfilename);
    fprintf('    Analyzing ambiguity choice proportions for medical choices with an ambiguity level of <strong>%d</strong>.\n', ambig_level);
    fprintf('    The analysis includes <strong>%d participants</strong> and <strong>%d columns</strong>: [%s].\n', num_rows, numel(column_names), columns_list_str);
    fprintf('    Columns with the prefix <strong>%s</strong> are %s.\n', prefix_to_remove, ignore_msg);
end

end
