function save_current_figure(directory, filename)
    % Function to save the current figure as an SVG file in the specified directory.
    % Inputs:
    %   directory - The directory where the SVG file should be saved.
    %   filename  - The name of the SVG file (without extension).

    % Ensure the directory exists, if not, create it
    if ~exist(directory, 'dir')
        mkdir(directory);
    end

    % Create the full file path
    filepath = fullfile(directory, [filename, '.svg']);

    % Save the current figure as an SVG file
    saveas(gcf, filepath, 'svg');
end
