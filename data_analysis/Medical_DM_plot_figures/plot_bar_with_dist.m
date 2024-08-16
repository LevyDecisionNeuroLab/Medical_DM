function plot_bar_with_dist(x, y, side, color)
    % x: x-coordinate for the bar plot
    % y: vector of y-coordinates
    % side: 'left' or 'right' for the density plot placement
    % color: color for the bar and density plot (e.g., [0.5, 0.2, 0.8])

    % Calculate the mean and standard error of the mean
    y_mean = mean(y);
    y_sem = std(y) / sqrt(length(y));

    % Create a figure
    hold on;

    % Plot the bar with mean value and set transparency
    % bar(x, y_mean, 'FaceColor', color, 'EdgeColor', 'k', 'FaceAlpha', 0.7, 'LineWidth',0.1);


    % Add jitter to the x-values for the scatter plot
    jitter_amount = 0.5; % Amount of jitter, adjust as needed
    x_shift = 0.1; % Amount of shift, adjust as needed

    if strcmpi(side, 'right')
        x_shift = -1 * x_shift;
    end

    x_jittered = x_shift + x + jitter_amount * (rand(size(y)) - 0.5);
    y_jittered = y + 0.00 * (rand(size(y)) - 0.5);

    % % Plot black dots with jitter
    % scatter(x_jittered, y, 20, 'k', 'filled', 'MarkerFaceAlpha', 0.35);
    scatter(x_jittered, y_jittered, 20, 'k', 'filled', 'MarkerFaceAlpha', 0.35);

    % Determine the position of the density plot
    density_offset = 0.5; % Offset for density plot placement
    density_alpha = 0.5;  % Transparency of the density plot

    % Calculate the density (kernel density estimate)
    % [density, y_values] = ksdensity(y,0:0.01:1, 'Bandwidth', std(y)/1);
    [density, y_values] = ksdensity(y,linspace(min(y), max(y), 3), 'Bandwidth', std(y)/1);
    density = density./3; % Histogram normalization
    

    % Adjust x position for the density plot
    if strcmpi(side, 'left')
        density_x = x - density_offset * density; % Mirror and position on the left
    elseif strcmpi(side, 'right')
        density_x = x + density_offset * density; % Position on the right
    else
        error('Invalid value for "side". Use "left" or "right".');
    end

    % Plot the density as a filled area plot
    fill([x * ones(size(density_x)), density_x], [flip(y_values), y_values], color, ...
        'FaceAlpha', density_alpha, 'EdgeColor', 0.5*[1 1 1], 'LineWidth',0.1);

    % Plot the error bar
    MARKER_COLOR = 0.1.*[1 1 1];
    ERROR_BAR_COLOR = [153, 14, 5]./255; %0.6.*[1 1 1];
    % errorbar(x, y_mean, y_sem, 'Color', ERROR_BAR_COLOR, 'LineWidth', 2, 'marker', '_','MarkerFaceColor', MARKER_COLOR, 'MarkerEdgeColor', MARKER_COLOR, 'MarkerSize',10);
    errorbar(x, y_mean, y_sem, 'Color', ERROR_BAR_COLOR, 'LineWidth', 3);
    hold off;
end
