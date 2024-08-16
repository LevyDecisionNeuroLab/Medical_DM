function import_raw_data()
% Define data file to hold all the participants dat
data_file_path = fullfile('Medical_DM_data', 'combined_data.mat');

% Check if data file already exists
if exist(data_file_path, 'file') == 2
    % If the file exists, load the data
    load(data_file_path);
else
    % If the file does not exist, run the import functions
    monetary_phase_1 = Medical_DM_data_import_phase_1_moentary();
    medical_phase_1 = Medical_DM_data_import_phase_1_medical();
    monetary_phase_2 = Medical_DM_data_import_phase_2_moentary();
    medical_phase_2 = Medical_DM_data_import_phase_2_medical();

    % Save all variables into the data file
    save(data_file_path, 'monetary_phase_1', 'medical_phase_1', 'monetary_phase_2', 'medical_phase_2');
end
    % Assign the variables to the caller workspace
    assignin('caller', 'monetary_phase_1', monetary_phase_1);
    assignin('caller', 'medical_phase_1', medical_phase_1);
    assignin('caller', 'monetary_phase_2', monetary_phase_2);
    assignin('caller', 'medical_phase_2', medical_phase_2);
end

