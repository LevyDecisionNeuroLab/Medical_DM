addpath("Medical_DM_data\")
addpath("Medical_DM_analysis\")
addpath("Medical_DM_plot_figures\")
addpath("Medical_DM_figures\")
import_raw_data();
%% Fig. S1
AMBIG_LEVEL = [24, 50, 74, 100];
IGNORE_SLIGHT_IMPROVEMENT_COLUMN = false;
plot_ambiguity_choice_proportions_in_both_domains_and_phases(...
    AMBIG_LEVEL, IGNORE_SLIGHT_IMPROVEMENT_COLUMN,...
    medical_phase_1, medical_phase_2, monetary_phase_1, monetary_phase_2);
%% Identify swithcing point
figure;
num_participants_to_display = 10; % Arbitraty small number of participants to plot
plot_uncertain_choice_proportion_per_reward...
    (monetary_phase_1, num_participants_to_display)
%% Fig. 3
plot_choice_proportion_per_reward_level(monetary_phase_1, monetary_phase_2, medical_phase_1, medical_phase_2)
save_current_figure('Medical_DM_figures', 'figure_3');
%% Fig. 4
plot_choices_by_uncertainty_levels(...
    monetary_phase_1,monetary_phase_2, medical_phase_1, medical_phase_2)