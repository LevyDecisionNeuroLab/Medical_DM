function plot_choice_proportion_per_reward_level(monetary_phase_1, monetary_phase_2, medical_phase_1, medical_phase_2)
% Constants
COLOR_MONETARY_PHASE_1 = [0.678, 0.847, 0.902]; % Light blue
COLOR_MONETARY_PHASE_2 = [0.564, 0.933, 0.564]; % Light green
COLOR_MEDICAL_PHASE_1 = [0.850, 0.325, 0.098]; % Dark Orange
COLOR_MEDICAL_PHASE_2 = [0.741, 0.580, 0.419]; % Light Brown

% Figure setup
figure('Position',  [767 148.3333 1.2833e+03 1.1153e+03])

% Calculate unique values for monetary data
[~, unique_values_monetary] = choice_proportion_for_all_reward_level(monetary_phase_1, true, false);

% Function to handle repetitive plotting logic
    function plot_choice_proportions(phase_1_data, phase_2_data, is_only_risk, is_only_ambig, color_1, color_2, subplot_position, x_labels, title_text)
        subplot(2, 2, subplot_position)
        % Subplot for legend entries
        hold on;
        plot(100, 100, 's', 'MarkerSize', 10, 'MarkerEdgeColor', 'k', 'Color', COLOR_MONETARY_PHASE_1, MarkerFaceColor=color_1);
        plot(100, 100, 's', 'MarkerSize', 10, 'MarkerEdgeColor', 'k', 'Color', COLOR_MONETARY_PHASE_2, MarkerFaceColor=color_2);

        [choice_proportion_per_reward_level_1, ~] = choice_proportion_for_all_reward_level(phase_1_data, is_only_risk, is_only_ambig);
        [choice_proportion_per_reward_level_2, ~] = choice_proportion_for_all_reward_level(phase_2_data, is_only_risk, is_only_ambig);

        for ii = 1:length(x_labels)
            plot_bar_with_dist((ii-1)*2, table2array(choice_proportion_per_reward_level_1(:,ii)), 'left', color_1)
            plot_bar_with_dist((ii-1)*2+1, table2array(choice_proportion_per_reward_level_2(:,ii)), 'right', color_2)
        end

        ylim([-0.1 1.1]);
        set(gca, 'XTick', .5:2:6.5, 'XTickLabel', x_labels, 'FontSize', 14, 'YTick', 0:0.25:1)
        title(title_text)
    end

% Plot 1: Risk, Monetary
hold on;

plot_choice_proportions(monetary_phase_1, monetary_phase_2, true, false, COLOR_MONETARY_PHASE_1, COLOR_MONETARY_PHASE_2, 1, unique_values_monetary, 'Risk, Monetary')
% Add half transparent legend 
legend_handle = legend('Phase 1', 'Phase 2', 'Orientation', 'vertical', 'Location','northwest');
set(legend_handle, 'Box', 'on'); % Ensure the legend box is visible
set(legend_handle, 'Color', 'w'); % Make the legend background transparent
set(legend_handle.BoxFace, 'ColorType', 'truecoloralpha', 'ColorData', uint8([255;255;255;128])); % [R;G;B;Alpha], Alpha = 128/255

% Plot 2: Ambiguity, Monetary
plot_choice_proportions(monetary_phase_1, monetary_phase_2, false, true, COLOR_MONETARY_PHASE_1, COLOR_MONETARY_PHASE_2, 3, unique_values_monetary, 'Ambiguity, Monetary')

% Calculate unique values for medical data
unique_values_medical = {'Slight', 'Moderate', 'Major', 'Recovery'};

% Plot 3: Risk, Medical
plot_choice_proportions(medical_phase_1, medical_phase_2, true, false, COLOR_MEDICAL_PHASE_1, COLOR_MEDICAL_PHASE_2, 2, unique_values_medical, 'Risk, Medical')
% Add half transparent legend 
legend_handle = legend('Phase 1', 'Phase 2', 'Orientation', 'vertical', 'Location','northwest');
set(legend_handle, 'Box', 'on'); % Ensure the legend box is visible
set(legend_handle, 'Color', 'w'); % Make the legend background transparent
set(legend_handle.BoxFace, 'ColorType', 'truecoloralpha', 'ColorData', uint8([255;255;255;128])); % [R;G;B;Alpha], Alpha = 128/255

% Plot 4: Ambiguity, Medical
plot_choice_proportions(medical_phase_1, medical_phase_2, false, true, COLOR_MEDICAL_PHASE_1, COLOR_MEDICAL_PHASE_2, 4, unique_values_medical, 'Ambiguity, Medical')

% Add common X and Y labels
han = axes(gcf, 'visible', 'off');
han.XLabel.Visible = 'on';
han.YLabel.Visible = 'on';

ylabel_handle = ylabel(han, 'Choice Proportions', 'FontSize', 20, 'FontWeight', 'bold');
ylabel_position = get(ylabel_handle, 'Position');
ylabel_position(1) = ylabel_position(1) - 0.02; % Adjust the value as needed
set(ylabel_handle, 'Position', ylabel_position);

xlabel_handle = xlabel(han, 'Outcome Level', 'FontSize', 20, 'FontWeight', 'bold');
xlabel_position = get(xlabel_handle, 'Position');
xlabel_position(2) = xlabel_position(2) - 0.05; % Adjust the value as needed to move it down
set(xlabel_handle, 'Position', xlabel_position);

end

%% And here is the code unpacked to 4 different subplots:
% figure('Position',  [767 148.3333 1.2833e+03 1.1153e+03])
% COLOR_MONETARY_PHASE_1 = [0.678, 0.847, 0.902];
% COLOR_MONETARY_PHASE_2 = [0.564, 0.933, 0.564];
% COLOR_MEDICAL_PHASE_1 = [0.850, 0.325, 0.098]; % Dark Orange
% COLOR_MEDICAL_PHASE_2 = [0.741, 0.580, 0.419]; % Light Brown
% 
% subplot(2,2,1) % Risk, Monetary
% is_only_risk = true; is_only_ambig = false;
% [choice_proportion_per_reward_level_1, ~] =...
%     choice_proportion_for_all_reward_level(monetary_phase_1, is_only_risk, is_only_ambig);
% 
% [choice_proportion_per_reward_level_2, unique_values] =...
%     choice_proportion_for_all_reward_level(monetary_phase_2, is_only_risk, is_only_ambig);
% 
% for ii=1:length(unique_values)
%     plot_bar_with_dist((ii-1)*2, table2array(choice_proportion_per_reward_level_1(:,ii)), 'left', COLOR_MONETARY_PHASE_1)
%     plot_bar_with_dist((ii-1)*2+1, table2array(choice_proportion_per_reward_level_2(:,ii)), 'right', COLOR_MONETARY_PHASE_2)
% end
% ylim([-0.1 1.1]);
% set(gca, 'XTick', .5:2:6.5, 'XTickLabel', unique_values, 'FontSize', 14, 'YTick', 0:0.25:1)
% title('Risk, Monetary')
% 
% subplot(2,2,3) % Risk, Medical
% is_only_risk = false; is_only_ambig = true;
% [choice_proportion_per_reward_level_1, ~] =...
%     choice_proportion_for_all_reward_level(monetary_phase_1, is_only_risk, is_only_ambig);
% 
% [choice_proportion_per_reward_level_2, unique_values] =...
%     choice_proportion_for_all_reward_level(monetary_phase_2, is_only_risk, is_only_ambig);
% 
% for ii=1:length(unique_values)
%     plot_bar_with_dist((ii-1)*2, table2array(choice_proportion_per_reward_level_1(:,ii)), 'left', COLOR_MONETARY_PHASE_1)
%     plot_bar_with_dist((ii-1)*2+1, table2array(choice_proportion_per_reward_level_2(:,ii)), 'right', COLOR_MONETARY_PHASE_2)
% end
% ylim([-0.1 1.1]);
% set(gca, 'XTick', .5:2:6.5, 'XTickLabel', unique_values, 'FontSize', 14,'YTick', 0:0.25:1)
% xlabel('$', 'FontSize', 18, 'FontWeight','bold')
% title('Ambiguity, Monetary')
% 
% subplot(2,2,2) % Ambiguity, Monetary
% 
% is_only_risk = true; is_only_ambig = false;
% [choice_proportion_per_reward_level_1, ~] =...
%     choice_proportion_for_all_reward_level(medical_phase_1, is_only_risk, is_only_ambig);
% 
% [choice_proportion_per_reward_level_2, unique_values] =...
%     choice_proportion_for_all_reward_level(medical_phase_2, is_only_risk, is_only_ambig);
% 
% for ii=1:length(unique_values)
%     plot_bar_with_dist((ii-1)*2, table2array(choice_proportion_per_reward_level_1(:,ii)), 'left', COLOR_MEDICAL_PHASE_1)
%     plot_bar_with_dist((ii-1)*2+1, table2array(choice_proportion_per_reward_level_2(:,ii)), 'right', COLOR_MEDICAL_PHASE_2)
% end
% ylim([-0.1 1.1]);
% set(gca, 'XTick', .5:2:6.5, 'XTickLabel', {'Slight', 'Moderate', 'Major', 'Recovery'}, 'FontSize', 14,'YTick', 0:0.25:1)
% title('Risk, Medical')
% legend('Phase 1', 'Phase 2', )
% 
% 
% subplot(2,2,4) % Ambiguity, medical
% 
% is_only_risk = false; is_only_ambig = true;
% [choice_proportion_per_reward_level_1, ~] =...
%     choice_proportion_for_all_reward_level(medical_phase_1, is_only_risk, is_only_ambig);
% 
% [choice_proportion_per_reward_level_2, unique_values] =...
%     choice_proportion_for_all_reward_level(medical_phase_2, is_only_risk, is_only_ambig);
% 
% for ii=1:length(unique_values)
%     plot_bar_with_dist((ii-1)*2, table2array(choice_proportion_per_reward_level_1(:,ii)), 'left', COLOR_MEDICAL_PHASE_1)
%     plot_bar_with_dist((ii-1)*2+1, table2array(choice_proportion_per_reward_level_2(:,ii)), 'right', COLOR_MEDICAL_PHASE_2)
% end
% 
% 
% ylim([-0.1 1.1]);
% set(gca, 'XTick', .5:2:6.5, 'XTickLabel', {'Slight', 'Moderate', 'Major', 'Recovery'}, 'FontSize', 14,'YTick', 0:0.25:1)
% xlabel('Medical Improvement', 'FontSize', 18, 'FontWeight','bold')
% title('Ambiguity, Medical')
% legend('Phase 1', 'Phase 2')
% 
% % Add common X and Y labels
% han = axes(gcf, 'visible', 'off');
% han.XLabel.Visible = 'on';
% han.YLabel.Visible = 'on';
% 
% ylabel_handle = ylabel(han, 'Choice Proportions', 'FontSize', 20, 'FontWeight', 'bold');
% % Adjust the position of the y-label slightly to the left
% ylabel_position = get(ylabel_handle, 'Position');
% ylabel_position(1) = ylabel_position(1) - 0.02; % Adjust the value as needed
% set(ylabel_handle, 'Position', ylabel_position);
% 
% 
% xlabel_handle = xlabel(han, 'Outcome Level', 'FontSize', 20, 'FontWeight', 'bold');
% % Adjust the position of the x-label slightly to the left
% xlabel_position = get(xlabel_handle, 'Position');
% xlabel_position(2) = xlabel_position(2) - 0.05; % Adjust the value as needed to move it down
% set(xlabel_handle, 'Position', xlabel_position);