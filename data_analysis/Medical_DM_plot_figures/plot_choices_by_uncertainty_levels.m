function plot_choices_by_uncertainty_levels(monetary_phase_1,monetary_phase_2, medical_phase_1, medical_phase_2)
%MEDICAL_DM_PLOT Summary of this function goes here
%   Detailed explanation goes here

figure('Position',[1000 321 1.0217e+03 916.6667])
COLOR_MONETARY_PHASE_1 = [0.678, 0.847, 0.902]; % Light blue
COLOR_MONETARY_PHASE_2 = [0.564, 0.933, 0.564]; % Light green
COLOR_MEDICAL_PHASE_1 = [0.850, 0.325, 0.098]; % Dark Orange
COLOR_MEDICAL_PHASE_2 = [0.741, 0.580, 0.419]; % Light Brown

subplot(2,2,1) %% Risk, Monetary
hold on
plot(100, 100, 's', 'MarkerSize', 10, 'MarkerEdgeColor', 'k', 'Color', COLOR_MONETARY_PHASE_1, MarkerFaceColor=COLOR_MONETARY_PHASE_1);
plot(100, 100, 's', 'MarkerSize', 10, 'MarkerEdgeColor', 'k', 'Color', COLOR_MONETARY_PHASE_2, MarkerFaceColor=COLOR_MONETARY_PHASE_2);

risk_monetary_phase1_25 = choice_proportion(monetary_phase_1, 'Mon', 'Risk', '25', 'all');
risk_monetary_phase1_50 = choice_proportion(monetary_phase_1, 'Mon', 'Risk', '50', 'all');
risk_monetary_phase1_75 = choice_proportion(monetary_phase_1, 'Mon', 'Risk', '75', 'all');

risk_monetary_phase2_25 = choice_proportion(monetary_phase_2, 'Mon', 'Risk', '25', 'all');
risk_monetary_phase2_50 = choice_proportion(monetary_phase_2, 'Mon', 'Risk', '50', 'all');
risk_monetary_phase2_75 = choice_proportion(monetary_phase_2, 'Mon', 'Risk', '75', 'all');

risk_phase_1 = {risk_monetary_phase1_25, risk_monetary_phase1_50, risk_monetary_phase1_75};
risk_phase_2 = {risk_monetary_phase2_25, risk_monetary_phase2_50, risk_monetary_phase2_75};

uncertainty_level = [25, 50, 75];
for ii=1:length(uncertainty_level)
    plot_bar_with_dist((ii-1)*2, risk_phase_1{ii}, 'left', COLOR_MONETARY_PHASE_1)
    plot_bar_with_dist((ii-1)*2+1, risk_phase_2{ii}, 'right', COLOR_MONETARY_PHASE_2)
end

ylim([-0.1 1.1]);
xlim([-0.5 5.5]);
set(gca, 'XTick', .5:2:4.5, 'XTickLabel', uncertainty_level, 'FontSize', 14, 'YTick', 0:0.25:1)
title('Risk, Monetary')

% Add legend
legend_handle = legend('Phase 1', 'Phase 2', 'Orientation', 'vertical', 'Location','northwest');
set(legend_handle, 'Box', 'on'); % Ensure the legend box is visible
set(legend_handle, 'Color', 'w'); % Make the legend background transparent
set(legend_handle.BoxFace, 'ColorType', 'truecoloralpha', 'ColorData', uint8([255;255;255;128])); % [R;G;B;Alpha], Alpha = 128/255

subplot(2,2,3) %% Risk, Medical
hold on
plot(100, 100, 's', 'MarkerSize', 10, 'MarkerEdgeColor', 'k', 'Color', COLOR_MEDICAL_PHASE_1, MarkerFaceColor=COLOR_MEDICAL_PHASE_1);
plot(100, 100, 's', 'MarkerSize', 10, 'MarkerEdgeColor', 'k', 'Color', COLOR_MEDICAL_PHASE_2, MarkerFaceColor=COLOR_MEDICAL_PHASE_2);

risk_medical_phase1_25 = choice_proportion(medical_phase_1, 'Med', 'Risk', '25', 'all');
risk_medical_phase1_50 = choice_proportion(medical_phase_1, 'Med', 'Risk', '50', 'all');
risk_medical_phase1_75 = choice_proportion(medical_phase_1, 'Med', 'Risk', '75', 'all');

risk_medical_phase2_25 = choice_proportion(medical_phase_2, 'Med', 'Risk', '25', 'all');
risk_medical_phase2_50 = choice_proportion(medical_phase_2, 'Med', 'Risk', '50', 'all');
risk_medical_phase2_75 = choice_proportion(medical_phase_2, 'Med', 'Risk', '75', 'all');

risk_phase_1 = {risk_medical_phase1_25, risk_medical_phase1_50, risk_medical_phase1_75};
risk_phase_2 = {risk_medical_phase2_25, risk_medical_phase2_50, risk_medical_phase2_75};

uncertainty_level = [25, 50, 75];
for ii=1:length(uncertainty_level)
    plot_bar_with_dist((ii-1)*2, risk_phase_1{ii}, 'left', COLOR_MEDICAL_PHASE_1)
    plot_bar_with_dist((ii-1)*2+1, risk_phase_2{ii}, 'right', COLOR_MEDICAL_PHASE_2)
end

ylim([-0.1 1.1]);
set(gca, 'XTick', .5:2:4.5, 'XTickLabel', uncertainty_level, 'FontSize', 14, 'YTick', 0:0.25:1)
title('Risk, Medical')
% Add legend
legend_handle = legend('Phase 1', 'Phase 2', 'Orientation', 'vertical', 'Location','northwest');
set(legend_handle, 'Box', 'on'); % Ensure the legend box is visible
set(legend_handle, 'Color', 'w'); % Make the legend background transparent
set(legend_handle.BoxFace, 'ColorType', 'truecoloralpha', 'ColorData', uint8([255;255;255;128])); % [R;G;B;Alpha], Alpha = 128/255
xlabel('Probability Level (%)', 'FontSize',18, 'FontWeight','bold')
xlim([-0.5 5.5]);

subplot(2,2,2) %% Ambiguity, Monetary
ambiguity_monetary_phase1_24 = choice_proportion(monetary_phase_1, 'Mon', 'Ambig', '24', 'all');
ambiguity_monetary_phase1_50 = choice_proportion(monetary_phase_1, 'Mon', 'Ambig', '50', 'all');
ambiguity_monetary_phase1_74 = choice_proportion(monetary_phase_1, 'Mon', 'Ambig', '74', 'all');
ambiguity_monetary_phase1_100 = choice_proportion(monetary_phase_1, 'Mon', 'Ambig', '100', 'all');

ambiguity_monetary_phase2_24 = choice_proportion(monetary_phase_2, 'Mon', 'Ambig', '24', 'all');
ambiguity_monetary_phase2_50 = choice_proportion(monetary_phase_2, 'Mon', 'Ambig', '50', 'all');
ambiguity_monetary_phase2_74 = choice_proportion(monetary_phase_2, 'Mon', 'Ambig', '74', 'all');
ambiguity_monetary_phase2_100 = choice_proportion(monetary_phase_2, 'Mon', 'Ambig', '100', 'all');

ambiguity_phase_1 = {ambiguity_monetary_phase1_24, ambiguity_monetary_phase1_50, ambiguity_monetary_phase1_74, ambiguity_monetary_phase1_100};
ambiguity_phase_2 = {ambiguity_monetary_phase2_24, ambiguity_monetary_phase2_50, ambiguity_monetary_phase2_74, ambiguity_monetary_phase2_100};

uncertainty_level = [24, 50, 74, 100];
for ii=1:length(uncertainty_level)
    plot_bar_with_dist((ii-1)*2, ambiguity_phase_1{ii}-risk_monetary_phase1_50, 'left', COLOR_MONETARY_PHASE_1)
    plot_bar_with_dist((ii-1)*2+1, ambiguity_phase_2{ii}-risk_monetary_phase2_50, 'right', COLOR_MONETARY_PHASE_2)
end

ylim([-1.1 1.1]);
set(gca, 'XTick', .5:2:6.5, 'XTickLabel', uncertainty_level, 'FontSize', 14, 'YTick', -1:0.5:1)
title('Ambiguity, Monetary')
xlim([-0.5 7.5]);

subplot(2,2,4) %% Ambiguity, Medical
ambiguity_medical_phase1_24 = choice_proportion(medical_phase_1, 'Med', 'Ambig', '24', 'all');
ambiguity_medical_phase1_50 = choice_proportion(medical_phase_1, 'Med', 'Ambig', '50', 'all');
ambiguity_medical_phase1_74 = choice_proportion(medical_phase_1, 'Med', 'Ambig', '74', 'all');
ambiguity_medical_phase1_100 = choice_proportion(medical_phase_1, 'Med', 'Ambig', '100', 'all');

ambiguity_medical_phase2_24 = choice_proportion(medical_phase_2, 'Med', 'Ambig', '24', 'all');
ambiguity_medical_phase2_50 = choice_proportion(medical_phase_2, 'Med', 'Ambig', '50', 'all');
ambiguity_medical_phase2_74 = choice_proportion(medical_phase_2, 'Med', 'Ambig', '74', 'all');
ambiguity_medical_phase2_100 = choice_proportion(medical_phase_2, 'Med', 'Ambig', '100', 'all');

ambiguity_phase_1 = {ambiguity_medical_phase1_24, ambiguity_medical_phase1_50, ambiguity_medical_phase1_74, ambiguity_medical_phase1_100};
ambiguity_phase_2 = {ambiguity_medical_phase2_24, ambiguity_medical_phase2_50, ambiguity_medical_phase2_74, ambiguity_medical_phase2_100};

uncertainty_level = [24, 50, 74, 100];
for ii=1:length(uncertainty_level)
    plot_bar_with_dist((ii-1)*2, ambiguity_phase_1{ii}-risk_medical_phase1_50, 'left', COLOR_MEDICAL_PHASE_1)
    plot_bar_with_dist((ii-1)*2+1, ambiguity_phase_2{ii}-risk_medical_phase2_50, 'right', COLOR_MEDICAL_PHASE_2)
end
xlim([-0.5 7.5]);

ylim([-1.1 1.1]);
set(gca, 'XTick', .5:2:6.5, 'XTickLabel', uncertainty_level, 'FontSize', 14, 'YTick', -1:0.5:1)
title('Ambiguity, Medical')
xlabel('Ambiguity Level (%)', 'FontSize',18, 'FontWeight','bold')

% Add common X and Y labels
han = axes(gcf, 'visible', 'off');
han.XLabel.Visible = 'on';
han.YLabel.Visible = 'on';

ylabel_handle = ylabel(han, 'Choice Proportions', 'FontSize', 20, 'FontWeight', 'bold');
ylabel_position = get(ylabel_handle, 'Position');
ylabel_position(1) = ylabel_position(1) - 0.02; % Adjust the value as needed
set(ylabel_handle, 'Position', ylabel_position);

xlabel_handle = xlabel(han, 'Uncertainty Level', 'FontSize', 20, 'FontWeight', 'bold');
xlabel_position = get(xlabel_handle, 'Position');
xlabel_position(2) = xlabel_position(2) - 0.1; % Adjust the value as needed to move it down
set(xlabel_handle, 'Position', xlabel_position);
save_current_figure('Medical_DM_figures', 'figure_4');
end

