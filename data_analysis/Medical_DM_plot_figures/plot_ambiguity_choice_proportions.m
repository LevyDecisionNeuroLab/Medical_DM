function plot_ambiguity_choice_proportions(participants_ambig_proportions,AMBIG_LEVEL)
%% Plot a figure showing this data
% Classify participants as monotomic increase, decrease, or non monotonic
% in thei proportion of ambiguity choices
ambig_propotion_diff = table2array(diff(participants_ambig_proportions,1,2));

% Rows where each ambig choice proportion is identical or smaller to its
% previous
monotonic_decrease_indices = all(ambig_propotion_diff<=0,2);

% Rows where each ambi choice proportion is identical or greater to its
% previous. To not count twice (in bot monotonic increase, and decrease)
% the same participant, participants which has identical levels across all
% ambiguity levels (e.g. chose ambiguity once in each ambiguity level) are
% excluded from the "monotonic increase" category. Namely, participatns are
% considered monotonic increase if the proportion of ambiguity choices
% increase or stays the same with ambiguity levels, and increases at least
% onces
monotonic_increase_indices = all(ambig_propotion_diff >= 0, 2) & any(ambig_propotion_diff > 0, 2);
monotonic_non_monotonic = ~(monotonic_increase_indices | monotonic_decrease_indices);

% Set up the figure
hold on;

% Constants
MARKER_SIZE = 15;
LINE_WIDTH = 3;
FONT_SIZE_AXIS = 14;
FONT_SIZE_LABEL = 18;
FONT_WEIGHT = 'bold';
COLORS = {[0.85, 0.33, 0.10], [0.30, 0.75, 0.93], [0.47, 0.67, 0.19], [0, 0, 0]};

ALPHA = 0.5;
Y_LIMITS = [-0.1 1.1];
X_LIMITS = [0.5 4.5];
LEGEND_FONT_SIZE = 14;
Y_TICKS = (0:6)./6;

% Set up the figure
hold on;

% Define ambiguity levels and ordinal x-values
x_values = 1:length(AMBIG_LEVEL);

% Extract the values for different participant groups
monotonic_increase_values = participants_ambig_proportions{monotonic_increase_indices, :};
monotonic_decrease_values = participants_ambig_proportions{monotonic_decrease_indices, :};
non_monotonic_values = participants_ambig_proportions{monotonic_non_monotonic, :};

% Plot jittered points for each group within the defined jitter ranges
scatter(x_values - 0.3 + rand(sum(monotonic_decrease_indices), 1) * 0.2, monotonic_decrease_values, ...
    MARKER_SIZE, 'MarkerFaceColor', COLORS{2}, 'MarkerEdgeColor', 'none', 'MarkerFaceAlpha', ALPHA);
scatter(x_values - 0.1 + rand(sum(monotonic_non_monotonic), 1) * 0.2, non_monotonic_values, ...
    MARKER_SIZE, 'MarkerFaceColor', COLORS{3}, 'MarkerEdgeColor', 'none', 'MarkerFaceAlpha', ALPHA);
scatter(x_values + 0.1 + rand(sum(monotonic_increase_indices), 1) * 0.2, monotonic_increase_values, ...
    MARKER_SIZE, 'MarkerFaceColor', COLORS{1}, 'MarkerEdgeColor', 'none', 'MarkerFaceAlpha', ALPHA);

% Calculate and plot the mean and standard error for each group
mean_increasing = mean(monotonic_increase_values, 1);
mean_decreasing = mean(monotonic_decrease_values, 1);
mean_non_monotonic = mean(non_monotonic_values, 1);
mean_all = mean(participants_ambig_proportions{:,:}, 1);

sem_increasing = std(monotonic_increase_values, [], 1) ./ sqrt(sum(monotonic_increase_indices));
sem_decreasing = std(monotonic_decrease_values, [], 1) ./ sqrt(sum(monotonic_decrease_indices));
sem_non_monotonic = std(non_monotonic_values, [], 1) ./ sqrt(sum(monotonic_non_monotonic));
sem_all = std(participants_ambig_proportions{:,:}, [], 1) ./ sqrt(size(participants_ambig_proportions, 1));

% Plot the mean and standard error lines
h1 = errorbar(x_values, mean_increasing, sem_increasing, 'LineWidth', LINE_WIDTH, 'Color', COLORS{1}, 'CapSize', 8);
h2 = errorbar(x_values, mean_decreasing, sem_decreasing, 'LineWidth', LINE_WIDTH, 'Color', COLORS{2}, 'CapSize', 8);
h3 = errorbar(x_values, mean_non_monotonic, sem_non_monotonic, 'LineWidth', LINE_WIDTH, 'Color', COLORS{3}, 'CapSize', 8);
h4 = errorbar(x_values, mean_all, sem_all, 'LineWidth', LINE_WIDTH + 1, 'Color', COLORS{4}, 'CapSize', 12);

% Set y-axis limits and add y-grid
ylim(Y_LIMITS);
yticks(Y_TICKS);
ytickformat('%.2f');  % Format y-ticks to 2 decimal places
grid on;
set(gca, 'YGrid', 'on', 'XGrid', 'off', 'GridAlpha', 0.3);  % Horizontal grid lines only

% Set x-axis as ordinal and label the ticks with the ambiguity levels
xticks(x_values);
xticklabels(arrayfun(@(x) sprintf('%d', x), AMBIG_LEVEL, 'UniformOutput', false));
xlim(X_LIMITS);

% Set font sizes and labels
set(gca, 'FontSize', FONT_SIZE_AXIS);
xlabel('Ambiguity Levels', 'FontSize', FONT_SIZE_LABEL, 'FontWeight', FONT_WEIGHT);
ylabel('Proportion of Ambiguity Choices', 'FontSize', FONT_SIZE_LABEL, 'FontWeight', FONT_WEIGHT);

% Create the legend with proportion information
total_participants = size(participants_ambig_proportions, 1);
legend_entries = {sprintf('Increasing (%.1f%%)', 100 * sum(monotonic_increase_indices) / total_participants), ...
                  sprintf('Decreasing (%.1f%%)', 100 * sum(monotonic_decrease_indices) / total_participants), ...
                  sprintf('Non-monotonic (%.1f%%)', 100 * sum(monotonic_non_monotonic) / total_participants), ...
                  'All Participants'};
legend_handle = legend([h1, h2, h3, h4], legend_entries, 'Location', 'NorthEast', 'FontSize', LEGEND_FONT_SIZE);

% Set legend background transparency by modifying the color property
legend_handle.BoxFace.ColorType = 'truecoloralpha';
legend_handle.BoxFace.ColorData = uint8([255; 255; 255; 180]);  % white with 50% transparency

% Hold off to stop adding to the figure
hold off;

end

