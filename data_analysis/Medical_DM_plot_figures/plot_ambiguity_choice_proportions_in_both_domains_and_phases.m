function plot_ambiguity_choice_proportions_in_both_domains_and_phases(...
    AMBIG_LEVEL, IGNORE_SLIGHT_IMPROVEMENT_COLUMN,...
    medical_phase_1, medical_phase_2, monetary_phase_1, monetary_phase_2...
    )

% Generate the data for each dataset
participants_ambig_proportions_medical_phase_1 = medical_mean_proportion(AMBIG_LEVEL, medical_phase_1, IGNORE_SLIGHT_IMPROVEMENT_COLUMN);
participants_ambig_proportions_medical_phase_2 = medical_mean_proportion(AMBIG_LEVEL, medical_phase_2, IGNORE_SLIGHT_IMPROVEMENT_COLUMN);
participants_ambig_proportions_monetary_phase1 = monetary_mean_proportion(AMBIG_LEVEL, monetary_phase_1, IGNORE_SLIGHT_IMPROVEMENT_COLUMN);
participants_ambig_proportions_monetary_phase2 = monetary_mean_proportion(AMBIG_LEVEL, monetary_phase_2, IGNORE_SLIGHT_IMPROVEMENT_COLUMN);

% Set up the figure
figure;

% Subplot 1: Medical Phase 1
subplot(2, 2, 1);
plot_ambiguity_choice_proportions(participants_ambig_proportions_medical_phase_1, AMBIG_LEVEL);
title('Medical Phase 1', 'Color', [0.8, 0.4, 0]);  % Use the medical color (orange)
xlabel('');  % Remove x-axis label for top subplots
ylabel('');  % Remove y-axis label for right subplots

% Subplot 2: Medical Phase 2
subplot(2, 2, 2);
plot_ambiguity_choice_proportions(participants_ambig_proportions_medical_phase_2, AMBIG_LEVEL);
title('Medical Phase 2', 'Color', [0.8, 0.4, 0]);  % Use the medical color (orange)
xlabel('');  % Remove x-axis label for top subplots
ylabel('');  % Remove y-axis label for right subplots

% Subplot 3: Monetary Phase 1
subplot(2, 2, 3);
plot_ambiguity_choice_proportions(participants_ambig_proportions_monetary_phase1, AMBIG_LEVEL);
title('Monetary Phase 1', 'Color', [0.4, 0.4, 0.8]);  % Use the monetary color (blue)
xlabel('');  % Remove x-axis label for top subplots
ylabel('');  % Remove y-axis label for right subplots

% Subplot 4: Monetary Phase 2
subplot(2, 2, 4);
plot_ambiguity_choice_proportions(participants_ambig_proportions_monetary_phase2, AMBIG_LEVEL);
title('Monetary Phase 2', 'Color', [0.4, 0.4, 0.8]);  % Use the monetary color (blue)
xlabel('');  % Remove x-axis label for top subplots
ylabel('');  % Remove y-axis label for right subplots

% Add shared x-axis label for bottom subplots
han = axes(gcf, 'visible', 'off'); 
han.XLabel.Visible = 'on';
han.YLabel.Visible = 'on';
xlabel(han, 'Ambiguity Levels', 'FontSize', 18, 'FontWeight', 'bold');
ylabel(han, 'Ambiguity Choice Proportions', 'FontSize', 18, 'FontWeight', 'bold', 'Position', [-0.1, 0.5, 0]);  % Move the ylabel slightly to the left

% Adjust the layout
set(gcf, 'Position', [699 183 1.1613e+03 941.3333]);  % Set the figure size as requested

end

