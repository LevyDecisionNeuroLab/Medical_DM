function power_analysis(ambiguity_med_1_mon_1)
% SUBSAMPLE_SIGNIFICANCE_SIMULATION calculates the proportion of significant
% correlations for subsamples of varying sizes (k=10:10:100) from ambiguity_med_1_mon_1.

% Define parameters for the simulation
sample_sizes = 10:10:100; % Sample sizes to test
num_simulations = 1000;   % Number of simulations per sample size
alpha = 0.05;             % Significance level

% Initialize array to store the proportion of significant correlations
proportion_significant = zeros(length(sample_sizes), 1);

% Loop over each sample size
for i = 1:length(sample_sizes)
    k = sample_sizes(i);   % Current sample size
    significant_count = 0; % Counter for significant correlations
    
    % Perform simulations
    for j = 1:num_simulations
        % Sample k rows with replacement from ambiguity_med_1_mon_1
        subsample = datasample(ambiguity_med_1_mon_1, k, 'Replace', true);
        
        % Calculate correlation and p-value between the two columns
        [~, p] = corr(subsample(:, 1), subsample(:, 2));
        
        % Check if the correlation is significant
        if p < alpha
            significant_count = significant_count + 1;
        end
    end
    
    % Calculate the proportion of significant results for this sample size
    proportion_significant(i) = significant_count / num_simulations;
end

% Plot the proportion of significant correlations for each sample size
figure;
plot(sample_sizes, proportion_significant, '-o', 'LineWidth', 1.5);
hold on;
yline(0.80, '--r', '80% Threshold');
xlabel('Sample Size (k)');
ylabel('Proportion of Significant Simulations');
title('Proportion of Significant Correlations vs. Sample Size');
grid on;
hold off;

end
