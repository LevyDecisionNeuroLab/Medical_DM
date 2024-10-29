function correlation_across_domains(medical_phase_1, medical_phase_2, monetary_phase_1, monetary_phase_2)
%CORRELATION_ACROSS_DOMAINS Calculates and plots correlations across domains
% Each input table has rows as participants and columns with "Risk", "Risk_50", and "Ambig" in column names

% Define function to calculate risk and ambiguity attitudes for each phase
calculate_attitudes = @(data) struct( ...
    'id', data.VarName1, ...
    'risk', mean(data{:, contains(data.Properties.VariableNames, 'Risk')}, 2), ...
    'risk_50', mean(data{:, contains(data.Properties.VariableNames, 'Risk_50')}, 2), ...
    'ambig', mean(data{:, contains(data.Properties.VariableNames, 'Ambig')}, 2) ...
    );

% Calculate attitudes for each phase
attitudes_med_1 = calculate_attitudes(medical_phase_1);
attitudes_med_2 = calculate_attitudes(medical_phase_2);
attitudes_mon_1 = calculate_attitudes(monetary_phase_1);
attitudes_mon_2 = calculate_attitudes(monetary_phase_2);

% Define function to match participants by ID and extract common data
get_common_data = @(a, b) cell2mat(arrayfun(@(id) ...
    [a.risk(a.id == id), b.risk(b.id == id)], ...
    intersect(a.id, b.id), 'UniformOutput', false));

get_common_ambig_data = @(a, b) cell2mat(arrayfun(@(id) ...
    [a.ambig(a.id == id) - a.risk_50(a.id == id), ...
    b.ambig(b.id == id) - b.risk_50(b.id == id)], ...
    intersect(a.id, b.id), 'UniformOutput', false));

% Calculate data pairs for risk correlations
risk_med_1_med_2 = get_common_data(attitudes_med_1, attitudes_med_2);
risk_mon_1_mon_2 = get_common_data(attitudes_mon_1, attitudes_mon_2);
risk_med_1_mon_1 = get_common_data(attitudes_med_1, attitudes_mon_1);
risk_med_2_mon_2 = get_common_data(attitudes_med_2, attitudes_mon_2);

% Calculate data pairs for ambiguity correlations
ambiguity_med_1_med_2 = get_common_ambig_data(attitudes_med_1, attitudes_med_2);
ambiguity_mon_1_mon_2 = get_common_ambig_data(attitudes_mon_1, attitudes_mon_2);
ambiguity_med_1_mon_1 = get_common_ambig_data(attitudes_med_1, attitudes_mon_1);
ambiguity_med_2_mon_2 = get_common_ambig_data(attitudes_med_2, attitudes_mon_2);

%% Power analysis
power_analysis(ambiguity_med_1_mon_1)
%% Figure 1 - Risk Correlations
figure;
subplot_titles = {'Med Phase 1 vs Med Phase 2', 'Mon Phase 1 vs Mon Phase 2', ...
    'Med Phase 1 vs Mon Phase 1', 'Med Phase 2 vs Mon Phase 2'};
risk_data_pairs = {risk_med_1_med_2; risk_mon_1_mon_2; risk_med_1_mon_1; risk_med_2_mon_2};

for i = 1:4
    subplot(2, 2, i);
    x = risk_data_pairs{i}(:, 1);
    y = risk_data_pairs{i}(:, 2);
    scatter(x, y);
    hold on;
    lsline;
    corr_coeff = corr(x, y, 'rows', 'complete');
    n_participants = length(x);
    title(sprintf('%s, r = %.2f, n = %d', subplot_titles{i}, corr_coeff, n_participants));
    xlabel('Risk Attitude (X)');
    ylabel('Risk Attitude (Y)');
    hold off;
end
sgtitle('Figure 1 - Risk Correlations');

%% Figure 2 - Ambiguity Correlations
figure;
subplot_titles = {'Med Phase 1 vs Med Phase 2', 'Mon Phase 1 vs Mon Phase 2', ...
    'Med Phase 1 vs Mon Phase 1', 'Med Phase 2 vs Mon Phase 2'};
ambiguity_data_pairs = {ambiguity_med_1_med_2; ambiguity_mon_1_mon_2; ...
    ambiguity_med_1_mon_1; ambiguity_med_2_mon_2};

for i = 1:4
    subplot(2, 2, i);
    x = ambiguity_data_pairs{i}(:, 1);
    y = ambiguity_data_pairs{i}(:, 2);
    scatter(x, y);
    hold on;
    lsline;
    corr_coeff = corr(x, y, 'rows', 'complete');
    n_participants = length(x);
    title(sprintf('%s, r = %.2f, n = %d', subplot_titles{i}, corr_coeff, n_participants));
    xlabel('Ambiguity Attitude (X)');
    ylabel('Ambiguity Attitude (Y)');
    hold off;
end
sgtitle('Figure 2 - Ambiguity Correlations');

%% Power analysis - minimal n for 80% significant correlation in ambiguity_med_1_mon_1
n_range = 10:10:150;

ambiguity_med_1_mon_1
%% Figure 3 - Risk vs Ambiguity within Phases
figure;
subplot_titles = {'Risk vs Ambiguity - Med Phase 1', 'Risk vs Ambiguity - Med Phase 2', ...
    'Risk vs Ambiguity - Mon Phase 1', 'Risk vs Ambiguity - Mon Phase 2'};

% Extract risk and ambiguity data within each phase using common participants
risk_vs_ambiguity_pairs = { ...
    get_common_data(attitudes_med_1, attitudes_med_1), ambiguity_med_1_med_2(:,1); ...
    get_common_data(attitudes_med_2, attitudes_med_2), ambiguity_med_1_med_2(:,2); ...
    get_common_data(attitudes_mon_1, attitudes_mon_1), ambiguity_mon_1_mon_2(:,1); ...
    get_common_data(attitudes_mon_2, attitudes_mon_2), ambiguity_mon_1_mon_2(:,2)};

for i = 1:4
    subplot(2, 2, i);
    x = risk_vs_ambiguity_pairs{i, 1}(:, 1);  % Risk data
    y = risk_vs_ambiguity_pairs{i, 2};        % Ambiguity data
    scatter(x, y);
    hold on;
    lsline;
    corr_coeff = corr(x, y, 'rows', 'complete');
    n_participants = length(x);
    title(sprintf('%s, r = %.2f, n = %d', subplot_titles{i}, corr_coeff, n_participants));
    xlabel('Risk Attitude');
    ylabel('Ambiguity Attitude');
    hold off;
end
sgtitle('Figure 3 - Risk vs Ambiguity Correlations');

end
