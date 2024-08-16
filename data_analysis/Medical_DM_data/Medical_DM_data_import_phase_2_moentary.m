function phase2monetary = importfile(filename, dataLines)
%IMPORTFILE Import data from a text file
%  PHASE2MONETARY = IMPORTFILE(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the data as a table.
%
%  PHASE2MONETARY = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  phase2monetary = importfile("\Medical_DM_data\phase2_monetary.csv", [2, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 05-Aug-2024 20:37:41

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [2, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 50);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["VarName1", "Mon_Risk_50_500_R", "Mon_Ambig_50_800_R", "Mon_Risk_50_1200_R", "Mon_Risk_25_2500_R", "Mon_Ambig_50_2500_R", "Mon_Ambig_74_500_B", "Mon_Risk_25_800_B", "Mon_Risk_75_800_B", "Mon_Ambig_50_800_B", "Mon_Risk_50_1200_B", "Mon_Ambig_24_1200_B", "Mon_Risk_25_2500_B", "Mon_Ambig_100_2500_G", "Mon_Risk_25_500_R", "Mon_Risk_25_800_R", "Mon_Risk_75_800_R", "Mon_Ambig_100_800_G", "Mon_Risk_75_1200_R", "Mon_Ambig_24_1200_R", "Mon_Ambig_100_2500_G1", "Mon_Ambig_100_500_G", "Mon_Ambig_100_800_G1", "Mon_Ambig_74_1200_B", "Mon_Risk_50_2500_B", "Mon_Risk_75_2500_B", "Mon_Risk_75_500_R", "Mon_Ambig_24_800_R", "Mon_Ambig_74_1200_R", "Mon_Ambig_100_1200_G", "Mon_Risk_75_2500_R", "Mon_Ambig_50_500_B", "Mon_Ambig_74_800_B", "Mon_Ambig_100_1200_G1", "Mon_Ambig_24_2500_B", "Mon_Ambig_50_2500_B", "Mon_Ambig_74_2500_B", "Mon_Ambig_24_500_R", "Mon_Risk_50_800_R", "Mon_Ambig_74_800_R", "Mon_Risk_25_1200_R", "Mon_Ambig_50_1200_R", "Mon_Risk_50_2500_R", "Mon_Ambig_24_2500_R", "Mon_Ambig_74_2500_R", "Mon_Risk_50_800_B", "Mon_Ambig_24_800_B", "Mon_Risk_25_1200_B", "Mon_Risk_75_1200_B", "Mon_Ambig_50_1200_B"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
phase2monetary = readtable("Medical_DM_data\phase2_monetary.csv", opts);

end