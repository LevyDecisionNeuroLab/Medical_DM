function plot_uncertain_choice_proportion_per_reward...
    (choice_data, num_participants_to_display)
%% Visualize the choice in uncertain option per reward level
% across different conditions in a monetary decision-making task. 
% It generates a 3x3 grid of subplots, where the first two subplots 
% display examples of individual participants' choices and the average 
% choices across all participants for all reward levels. 
% The remaining subplots focus on specific conditions 
% (different levels of risk or ambiguity), 
% showing both individual participant choices and the overall average.

% Define common settings
font_size = 14;
font_weight = 'bold';
y_limits = [0 1];
y_ticks = 0:0.5:1;
grid_on = 'on';

% Define conditions for subplots
conditions = {
    'Risk', '25';
    'Risk', '50';
    'Risk', '75';
    'Ambig', '24';
    'Ambig', '50';
    'Ambig', '74';
    'Ambig', '100';
};

titles = {
    'Risk 25';
    'Risk 50';
    'Risk 75';
    'Ambig 24';
    'Ambig 50';
    'Ambig 74';
    'Ambig 100';
};

[choice_proportion_per_reward_level, unique_values] = choice_proportion_for_all_reward_level(choice_data);
% Plot example participants
subplot(3, 3, 1);
plot(table2array(choice_proportion_per_reward_level(1:num_participants_to_display,:))', 'LineWidth', 1);
xlabel('');  % No label
ylabel('Proportion of Choices', 'FontSize', font_size, 'FontWeight', font_weight);
% Example 10 Participants
title(sprintf('Average across all\nuncertainty level (n=10)'), 'FontSize', font_size, 'FontWeight', font_weight);
xticks(1:length(unique_values));
xticklabels(cellstr(unique_values'));
grid(grid_on);
ylim(y_limits);
set(gca, 'YTick', y_ticks);
yline(0.5, '--', 'Chance Level', 'FontSize', font_size, 'LabelHorizontalAlignment', 'left');
legend('Individual Participants', 'Location', 'northeast');
hold off;

% Second subplot showing average across all participants
all_data = table2array(choice_proportion_per_reward_level)';
mean_all = mean(all_data, 2);
sem_all = std(all_data, [], 2) / sqrt(size(all_data, 2));

subplot(3, 3, 2);
h1 = plot(all_data, 'Color', [0.8 0.8 0.8], 'LineWidth', 1);  % Plot all participants in light gray
hold on;
h2 = errorbar(mean_all, sem_all, 'k', 'LineWidth', 2);  % Plot the mean in black with SEM
xlabel('');  % No label
ylabel('');  % No label
title('All Participants', 'FontSize', font_size, 'FontWeight', font_weight);
title(sprintf('Average across all\nuncertainty level (all participants)'), 'FontSize', font_size, 'FontWeight', font_weight);
xticks(1:length(unique_values));
xticklabels(cellstr(unique_values'));
grid(grid_on);
ylim(y_limits);
set(gca, 'YTick', y_ticks);
legend([h1(1), h2], {'Participants', 'Mean ± SEM'}, 'Location', 'northeast');  % Explicitly set legend entries
hold off;

% Additional subplots for specified conditions
column_names = choice_data.Properties.VariableNames;
for i = 1:size(conditions, 1)
    split_names = cellfun(@(x) strsplit(x, '_'), column_names, 'UniformOutput', false);
    valid_columns = cellfun(@(x) length(x) >= 4 && strcmp(x{2}, conditions{i, 1}) && strcmp(x{3}, conditions{i, 2}), split_names);
    filtered_split_names = split_names(valid_columns);
    filtered_column_names = column_names(valid_columns);
    fourth_elements = cellfun(@(x) str2double(x{4}), filtered_split_names, 'UniformOutput', true);
    
    unique_values = unique(fourth_elements);
    unique_values = sort(unique_values);
    
    num_rows = size(choice_data, 1);
    averaged_data = zeros(num_rows, length(unique_values));
    
    for j = 1:length(unique_values)
        columns_to_average = fourth_elements == unique_values(j);
        averaged_data(:, j) = mean(table2array(choice_data(:, filtered_column_names(columns_to_average))), 2);
    end
    
    choice_proportion_per_reward_level = array2table(averaged_data, 'VariableNames', cellstr(num2str(unique_values')));
    
    all_data = table2array(choice_proportion_per_reward_level)';
    mean_all = mean(all_data, 2);
    sem_all = std(all_data, [], 2) / sqrt(size(all_data, 2));
    
    subplot(3, 3, i + 2);  % Place in the appropriate subplot position
    
    % Plot 10 participants in different colors
    hold on;
    plot(all_data(:,1:num_participants_to_display), 'LineWidth', 1);
    
    % Plot the average for all participants in black
    errorbar(mean_all, sem_all, 'k', 'LineWidth', 2);
    
    if i >= 5
        xlabel('Reward Levels', 'FontSize', font_size, 'FontWeight', font_weight);  % Only add x-labels to bottom row
    else
        xlabel('');
    end
    
    if mod(i, 3) == 2
        ylabel('Proportion of Choices', 'FontSize', font_size, 'FontWeight', font_weight);  % Only add y-labels to leftmost column
    else
        ylabel('');
    end
    
    title(titles{i}, 'FontSize', font_size, 'FontWeight', font_weight);
    xticks(1:length(unique_values));
    xticklabels(cellstr(num2str(unique_values')));
    grid(grid_on);
    ylim(y_limits);
    set(gca, 'YTick', y_ticks);
    % Only add the legend to the top row of subplots
    if false
        legend('Individual Participants', 'Mean ± SEM', 'Location', 'northeast');
    end
    hold off;
end

% Adjust layout
set(gcf, 'Position', [100, 100, 1200, 800]);

end