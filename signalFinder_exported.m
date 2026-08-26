classdef signalFinder_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        SignalFinderUIFigure         matlab.ui.Figure
        SpecSettingsButton           matlab.ui.control.Button
        GridLayout                   matlab.ui.container.GridLayout
        VersionLabel                 matlab.ui.control.Label
        InputGrid                    matlab.ui.container.GridLayout
        ModeButtonGroup              matlab.ui.container.ButtonGroup
        AmbientButton                matlab.ui.control.RadioButton
        DiscreteButton               matlab.ui.control.RadioButton
        SkipAmbientCheckBox          matlab.ui.control.CheckBox
        AnalysisSettingsPanel        matlab.ui.container.Panel
        AnalysisSettingsGrid         matlab.ui.container.GridLayout
        ReferenceLevelDropDown       matlab.ui.control.DropDown
        ReferenceLevelDropDownLabel  matlab.ui.control.Label
        UnitDropDown                 matlab.ui.control.DropDown
        DownSampCheckBox             matlab.ui.control.CheckBox
        DownSampField                matlab.ui.control.NumericEditField
        SpectrogramCheckBox          matlab.ui.control.CheckBox
        AmbientSettingsPanel         matlab.ui.container.Panel
        AmbientSettingsGrid          matlab.ui.container.GridLayout
        AmbFreqListBox               matlab.ui.control.ListBox
        AmbFreqListBoxLabel          matlab.ui.control.Label
        FreqAllButton                matlab.ui.control.Button
        FreqNoneButton               matlab.ui.control.Button
        DiscreteSettingsPanel        matlab.ui.container.Panel
        GridLayout3                  matlab.ui.container.GridLayout
        FilterDropDown               matlab.ui.control.DropDown
        FilterDropDownLabel          matlab.ui.control.Label
        MinLengthField               matlab.ui.control.NumericEditField
        MinLengthLabel               matlab.ui.control.Label
        MinGapField                  matlab.ui.control.NumericEditField
        MinGapLabel                  matlab.ui.control.Label
        UnitDropDownLabel            matlab.ui.control.Label
        FilePanel                    matlab.ui.container.Panel
        DiscreteButtonGrid           matlab.ui.container.GridLayout
        InputDiscreteTable           matlab.ui.control.Table
        AddDiscreteRowButton         matlab.ui.control.Button
        DeleteDiscreteRowButton      matlab.ui.control.Button
        SaveButton                   matlab.ui.control.Button
        LoadButton                   matlab.ui.control.Button
        OutputGrid                   matlab.ui.container.GridLayout
        OutputPathField              matlab.ui.control.EditField
        OutputPathLabel              matlab.ui.control.Label
        OutputPathSelect             matlab.ui.control.Button
        WarningLabel                 matlab.ui.control.Label
        AnalyzeButton                matlab.ui.control.Button
        ResultsGrid                  matlab.ui.container.GridLayout
        AmbientResultsPanel          matlab.ui.container.Panel
        AmbientResultsPanelGrid      matlab.ui.container.GridLayout
        AmbientResultsTabGroup       matlab.ui.container.TabGroup
        LZeqTab                      matlab.ui.container.Tab
        LZeqGrid                     matlab.ui.container.GridLayout
        LZeqAxes                     matlab.ui.control.UIAxes
        MSLTab                       matlab.ui.container.Tab
        MSLGrid                      matlab.ui.container.GridLayout
        MSLAxes                      matlab.ui.control.UIAxes
        StatTable                    matlab.ui.control.Table
        DiscreteResultsPanel         matlab.ui.container.Panel
        DiscreteResultsPanelGrid     matlab.ui.container.GridLayout
        DiscreteResultsTabGroup      matlab.ui.container.TabGroup
        WaveformuPaTab               matlab.ui.container.Tab
        WaveGrid                     matlab.ui.container.GridLayout
        WaveAxes                     matlab.ui.control.UIAxes
        WaveformdBTab                matlab.ui.container.Tab
        WavedBGrid                   matlab.ui.container.GridLayout
        WavedBAxes                   matlab.ui.control.UIAxes
        SpectrogramTab               matlab.ui.container.Tab
        SpecGrid                     matlab.ui.container.GridLayout
        CurrSpecTimeRes              matlab.ui.control.NumericEditField
        TimeResolutionLabel          matlab.ui.control.Label
        SpecAxes                     matlab.ui.control.UIAxes
        PSDTab                       matlab.ui.container.Tab
        PSDGrid                      matlab.ui.container.GridLayout
        PSDAxes                      matlab.ui.control.UIAxes
        SaveWaveButton               matlab.ui.control.Button
        ResultsButtonGrid            matlab.ui.container.GridLayout
        SplitRecButton               matlab.ui.control.Button
        SaveAllStatsButton           matlab.ui.control.Button
        SaveStatsButton              matlab.ui.control.Button
        GridLayout2                  matlab.ui.container.GridLayout
        FileListBox                  matlab.ui.control.ListBox
        FileListBoxLabel             matlab.ui.control.Label
    end

% Dependencies:
    %   Signal Processing Toolbox

    % dev note: to confirm the package dependencies, run:
    % >> [deps, plist] = matlab.codetools.requiredFilesAndProducts(name);
    % where name is the string of the file name. Only works for .m
    % files as far as I can tell so copy the whole code into a
    % temporary script and run the command on that

    % Compiled to standalone .exe with application compiler (applicationCompiler,
    % part of MATLAB Compiler toolbox)

    properties (Access = private)
        % default calibration curve for M20 particle motion sensor
        % sensFreq = {};
        % sensSens = {};
        % WaveIn = {};  % table for storing the recording waveform
        
        % "Path" -
        % "Filename" -
        % "WaveInRaw" -
        % "WaveIn" -
        % "AmbWaveform" -
        % "SR" -
        % "DownsampledSR" -
        % "Gain" -
        % "RemoveOffsetCheck" -
        % "CalMode" -
        % "CalFile" -
        % "CalCurve" -
        % "SigFreqU" -
        % "SigFreqStart" -
        % "SigFreqEnd" -
        % "SigFreqMid" -
        % "SigSens" -
        % "AmbFreq" -
        % "AmbSens" -
        % "Thresh" -
        % "SignalTable"

        version = "v1.3.0"

        %%
        % v1.3 - reconfigured table construction for discrete mode to make
        % sure types are assigned correctly
        %%


        tableColumnNames = [
            "Path", ...
            "Filename", ...
            "WaveInRaw", ...
            "WaveIn", ...
            "AmbWaveform", ...
            "SR", ...
            "DownsampledSR", ...
            "Gain", ...
            "RemoveOffsetCheck", ...
            "TimeOffset", ...
            "CalMode", ...
            "CalFile", ...
            "CalCurve", ...
            "SigFreqU", ...
            "SigFreqStart", ...
            "SigFreqEnd", ...
            "SigFreqMid", ...
            "SigSens", ...
            "AmbFreq", ...
            "AmbSens", ...
            "Thresh", ...
            "SignalTable", ...
            "Spectrogram", ...
            "PSD", ...
            "SpecTimeRes"
            ];
        vartypes = [
            "string", ...
            "string", ...
            "cell", ...
            "cell", ...
            "cell", ...
            "double", ...
            "double", ...
            "double", ...
            "logical", ...
            "double", ...
            "categorical", ...
            "string", ...
            "cell", ...
            "string", ...
            "double", ...
            "double", ...
            "double", ...
            "double", ...
            "double", ...
            "double", ...
            "double", ...
            "cell", ...
            "cell", ...
            "cell", ...
            "double",];

        % newDisplayRow = {'',0,0,true,'[100,200]',0,1.5};
        newRowCore = table;  % more fully defined in startupFcn()
        newRowWaveIn = table(0.0,0.0, 'VariableNames', {'Time','V'});
        % DEP newRowStatTableArray = array2table(double.empty(0,2));
        % DEP newRowAmbientWaveform = array2table(double.empty(0,2), 'VariableNames', {'Time','V'});
        CoreTable = struct;
        colNameTranslate = ["Path","Path";"SR","SR|(Hz)";
            "Gain","Gain|(dB)";"RemoveOffsetCheck","Remove|Offset";
            "TimeOffset","Start Time|Offset (s)"; "SigFreqU","Sig Freq|(Hz)";
            "SigFreqStart","Sig Freq|Start (Hz)";"SigFreqEnd","Sig Freq|End (Hz)";
            "SigSens","Sig|Sens";"Thresh","Thresh|(dB)"]
        recalcCols = ["SigFreqStart","SigFreqEnd", "SigFreqU","Path"]
        

        % Fields for CoreTable.SignalTable:
        % Discrete: RowName = SigNum, Onset, Offset, rms, peak, SNR, csel) 
        % Ambient: RowName = thirdOctBands, TOPL, MSL, maybe sigRMS and clipping)
        analysisHasRun = false;  % flag for determining when to block outputs and require reanalyzing
        %CalMode = categorical({'Auto'},{'Auto', 'Manual'},'Protected',true);  % calibration mode - either 'auto' for automatically determining sensitivities from calibration 
        % curve, or 'manual' for user entry of sensitivities
        AmbMode = "Whole file"; % ambient analysis mode - "whole file" to analyze the whole file, "Beginning" for it to automatically
        % grab 1 second of noise before first signal in file, or "manual" where user specifies start and duration
        AnalysisMode = "Discrete"; % analyze discrete sounds in file and report stats for each ("discrete") or "ambient" for 3rd octave
        % band analysis
        SpecWindow = 1000;  % default spectrogram window, in samples
        SpecNOverlap = 500;  % default spectrogram overlap, in samples
        SpecTimeRes = .5;  % default spectrogram time resolution, in sec
        signalTable = {};
        statTableArray = {};
        AmbientWaveform = {};
        calCurve = table('Size', [1 2], 'VariableTypes', {'double', 'double'}, 'VariableNames', {'Freq', 'Resp'});

        % audioCache = containers.Map(); % Key: file path, Value: audio data

        NumFiles = 0;  % number of files selected by user

        WorkingCount = 0;  % number of processes running to control when cursor should change to working vs arrow

        % for third octave analysis
        % thirdOctBands = [6.3 8 10 12.5 16 20 25 31.5 40 50 63 80 100 125 160 200 250 315 ...
        %     400 500 630 800 1000 1250 1600 2000 2500 3150 4000 5000 6300 ...
        %     8000 10000 12500 16000 20000 25000 31500 40000];
        % thirdOctBandE=[5.7 7.1 8.8 11.3 14.2 17.7 22.4 28.3 35.4 44.5 56.5 70.7 88.7 ...
        %     103 141 177 224 283 354 445 566 707 887 1130 1414 1770 2240 2830 ...
        %     3540 4450 5660 7070 8870 11300 14140 17700 22400 28300 35400 44500];
        % thirdOctBandW=[1.4 1.7 2.5 2.9 3.5 4.7 5.9 7.1 9.1 12 14.2 18 14.3 38 36 47 ...
        %     59 71 91 121 141 180 243 284 356 470 590 710 910 1210 1410 ...
        %     1800 2430 2840 3560 4700 5900 7100 9100];
        thirdOctBands = [6.3; 8; 10; 12.5; 16; 20; 25; 31.5; 40; 50; 63; ...
            80; 100; 125; 160; 200; 250; 315; 400; 500; 630; 800; 1000; ...
            1250; 1600; 2000; 2500; 3150; 4000; 5000; 6300; 8000; 10000; ...
            12500; 16000; 20000; 25000; 31500; 40000];
        thirdOctBandE=[5.7 7.1; 7.1 8.8; 8.8 11.3; 11.3 14.2; 14.2 17.7; ...
            17.7 22.4; 22.4 28.3; 28.3 35.4; 35.4 44.5; 44.5 56.5; ...
            56.5 70.7; 70.7 88.7; 88.7 103; 103 141; 141 177; 177 224; ...
            224 283; 283 354; 354 445; 445 566; 556 707; 707 887; ...
            887 1130; 1130 1414; 1414 1770; 1770 2240; 2240 2830; ...
            2830 3540; 3540 4450; 4450 5660; 5660 7070; 7070 8870; ...
            8870 11300; 11300 14140; 14140 17700; 17700 22400; ...
            22400 28300; 28300 35400; 35400 44500];
        thirdOctBandW=[1.4; 1.7; 2.5; 2.9; 3.5; 4.7; 5.9; 7.1; 9.1; 12; ...
            14.2; 18; 14.3; 38; 36; 47; 59; 71; 91; 121; 141; 180; 243; ...
            284; 356; 470; 590; 710; 910; 1210; 1410; 1800; 2430; 2840; ...
            3560; 4700; 5900; 7100; 9100];
        thirdOctTable = table();
            
    end
    
    methods (Static)
        % static methods/functions are those that work independently of the 
        % app. They only use the values passed in (input arguments) and the
        % code within the function, and return results without reading or
        % modifying app properties or UI elements.

        
    end
    
    methods (Access = private)
        
        function RefreshInputTable(app)
            % update the InputTable from the CoreTable
            % inputDiscreteCols = ["Path","SR","Remove Offset",...
            %     "Sig Freq Start","Sig Freq End","Sig Sens","Amb Thresh"];
            % [~, indices] = ismember(inputNames, app.colNameTranslate(:, 1));
            coreCols = ["Path", "SR", "Gain", "RemoveOffsetCheck", "TimeOffset", "SigFreqU", "SigSens", "Thresh"];
                %app.colNameTranslate(indices,1);
            app.InputDiscreteTable.Data = app.CoreTable{:,coreCols};

        end

        function [tableData, colIndex] = GetTable(app,col)
            % get the input table for updating
            % can accept column name or index
            if isnan(str2double(col))
                % col is a string, i.e. column name
                % get column index from name
                colNames = app.InputDiscreteTable.ColumnName;
                
                % startswith() can't be used on cell or a string array so
                % we have to loop through the names to find it
                for colIndex = 1:length(colNames)
                    if startsWith(colNames{colIndex}, col)
                        break
                    end
                    if colIndex == length(colNames)
                        % if we get here on the last index without a match,
                        % then there's no match
                        disp(['Column "', col, '" not found.']);
                    end
                end
            else
                colIndex = col;
            end

            % now actually update the table
            tableData = app.InputDiscreteTable.Data;
        end
        
        function UpdateInputTable(app,row,col,value)
            % update the input table
            % can accept column name or index
            [tableData, colIndex] = GetTable(app,col);
            tableData(row,colIndex) = value;
            app.InputDiscreteTable.Data = tableData;
        end
        
        function [value] = GetValue(app,row,col)
            % get value from input table, given row and column (via name or
            % index)
            [tableData, colIndex] = GetTable(app,col);
            
            value = tableData{row,colIndex};
        end

        function [value] = GetCurrentRow(app)
            % get currently selected row from input table
            
            selection = app.InputDiscreteTable.Selection;
            if isempty(selection)
                % if nothing selected, get from file list box
                listValue = app.FileListBox.Value;
                items = app.CoreTable.("Filename");
                value = find(items==listValue);
            else
                value = app.InputDiscreteTable.Selection(1);
            end
        end

        function AddNewRow(app, row)
            % add new row to CoreTable, then push to InputDiscreteTable
            % (instead of updating both tables separately)
            % 
           
            if app.NumFiles == 0
                % for creating first row
                app.CoreTable = app.newRowCore;
            else
                if ~exist('row','var') || row > app.NumFiles || row == 0
                    % default to last row if row wasn't entered or outside of range
                    row = app.NumFiles;
                end

                app.CoreTable = [
                    app.CoreTable(1:row, :);
                    app.newRowCore;
                    app.CoreTable(row+1:end, :)]; 
            end

            app.NumFiles = app.NumFiles + 1;
            RefreshInputTable(app);
        end
        
        function HighlightInputRow(app, row)
            tbl = app.InputDiscreteTable;
            addStyle(tbl,uistyle("BackgroundColor","white"));
            addStyle(tbl,uistyle("BackgroundColor","#FFFFAA"),"row",row);
        end

        function UpdateFreqs(app,row)
            freqRangeU = app.CoreTable.('SigFreqU')(row);
            freqRange = str2double(regexp(freqRangeU, '\d+', 'match'));
            if isscalar(freqRange)
                low = freqRange;
                med = freqRange;
                high = freqRange;
            elseif length(freqRange) == 2
                low = min(freqRange);
                high = max(freqRange);
                med = 10^((log10(low)+log10(high))/2);
            end
            
            % if filtering to 1/3 octave around specified freq range
            filterMode = app.FilterDropDown.Value;
            if strcmpi(filterMode, '3rd oct')
                low=(low)/(2^(1/2))^(1/3);
                high=(high)*(2^(1/2))^(1/3);
                med = 10^((log10(low)+log10(high))/2);
            end
            app.CoreTable.SigFreqStart(row) = low;
            app.CoreTable.SigFreqMid(row) = med;
            app.CoreTable.SigFreqEnd(row) = high;
            
        end
        
        function UpdateFilenames(app, row)
            path = app.CoreTable.Path(row);
            % app.CoreTable.Path(row) = path;
            [~, filename, ~] = fileparts(path);
            app.CoreTable.Filename(row) = filename;
            app.FileListBox.Items = app.CoreTable.('Filename');
        end

        function AnalyzeEnable(app)
            % ARNOTE: Update to run with multiple files
            % check that all required fields are filled, and if so, enable the Analyze button. Otherwise disable it so it
            % can't be run without all required fields

            % Required variables: 
            % Filename, WaveIn, SR, Gain, RemoveOffsetCheck,
            % SigFreqStart, SigFreqEnd, SigFreqMid, SigSens, AmbFreq,
            % AmbSens, Thresh
            data = app.CoreTable(:,["Filename", "SR", ...
                "Gain", "RemoveOffsetCheck", "TimeOffset", "SigFreqStart", ...
                "SigFreqEnd", "SigFreqMid", ...
                "SigSens", "AmbFreq", "AmbSens", "Thresh"]);
            % waveInCheck = app.CoreTable.WaveInRaw;

            % check that height of each element of waveInCheck is > SR
            %data(:,colIndex) = [];
            % missingData = cellfun(@isempty,data);

            % check filenames
            if min(strlength(data.Filename)) == 0
                HandleValidationIssue(app,'Missing filenames')
                return
            end

            % SR > 0
            if nnz(~data.SR) > 0 
                HandleValidationIssue(app,'Sampling Rate cannot be 0')
                return
            end

            % sigSens > 0
            if nnz(~data.SigSens) > 0
            
                HandleValidationIssue(app,'Sig Sens cannot be 0')
                return
            end

            if app.DownSampCheckBox.Value == 1
                if app.DownSampField == 0
                    HandleValidationIssue(app,'Target frequency for downsampling cannot be 0')
                    return
                end
            end

            % % WaveIn > 1000 samples, with 1000 being a reasonable minimum that accommodates for a low SR
            % if min(cellfun(@(c) height(c), waveInCheck)) < 1000 
            %     HandleValidationIssue(app,'Waveforms not loaded or missing')
            %     return
            % end

            HandleValidationIssue(app)
            % if fail
            %     app.AnalyzeButton.Enable = "off";
            %     app.AnalyzeButton.Text = "Analysis Unavailable";
            % else
            %     app.AnalyzeButton.Enable = "on";
            %     app.AnalyzeButton.Text = "Analyze";
            % end
        end

        function HandleValidationIssue(app, message)
            if nargin == 1 || isempty(message)
                app.AnalyzeButton.Enable = "on";
                app.AnalyzeButton.Text = "Analyze";
            else
                warndlg(message)
                app.AnalyzeButton.Enable = "off";
                app.AnalyzeButton.Text = "Analysis Unavailable";
            end
        end
        
        function UpdateWarning(app, message)
            % update warning text box or turn it off (if no message)
            if nargin == 1
                message = '';
            end
            app.WarningLabel.Text = message;
            if isempty(message)
                app.WarningLabel.Visible = "off";
            else
                app.WarningLabel.Visible = "on";
                drawnow
            end
        end
        
        function BlockOutput(app, mode)
            % whenever an input value is changed and analysis has been run previously, pop up a note over the results making
            % user rerun analysis because results won't match parameters automatically
            if mode
                % if block is true, i.e. if parameter has changed
                if app.analysisHasRun
                    UpdateWarning(app,"Parameters changed, re-run analysis for updated results")
                    % app.StatTable.Enable = "off";
                    app.SaveStatsButton.Enable = "off";
                    app.SaveAllStatsButton.Enable = "off";
                    app.SaveWaveButton.Enable = "off";
                    app.SplitRecButton.Enable = "off";
                    app.SpecSettingsButton.Enable = "off";
                    app.FileListBox.Enable = "off";
                end
            else
                % unblock the displays
                UpdateWarning(app)
                % app.StatTable.Enable = "on";
                app.SaveStatsButton.Enable = "on";
                app.SaveAllStatsButton.Enable = "on";
                app.SaveWaveButton.Enable = "on";
                app.SplitRecButton.Enable = "on";
                app.SpecSettingsButton.Enable = "on";
                app.FileListBox.Enable = "on";
            end
        end

        function UpdateCalibration(app, row)
            % import new calibration data and update sensitivities
            path = app.InputDiscreteTable.('Cal File')(row);
            temp = readtable(path);
            tempTable = table(table2array(temp(:,1)), ...
                table2array(temp(:,2)), 'VariableNames', ["Freq", "Sens"]);
            app.CoreTable.CalCurve{row} = tempTable;
            % app.sensSens{row} = table2array(temp(:,2));
            % % Not supported for UItables
            % app.SigFreqField.Limits = [min(app.sensFreq), max(app.sensFreq)];
            % app.AmbFreqField.Limits = [min(app.sensFreq), max(app.sensFreq)];
            
            % update sensitivities
            UpdateSigCal(app, row)
            UpdateAmbCal(app, row)

        end
        
        function UpdateSigCal(app, row)
            % update sensitivity for signal frequency
            calMode = app.CoreTable.('CalMode')(row);
            if strcmpi(calMode, 'auto')
                sigFreq = GetValue(app,row,'Sig Freq');
                if sigFreq < min(app.CoreTable{row}.CalCurve.Freq) || sigFreq > max(app.CoreTable(row,:).CalCurve.Freq)
                    UpdateWarning(app,'Calibration error: Signal frequency outside of calibration range');
                else
                    sigSens = interp1(log(app.CoreTable(row,:).CalCurve.Freq), app.CoreTable(row,:).CalCurve.Sens, log(sigFreq));
                    UpdateInputTable(app,row,'Sig|Sens', sigSens);
                end
            end
        end
        
        function UpdateAmbCal(app, row)
            % update sensitivity for ambient frequency
            calMode = app.CoreTable.('CalMode')(row);
            if strcmpi(calMode, 'auto')
                ambFreq = GetValue(app,row,'Amb Freq');
                if ambFreq < min(app.CoreTable(row,:).CalCurve.Freq) || ambFreq > max(app.CoreTable(row,:).CalCurve.Freq)
                    UpdateWarning(app,'Calibration error: Ambient frequency outside of calibration range');
                else
                    ambSens = interp1(log(app.CoreTable(row,:).CalCurve.Freq), app.CoreTable(row,:).CalCurve.Sens, log(ambFreq));
                    UpdateInputTable(app,row,'Amb|Sens', ambSens);
                end
            end
        end

        function UpdateWav(app,row)
            % get list of files from WavFileField

            % import waveform and fill WaveIn table
            wavPath = app.CoreTable.Path(row);

            [~,~,wavType] = fileparts(wavPath);
            if strcmpi(wavType,'.wav')
                info = audioinfo(wavPath);
                app.CoreTable.SR(row) = info.SampleRate;
                % [waveIn, fs] = audioread(wavPath);
                % UpdateInputTable(app,row,'SR',fs);
                % app.CoreTable.SR(row) = fs;
                % dt = 1/fs;
                % timeVec = 0:dt:dt*(length(waveIn)-1);
                % % waveTemp = [timeVec', waveIn];
                % %app.CoreTable(row,:).WaveIn = table(timeVec',waveIn, 'VariableNames', ["Time", "V"]);
                % app.CoreTable.WaveInRaw{row} = table(timeVec',waveIn, 'VariableNames', ["Time", "V"]);
                
            elseif strcmpi(wavType,'.txt')
                % handling for txt files, which should be exported from the LabVIEW interface for particle motion. Only
                % works if files are formatted as expected, with 5 lines of info before actual data starts, and with the
                % dt on the third line
                waveIn = readtable(wavPath, 'HeaderLines', 5, 'Format', '%{MM/dd/uuuu HH:mm:ss.SSSSSS}D\t%f');
                waveIn.Properties.VariableNames = {'Time', 'V'};

                % get fs separately - this only works if the files are formatted as expected, with the dt on the third line
                % otherwise probably need to just clear the Fs field
                fileID = fopen(wavPath,'r');
                fgetl(fileID);  % skip first line
                fgetl(fileID);  % skip second line
                dtString = fgetl(fileID);
                dt = strsplit(dtString);
                dt = str2double(dt{end});
                fs = 1/dt;
                % UpdateInputTable(app,row,'SR',fs);
                app.CoreTable.SR(row) = fs;
                fclose(fileID);
                % timeVec = 0:dt:dt*(height(waveIn)-1);
                % waveTemp = [timeVec', waveIn];
                app.CoreTable.WaveInRaw{row} = waveIn;
            else
                %% Doesn't work yet- need to account for possible formats of csv values %%
                % handling for csv files - only works if files are formatted as expected, with 5 lines of info before actual
                % csv starts, and with the dt on the third line
                waveIn = readtable(wavPath, 'Format','%{mm:ss.SSSSSS}D\t%f');
                waveIn.Properties.VariableNames = {'Time', 'V'};
                % get fs separately - this only works if the files are formatted as expected, with the dt on the third line
                % otherwise probably need to just clear the Fs field
                dt = seconds(waveIn.Time(2) - waveIn.Time(1));
                fs = 1/dt;
                % UpdateInputTable(app,row,'SR',fs);
                app.CoreTable.('SR')(row) = fs;
                app.CoreTable.WaveInRaw{row} = waveIn;

            end


            % update sig frequency from name, then sensitivity
            [~,filename] = fileparts(wavPath);  % get filename
            try
                freqStr = regexp(filename,'(\d*)(?:\s?Hz)','tokens');  % regex to get number right before Hz
                freq = str2double(freqStr{1}{1});
                if freq > 0
                    UpdateInputTable(app,row,'Sig Freq',freq);
                    UpdateSigCal(app)
                end
            catch
                UpdateWarning(app,'Unable to determine signal frequency automatically.')
                %UpdateTable(app,row,'Sig Freq',10);
            end
            RefreshInputTable(app);
            figure(app.SignalFinderUIFigure)
        end

        function SpecSettingsPopup(app, row)
            % targetFig is uiaxes object to be exported
            % outPath is optional value for path
            %% layout setup
            columnWidth = {100, 80};
            windowWidth = sum([columnWidth{:}]) + (length(columnWidth)+1)*10;

            windowHeight = 136+10;
            % windowWidth = 404;
            windowX = app.SignalFinderUIFigure.Position(1) + app.SignalFinderUIFigure.Position(3)/2 - windowWidth/2;
            windowY = app.SignalFinderUIFigure.Position(2) + app.SignalFinderUIFigure.Position(4)/2 - windowHeight/2;

            exportWindow = uifigure('WindowStyle','modal');
            exportWindow.Position = [windowX windowY windowWidth windowHeight];
            exportWindow.Resize = 'off';

            % Create GridLayout
            SaveGrid = uigridlayout(exportWindow);
            SaveGrid.ColumnWidth = columnWidth;
            SaveGrid.RowHeight = {22, 'fit', 'fit', 'fit'};

            % Create SpecWindowLabel
            SpecWindowLabel = uilabel(SaveGrid);
            SpecWindowLabel.HorizontalAlignment = 'right';
            SpecWindowLabel.Layout.Row = 1;
            SpecWindowLabel.Layout.Column = 1;
            SpecWindowLabel.Text = 'Spec Window';

            % Create SpecWindowField
            SpecWindowField = uieditfield(SaveGrid, 'numeric');
            SpecWindowField.Limits = [0 Inf];
            SpecWindowField.ValueDisplayFormat = '%11.2f ms';
            SpecWindowField.Layout.Row = 1;
            SpecWindowField.Layout.Column = 2;
            SpecWindowField.Value = app.SpecWindow*1000/app.CoreTable.DownsampledSR(row);

            % Create NOverlapLabel
            NOverlapLabel = uilabel(SaveGrid);
            NOverlapLabel.HorizontalAlignment = 'right';
            NOverlapLabel.Layout.Row = 2;
            NOverlapLabel.Layout.Column = 1;
            NOverlapLabel.Text = 'Spec Overlap';

            % Create NOverlapField
            NOverlapField = uieditfield(SaveGrid, 'numeric');
            NOverlapField.Limits = [0 Inf];
            NOverlapField.RoundFractionalValues = 'on';
            NOverlapField.ValueDisplayFormat = '%11.2f ms';
            NOverlapField.Layout.Row = 2;
            NOverlapField.Layout.Column = 2;
            NOverlapField.Value = app.SpecNOverlap*1000/app.CoreTable.DownsampledSR(row);

            % Create TimeResLabel
            TimeResLabel = uilabel(SaveGrid);
            TimeResLabel.HorizontalAlignment = 'right';
            TimeResLabel.Layout.Row = 3;
            TimeResLabel.Layout.Column = 1;
            TimeResLabel.Text = 'Time Resolution';

            % Create TimeResField
            TimeResField = uieditfield(SaveGrid, 'numeric');
            TimeResField.Limits = [0 Inf];
            TimeResField.RoundFractionalValues = 'on';
            TimeResField.ValueDisplayFormat = '%11.2f s';
            TimeResField.Layout.Row = 3;
            TimeResField.Layout.Column = 2;
            TimeResField.Value = app.SpecTimeRes;
            
            % Create OKButton
            ExportButton = uibutton(SaveGrid, 'push');
            ExportButton.ButtonPushedFcn = @OKButtonPushed;
            ExportButton.Layout.Row = 4;
            ExportButton.Layout.Column = 1;
            ExportButton.Text = 'OK';
            
            % Create CancelButton
            CancelButton = uibutton(SaveGrid, 'push');
            CancelButton.ButtonPushedFcn = @CancelButtonPushed;
            CancelButton.Layout.Row = 4;
            CancelButton.Layout.Column = 2;
            CancelButton.Text = 'Cancel';


            function OKButtonPushed(~,~)
                spectroWindow = SpecWindowField.Value;
                spectroOverlap = NOverlapField.Value;
                timeRes = TimeResField.Value;
                delete(exportWindow)
                app.SpecSettingsUpdate(spectroWindow, spectroOverlap, timeRes, row);
                
            end

            function CancelButtonPushed(~,~)
                delete(exportWindow)
            end

        end

        function SpecSettingsUpdate(app, window, noverlap, timeres, row)
            CursorWait(app, 'on')
            % update spectrogram settings from popup window
            app.SpecWindow = round(app.CoreTable.DownsampledSR(row)*window/1000);
            app.SpecNOverlap = round(app.CoreTable.DownsampledSR(row)*noverlap/1000);
            app.SpecTimeRes = timeres;
            SpectrogramUpdate(app, row)
            SpectrogramPlot(app, row)
            % BlockOutput(app, true)
            % AnalyzeEnable(app)
            CursorWait(app, 'off')
        end

        function SpectrogramUpdate(app, row)
            
            
            % MATLAB does NOT like plotting a spectrogram in a target
            % window so we have to be roundabout and plot the data
            % directly:
            % https://www.mathworks.com/matlabcentral/answers/369288-how-to-plot-spectrogram-on-matlab-app-designer-with-uiaxes
            % Note the answer refers to the spectrogram function, but same
            % principle applies to pspectrum
            % [s,f,t] = spectrogram(app.CoreTable.WaveIn{row}.VFilt,app.SpecWindow,app.SpecNOverlap,[],fs);
            if app.SpectrogramCheckBox.Value
                fs = app.CoreTable.DownsampledSR(row);
                timeRes = app.CoreTable.SpecTimeRes(row);
                [s,f,t] = pspectrum(app.CoreTable.WaveIn{row}.uPaFilt, fs, ...
                    'spectrogram','TimeResolution', timeRes, ...
                    'FrequencyLimits', [app.CoreTable.SigFreqStart(row)/2 app.CoreTable.SigFreqEnd(row)*2],'OverlapPercent',99,'Leakage',1);
                app.CoreTable.Spectrogram{row}.s = s;
                app.CoreTable.Spectrogram{row}.f = f;
                app.CoreTable.Spectrogram{row}.t = t;
            end

        end

        function SpectrogramPlot(app, row)
            % plot the spectrogram - separate function so that, if settings are updated, it can be replotted without
            % rerunning the whole analysis
            
            if app.SpectrogramCheckBox.Value
                % MATLAB does NOT like plotting a spectrogram in a target
                % window so we have to be roundabout and plot the data
                % directly:
                % https://www.mathworks.com/matlabcentral/answers/369288-how-to-plot-spectrogram-on-matlab-app-designer-with-uiaxes
                % Note the answer refers to the spectrogram function, but same
                % principle applies to pspectrum
                % [s,f,t] = spectrogram(app.CoreTable.WaveIn{row}.VFilt,app.SpecWindow,app.SpecNOverlap,[],fs);
                s = app.CoreTable.Spectrogram{row}.s;
                f = app.CoreTable.Spectrogram{row}.f;
                t = app.CoreTable.Spectrogram{row}.t;
                % [s,f,t] = pspectrum(app.CoreTable.WaveIn{row}.VFilt, fs, ...
                %     'spectrogram','TimeResolution',app.SpecTimeRes, ...
                %     'FrequencyLimits', [sigFreqStart sigFreqEnd],'OverlapPercent',99,'Leakage',1);
                imagesc(app.SpecAxes,t,flipud(f),rot90(log(abs(s'))));  % plot log spectrum
                set(app.SpecAxes,'YDir', 'normal'); % flip the Y Axis because this method has it inverted
                set(app.SpecAxes, 'YTickMode', 'auto', 'YTickLabelMode', 'auto', ...
                    'XTickMode', 'auto', 'XLimMode', 'auto', 'XScale', 'linear')

                % make sure x-axis is not overextended
                xlim(app.SpecAxes,[0,max(app.CoreTable.WaveIn{row}.Time)]);


                % ylim(app.SpecAxes,[f1,f2]);

                % xlabel(app.SpecAxes, 'Time (s)')
                % ylabel(app.SpecAxes, 'Frequency (Hz)')
            end
        end
        
        function WaveformPlot(app, row)
            % plot the waveform in µPa
            plot(app.WaveAxes,app.CoreTable.WaveIn{row}.Time,app.CoreTable.WaveIn{row}.uPaFilt,'Color','k');
            
            % make sure x-axis is set to the correct boundaries
            xlim(app.WaveAxes,[0,max(app.CoreTable.WaveIn{row}.Time)]);

            Fs = app.CoreTable.DownsampledSR(row);
            
            % ambientWaveform = app.CoreTable.AmbWaveform{row};
            nSignals = height(app.CoreTable.SignalTable{row});
            thresh = app.CoreTable.Thresh(row);
            dBrefUnit = app.ReferenceLevelDropDown.Value;
            if strcmpi(dBrefUnit, "1 µPa")
                dBref = 1;
            else
                dBref = 20;
            end
            threshuPa = (10^(thresh/20))*dBref;

            % shade signal and ambient sections
            ylimits = ylim(app.WaveAxes);
            if app.SkipAmbientCheckBox.Value
                for i = 1:nSignals
                    patch(app.WaveAxes, ...
                        [app.CoreTable.SignalTable{row}.Onset(i)/Fs, ...
                        app.CoreTable.SignalTable{row}.Offset(i)/Fs, ...
                        app.CoreTable.SignalTable{row}.Offset(i)/Fs, ...
                        app.CoreTable.SignalTable{row}.Onset(i)/Fs], ...
                        [ylimits(1), ylimits(1), ylimits(2),ylimits(2)], ...
                        [0.6,0.6,0.6], 'EdgeColor','none')
                end
            else 
                patch(app.WaveAxes, ...
                [app.CoreTable.SignalTable{row}.Onset(1)/Fs, ...
                    app.CoreTable.SignalTable{row}.Offset(1)/Fs, ...
                    app.CoreTable.SignalTable{row}.Offset(1)/Fs, ...
                    app.CoreTable.SignalTable{row}.Onset(1)/Fs], ...
                [ylimits(1), ylimits(1), ylimits(2),ylimits(2)], ...
                [0.8,0.8,0.8], 'EdgeColor','none')
                for i = 2:nSignals
                    patch(app.WaveAxes, ...
                        [app.CoreTable.SignalTable{row}.Onset(i)/Fs, ...
                        app.CoreTable.SignalTable{row}.Offset(i)/Fs, ...
                        app.CoreTable.SignalTable{row}.Offset(i)/Fs, ...
                        app.CoreTable.SignalTable{row}.Onset(i)/Fs], ...
                        [ylimits(1), ylimits(1), ylimits(2),ylimits(2)], ...
                        [0.6,0.6,0.6], 'EdgeColor','none')
                end
            end

            % reorder plots so line is on top of shading
            % https://www.mathworks.com/matlabcentral/answers/8350-how-send-to-back-patch-objects-in-a-graph
            set(app.WaveAxes,'children',flipud(get(app.WaveAxes,'children')));
            yline(app.WaveAxes, threshuPa);

            % make sure x-axis is not overextended
            xlim(app.WaveAxes,[0,max(app.CoreTable.WaveIn{row}.Time)]);

            set(app.WaveAxes, 'YTickMode', 'auto', 'YTickLabelMode', 'auto', ...
                'XTickMode', 'auto', 'XScale', 'linear')
            
            %% repeat for dB plot
            plot(app.WavedBAxes,app.CoreTable.WaveIn{row}.Time,app.CoreTable.WaveIn{row}.dBFilt,'Color','k');

            xlim(app.WavedBAxes,[0,max(app.CoreTable.WaveIn{row}.Time)]);
            % shade signal and ambient sections
            ylimits = ylim(app.WavedBAxes);

            if app.SkipAmbientCheckBox.Value
                for i = 1:nSignals
                    patch(app.WavedBAxes, ...
                        [app.CoreTable.SignalTable{row}.Onset(i)/Fs, ...
                        app.CoreTable.SignalTable{row}.Offset(i)/Fs, ...
                        app.CoreTable.SignalTable{row}.Offset(i)/Fs, ...
                        app.CoreTable.SignalTable{row}.Onset(i)/Fs], ...
                        [ylimits(1), ylimits(1), ylimits(2),ylimits(2)], ...
                        [0.6,0.6,0.6], 'EdgeColor','none')
                end
            else 
                patch(app.WavedBAxes, ...
                [app.CoreTable.SignalTable{row}.Onset(1)/Fs, ...
                    app.CoreTable.SignalTable{row}.Offset(1)/Fs, ...
                    app.CoreTable.SignalTable{row}.Offset(1)/Fs, ...
                    app.CoreTable.SignalTable{row}.Onset(1)/Fs], ...
                [ylimits(1), ylimits(1), ylimits(2),ylimits(2)], ...
                [0.8,0.8,0.8], 'EdgeColor','none')
                for i = 2:nSignals
                    patch(app.WavedBAxes, ...
                        [app.CoreTable.SignalTable{row}.Onset(i)/Fs, ...
                        app.CoreTable.SignalTable{row}.Offset(i)/Fs, ...
                        app.CoreTable.SignalTable{row}.Offset(i)/Fs, ...
                        app.CoreTable.SignalTable{row}.Onset(i)/Fs], ...
                        [ylimits(1), ylimits(1), ylimits(2),ylimits(2)], ...
                        [0.6,0.6,0.6], 'EdgeColor','none')
                end
            end
            
            % reorder plots so line is on top of shading
            % https://www.mathworks.com/matlabcentral/answers/8350-how-send-to-back-patch-objects-in-a-graph
            set(app.WavedBAxes,'children',flipud(get(app.WavedBAxes,'children')));
            yline(app.WavedBAxes, thresh);

            % make sure x-axis is not overextended
            xlim(app.WavedBAxes,[0,max(app.CoreTable.WaveIn{row}.Time)]);

            set(app.WavedBAxes, 'YTickMode', 'auto', 'YTickLabelMode', 'auto', ...
                'XTickMode', 'auto', 'XScale', 'linear')

        end

        function PSDUpdate(app, row)
                
            fs = app.CoreTable.DownsampledSR(row);
            % pwelch uses the uPa waveform rather than the dB one
            [pxx,f]=pwelch(app.CoreTable.WaveIn{row}.uPaFilt,[],[],[],fs);
            app.CoreTable.PSD{row}.pxx = pxx;
            app.CoreTable.PSD{row}.f = f;
        end

        function PSDPlot(app, row)
            % 
            pxx = app.CoreTable.PSD{row}.pxx;
            f = app.CoreTable.PSD{row}.f;
            
            plot(app.PSDAxes,f,pow2db(pxx))

            set(app.PSDAxes, 'YTickMode', 'auto', 'YTickLabelMode', 'auto', ...
                'XTickMode', 'auto', 'XScale', 'linear', ...
                'XLimMode', 'auto')

        end
        
        function ThirdOctaveLZeqPlot(app, row)
            % First plot the LZeq in each third octave subband:
                xLimits = [
                    0.9*min(app.CoreTable.SignalTable{row}.Band(:)), ...
                    1.1*max(app.CoreTable.SignalTable{row}.Band(:))
                ];

                semilogx( ...
                    app.LZeqAxes, ...
                    app.CoreTable.SignalTable{row}.Band(:), ...
                    app.CoreTable.SignalTable{row}.LZeq(:), ...
                    's-','LineWidth',2); 
                set(app.LZeqAxes, 'YTickMode', 'auto', 'YTickLabelMode', 'auto', ...
                    'XTickMode', 'Manual', 'XTick', app.CoreTable.SignalTable{row}.Band(:), ...
                    'XLim', xLimits)
                
                % title(app.WaveAxes,'LZeq in Each Third Octave Subband')
                % xlabel(app.LZeqAxes,'Center Freq (Hz)');
                % ylabel(app.LZeqAxes,'LZeq (dB re 1uPa^2)');
        end
        
        function ThirdOctaveMSLPlot(app, row)
                % Finally, plot the mean spectrum level (the LZeq divided by the bandwidth
                % of each third octave subband) in every third octave subband:
                xLimits = [
                    0.9*min(app.CoreTable.SignalTable{row}.Band(:)), ...
                    1.1*max(app.CoreTable.SignalTable{row}.Band(:))
                ];

                semilogx( ...
                    app.MSLAxes, ...
                    app.CoreTable.SignalTable{row}.Band(:), ...
                    app.CoreTable.SignalTable{row}.MSL(:), ...
                    's-','LineWidth',2); 
                
                % title(app.MSLAxes,'Mean Spectrum Level in Each Third Octave Subband')
                % xlabel(app.MSLAxes,'Center Frequency (Hz)');
                % ylabel(app.MSLAxes,'MSL (dB re 1 uPa^2/Hz)');
                set(app.MSLAxes, 'YTickMode', 'auto', 'YTickLabelMode', 'auto', ...
                    'XTickMode', 'Manual', 'XTick', app.CoreTable.SignalTable{row}.Band(:), ...
                    'XLim', xLimits)

        end
        
        function ExportFigurePopup(app, targetFig, outPath)
            % targetFig is uiaxes object to be exported
            % outPath is optional value for path
            %% layout setup
            columnWidth = {60, 60, 60, 60, 60, 28, 22};
            windowWidth = sum([columnWidth{:}]) + (length(columnWidth)+1)*10;

            windowHeight = 104+10;
            % windowWidth = 404;
            windowX = app.SignalFinderUIFigure.Position(1) + app.SignalFinderUIFigure.Position(3)/2 - windowWidth/2;
            windowY = app.SignalFinderUIFigure.Position(2) + app.SignalFinderUIFigure.Position(4)/2 - windowHeight/2;

            exportWindow = uifigure('WindowStyle','modal');
            exportWindow.Position = [windowX windowY windowWidth windowHeight];
            exportWindow.Resize = 'off';

            % Create GridLayout
            SaveGrid = uigridlayout(exportWindow);
            SaveGrid.ColumnWidth = {60, 60, 60, 60, 60, 28, 22};
            SaveGrid.RowHeight = {22, 'fit', 'fit'};

            % Create PathLabel
            PathLabel = uilabel(SaveGrid);
            PathLabel.HorizontalAlignment = 'right';
            PathLabel.Layout.Row = 1;
            PathLabel.Layout.Column = 1;
            PathLabel.Text = 'Path';

            % Create PathField
            PathField = uitextarea(SaveGrid);
            PathField.Layout.Row = 1;
            PathField.Layout.Column = [2 6];
            PathField.Value = outPath;

            % Create PathSelectButton
            PathSelectButton = uibutton(SaveGrid, 'push');
            PathSelectButton.ButtonPushedFcn = @PathSelectButtonPushed;
            PathSelectButton.Layout.Row = 1;
            PathSelectButton.Layout.Column = 7;
            PathSelectButton.Text = '...';

            % Create HeightLabel
            HeightLabel = uilabel(SaveGrid);
            HeightLabel.HorizontalAlignment = 'right';
            HeightLabel.Layout.Row = 2;
            HeightLabel.Layout.Column = 1;
            HeightLabel.Text = 'Height';

            % Create HeightField
            HeightField = uieditfield(SaveGrid, 'numeric');
            HeightField.Limits = [1 Inf];
            HeightField.RoundFractionalValues = 'on';
            HeightField.ValueDisplayFormat = '%11g pts';
            HeightField.Layout.Row = 2;
            HeightField.Layout.Column = 2;
            HeightField.Value = 400;

            % Create WidthLabel
            WidthLabel = uilabel(SaveGrid);
            WidthLabel.HorizontalAlignment = 'right';
            WidthLabel.Layout.Row = 2;
            WidthLabel.Layout.Column = 3;
            WidthLabel.Text = 'Width';

            % Create WidthField
            WidthField = uieditfield(SaveGrid, 'numeric');
            WidthField.Limits = [1 Inf];
            WidthField.ValueDisplayFormat = '%11g pts';
            WidthField.Layout.Row = 2;
            WidthField.Layout.Column = 4;
            WidthField.Value = 600;

            % Create ResolutionLabel
            ResolutionLabel = uilabel(SaveGrid);
            ResolutionLabel.HorizontalAlignment = 'right';
            ResolutionLabel.Layout.Row = 2;
            ResolutionLabel.Layout.Column = 5;
            ResolutionLabel.Text = 'Resolution';

            % Create ResolutionField
            ResolutionField = uieditfield(SaveGrid, 'numeric');
            ResolutionField.Limits = [100 Inf];
            ResolutionField.RoundFractionalValues = 'on';
            ResolutionField.ValueDisplayFormat = '%11g dpi';
            ResolutionField.Layout.Row = 2;
            ResolutionField.Layout.Column = [6,7];
            ResolutionField.Value = 300;

            % Create ExportButton
            ExportButton = uibutton(SaveGrid, 'push');
            ExportButton.ButtonPushedFcn = @ExportButtonPushed;
            ExportButton.Layout.Row = 3;
            ExportButton.Layout.Column = [3 4];
            ExportButton.Text = 'Export';
            
            % Create CustomButton
            CustomButton = uibutton(SaveGrid, 'push');
            CustomButton.ButtonPushedFcn = @CustomButtonPushed;
            CustomButton.Layout.Row = 3;
            CustomButton.Layout.Column = [5 7];
            CustomButton.Text = 'Custom...';

            % Create CancelButton
            CancelButton = uibutton(SaveGrid, 'push');
            CancelButton.ButtonPushedFcn = @CancelButtonPushed;
            CancelButton.Layout.Row = 3;
            CancelButton.Layout.Column = [1 2];
            CancelButton.Text = 'Cancel';


            function ExportButtonPushed(~,~)
                pathOut = PathField.Value{1};
                if ~isempty(pathOut)
                    % https://www.mathworks.com/help/matlab/creating_plots/save-figure-at-specific-size-and-resolution.html
                    % in order to export at custom size, have to resize the figure itself in a new window and export that instead
                    tempFig = figure;
                    tempFig.Units = 'points';
                    tempFig.OuterPosition = [0.25 0.25 WidthField.Value HeightField.Value];
                    copyobj(targetFig,tempFig);
                    ax = gca;
                    ax.XTickMode = 'manual';
                    ax.YTickMode = 'manual';
                    ax.ZTickMode = 'manual';
                    ax.XLimMode = 'manual';
                    ax.YLimMode = 'manual';
                    ax.ZLimMode = 'manual';
                    exportgraphics(tempFig,pathOut,'Resolution',ResolutionField.Value)
                    close(tempFig)
                    delete(exportWindow)
                end
            end

            function CustomButtonPushed(~,~)
                % open figure in custom axes that can be edited
                tempFig = figure;
                tempFig.Units = 'points';
                tempFig.OuterPosition = [0.25 0.25 WidthField.Value HeightField.Value];
                copyobj(targetFig,tempFig);
                ax = gca;
                ax.XTickMode = 'manual';
                ax.YTickMode = 'manual';
                ax.ZTickMode = 'manual';
                ax.XLimMode = 'manual';
                ax.YLimMode = 'manual';
                ax.ZLimMode = 'manual';
                delete(exportWindow)
            end

            function CancelButtonPushed(~,~)
                delete(exportWindow)
            end

            function PathSelectButtonPushed(~,~)
                filter = {'*.jpg';'*.png';'*.tif';'*.pdf';'*.eps'};
                [filename,filepath] = uiputfile(filter);
                if ~isequal(filename,0)
                    PathField.Value = [filepath, filename];
                end
                figure(exportWindow)
            end
        end
        
        function PlotSelectedData(app, row)
            
            if strcmpi(app.AnalysisMode, "discrete")
                WaveformPlot(app, row)
                SpectrogramPlot(app, row)
                PSDPlot(app, row)

                cols = ["OnsetString", "OffsetString", "VocalType", "Duration", ... 
                    "rms", "Peak", "spl90"];
                app.StatTable.Data = app.CoreTable.SignalTable{row}{:,cols};
                rowCount = size(app.CoreTable.SignalTable{row},1);
                if ~app.SkipAmbientCheckBox.Value
                    rows = ['amb',string(1:(rowCount-1))];
                else
                    rows = string(1:rowCount);
                end
                app.StatTable.RowName = rows;

            else
                
                ThirdOctaveLZeqPlot(app, row)
                ThirdOctaveMSLPlot(app, row)
                
                cols = ["LZeq", "MSL", "sigRMS", "Clip"];
                app.StatTable.Data = app.CoreTable.SignalTable{row}(:, cols);
                rows = [app.CoreTable.SignalTable{row}.Band(:)];
                app.StatTable.RowName{row} = rows;
            end
        end
        
        function ResetCoreTable(app)
            app.CoreTable = table('Size', [0 length(app.tableColumnNames)], ...
                'VariableNames', app.tableColumnNames, 'VariableTypes', app.vartypes);
            % app.CoreTable = struct("Path","", "Filename","", ...
            %     "WaveIn",app.newRowWaveIn, "AmbWaveform",app.newRowWaveIn, ...
            %     "SR",0, "Gain",0, "RemoveOffsetCheck",true, "CalMode","auto", ...
            %     "CalFile","", "CalCurve",table, "SigFreqU",[100, 200], ...
            %     "SigFreqStart",100, "SigFreqEnd",200, "SigFreqMid",150, ...
            %     "SigSens",0, "AmbFreq",0, "AmbSens",0, "Thresh",1.5, ...
            %     "SignalTable",table);
            app.NumFiles = 0;

        end
        
        function SPL90 = calcT90(app, p)
            % calculate cumulative energy
            sumEnergy = cumsum(p.^2);
            sumEnergy = sumEnergy/sumEnergy(end);

            % find the 5% and 95% points
            iStart = find(sumEnergy >= 0.05, 1, 'first');
            iEnd = find(sumEnergy >= 0.95, 1, 'first');

            % get section of waveform between the 5% and 95%
            p90 = p(iStart:iEnd);

            % get the dB reference 
            dBrefUnit = app.ReferenceLevelDropDown.Value;
            if strcmpi(dBrefUnit, "1 µPa")
                dBref = 1;
            else
                dBref = 20;
            end
            SPL90 = 20*log10(rms(p90)/dBref);
        end

        function CursorWait(app, status)
            % increment WorkingCount for each process that starts, and
            % decrement when it finishes. Then change the cursor to match
            % (watch when there's at least one process, arrow when there
            % are none)

            if strcmpi(status, 'on')
                app.WorkingCount = app.WorkingCount + 1;
            else
                app.WorkingCount = app.WorkingCount - 1;
            end
            
            if app.WorkingCount > 0
                app.SignalFinderUIFigure.Pointer = 'watch';  % update the cursor to show it's working
            else
                app.SignalFinderUIFigure.Pointer = 'arrow';
                app.WorkingCount = 0;
            end
        end
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.newRowCore = table( ...
                "", ... % Path
                "", ...  % Filename
                {app.newRowWaveIn}, ...  % WaveInRaw (table)
                {app.newRowWaveIn}, ...  % WaveIn (table) 
                {app.newRowWaveIn}, ...  % AmbWaveform (table)
                0, ...  % SR
                0, ...  % DownsampledSR
                0, ...  % Gain
                true, ...  % RemoveOffsetCheck
                0, ...  % TimeOffset
                "manual", ...  % CalMode
                "", ...  % CalFile
                {app.calCurve}, ...  % CalCurve
                "[100, 200]", ...  % SigFreqU
                100, ...  % SigFreqStart
                200, ...  % SigFreqEnd
                150, ...  % SigFreqMid
                0, ...  % SigSens
                0, ...  % AmbFreq
                0, ...  % AmbSens
                1.5, ...  % Thresh
                {app.calCurve}, ...  % SignalTable
                {app.signalTable}, ...  % Spectrogram
                {app.signalTable}, ...  % PSD
                0.5, ...  % SpecTimeRes
                'VariableNames', app.tableColumnNames);

            ResetCoreTable(app);
            
            app.thirdOctTable = table(app.thirdOctBands, app.thirdOctBandE, app.thirdOctBandW, 'VariableNames', {'Middle', 'Edges', 'Width'});

            app.InputDiscreteTable.ColumnFormat = {'char', 'numeric', 'numeric', 'logical', 'numeric', 'char', 'bank', 'bank'};
            AddNewRow(app,0);

            %app.NumFiles = app.NumFiles +1;
            % Clip the path column on the left so the filename is visible
            % [~, pathCol] = GetTable(app,'Path');
            addStyle(app.InputDiscreteTable,uistyle("HorizontalClipping","left","HorizontalAlignment","right","icon","none"),"column",1);  % icon is included because otherwise it doesn't seem to work
            
            linkaxes([app.WaveAxes app.SpecAxes],'x')
            
            % set ambient frequencies to "all"
            ItemsData = app.AmbFreqListBox.ItemsData;
            app.AmbFreqListBox.Value = ItemsData;

            app.ResultsGrid.ColumnWidth = {'fit','1x',0,'fit'};
            app.AnalysisSettingsGrid.ColumnWidth = {'fit','fit', 'fit', '1x', 0,'fit'};

            app.VersionLabel.Text = app.version;
        end

        % Button pushed function: SaveWaveButton
        function SaveWaveButtonPushed(app, event)
            outPath = app.OutputPathField.Value;
            if isempty(outPath)
                warndlg("Please specify an output path")
                return
            end
            % get current figure displayed
            if strcmpi(app.AnalysisMode, "discrete")
                currTab = app.DiscreteResultsTabGroup.SelectedTab.Title;
                if strcmpi(currTab, "waveform")
                    currAxes = app.WaveAxes;
                elseif strcmpi(currTab, "spectrogram")
                    currAxes = app.SpecAxes;
                elseif strcmpi(currTab, "psd")
                    currAxes = app.PSDAxes;
                end
            else
                currTab = app.AmbientResultsTabGroup.SelectedTab.Title;
                if strcmpi(currTab, "lzeq")
                    currAxes = app.LZeqAxes;
                elseif strcmpi(currTab, "msl")
                    currAxes = app.MSLAxes;
                end
            end

            ExportFigurePopup(app, currAxes, outPath)
        end

        % Button pushed function: AnalyzeButton
        function AnalyzeButtonPushed(app, event)
            % run analysis
            app.AnalyzeButton.Text = "Running analysis...";
            app.AnalyzeButton.Enable = "off";
            UpdateWarning(app)
            CursorWait(app, 'on')
            
            drawnow
            for j=1:app.NumFiles
                % % first, make sure there's a waveform loaded to analyze
                % try
                %     assert(height(app.CoreTable.WaveInRaw{j}) > 0)
                % catch
                %     UpdateWarning(app,'No waveform loaded')
                %     app.AnalyzeButton.Enable = "on";
                %     CursorWait(app, 'off')
                %     return
                % end
                
                % flag that analysis has been run so changing parameters triggers the warning flag
                app.analysisHasRun = true;  
                % message = sprintf('Analyzing file %d of %d', j, app.NumFiles);
                % UpdateWarning(app, message)
                BlockOutput(app, false)
                
                %% calculate transfer functions for converting to proper units
                % ARNOTE: probably make this per mode so that curves can
                % provide multiple sensitivites in Ambient mode (for each
                % band)
                sigSens = app.CoreTable.SigSens(j); %GetValue(app, j, 'Sig|Sens');
                % ambSens = app.CoreTable.SigSens(j); %GetValue(app, j, 'Amb|Sens');
                calUnit = app.UnitDropDown.Value;
                dBrefUnit = app.ReferenceLevelDropDown.Value;
                if strcmpi(dBrefUnit, "1 µPa")
                    dBref = 1;
                else
                    dBref = 20;
                end
                
                gain = app.CoreTable.Gain(j); %GetValue(app, j, 'Gain');
                if strcmp(calUnit, 'dB re 1V/µPa')
                    % ambTF = 10^((ambSens + gain)/20);  % ambient transfer function for dB re 1V/uPa
                    sigTF = 10^((sigSens + gain)/20);  % signal transfer function for dB re 1V/uPa
                elseif strcmp(calUnit, 'dB re 1V/Pa')
                    % ambTF = 10^(((ambSens + gain)/20)-6)/10^6;  % ambient transfer function for dB re 1V/Pa
                    sigTF = 10^(((sigSens + gain)/20)-6)/10^6;  % signal transfer function for dB re 1V/Pa
                elseif strcmp(calUnit, 'dB re 1µPa')
                    % ambTF = 10^(((ambSens + gain)/20));  % ambient transfer function for dB re 1uPa
                    sigTF = 10^(((sigSens + gain)/20));  % signal transfer function for dB re 1uPa
                elseif strcmp(calUnit, 'mV/Pa')
                    % ambTF = ambSens;  % ambient transfer function
                    sigTF = sigSens + gain;  % signal transfer function for dB re 1uPa
                else
                    % other units go here
                end
                
                %% read wav file or load existing
                wavPath = app.CoreTable.Path(j);
        
                % Check if the file is already cached (DISABLED because of
                % the new timeOffset setting, which can change the actual
                % waveform)
                if false  %app.audioCache.isKey(wavPath)
                    % waveIn = app.audioCache(wavPath); % Use cached data (table of time, voltage, pressure)
                    % Fs = app.CoreTable.SR(j); %GetValue(app,j,'SR');
                else
                    [waveRaw, Fs] = audioread(wavPath); % Load from disk
                    dt = 1/Fs;
                    timeVec = 0:dt:dt*(length(waveRaw)-1);

                    % remove offset, if specified
                    timeOffset = app.CoreTable.TimeOffset(j);
                    sampOffset = round(timeOffset/dt);
                    % timeOffset = sampOffset*dt;
                    
                    timeVec = timeVec(sampOffset+1:end);  % the +1 is because MATLAB is a 1-indexed language, and an offset of 0 would return sampOffset=0
                    waveRaw = waveRaw(sampOffset+1:end);  % the +1 is because MATLAB is a 1-indexed language, and an offset of 0 would return sampOffset=0
                    % waveTemp = [timeVec', waveIn];
                    %app.CoreTable(row,:).WaveIn = table(timeVec',waveIn, 'VariableNames', ["Time", "V"]);
                    waveIn = table(timeVec', waveRaw, 'VariableNames', ["Time", "V"]);


                    %% convert waveform to uPa
                    if strcmp(calUnit, 'dB re 1µPa')
                        % transfer function for end-to-end calibration
                        signalWaveform=waveIn.V*sigTF;  % Data sequence in micropascals
                    else
                        signalWaveform=waveIn.V/sigTF;  % Data sequence in micropascals
                    end

                    waveIn.uPa = signalWaveform;
                    waveIn.dB = 20*log10(abs(signalWaveform)/dBref);
                    
                    % app.audioCache(wavPath) = waveIn; % Cache it
                end

                thresh = app.CoreTable.Thresh(j);
                threshuPa = (10^(thresh/20))*dBref;
                removeOffset = app.CoreTable.RemoveOffsetCheck(j);
                downsamplePerform = app.DownSampCheckBox.Value;
                % waveIn = app.CoreTable.WaveInRaw{j};

                %% calculate DC offset from first 1000 points and remove
                if removeOffset
                    waveIntro = waveIn(1:1000,:);
                    offset = median(waveIntro.V);
                    waveIn.V = waveIn.V - offset;
                end
                
                %% apply downsampling, if enabled
                if downsamplePerform
                    downsampleTarget = app.DownSampField.Value;
                	ratio = Fs/downsampleTarget;
                    if round(ratio) ~= ratio
                        % if the target downsampled frequency can't be
                        % reached by an integer ratio, warn user
                        UpdateWarning(app,'Cannot achieve target downsampled frequency, rounding to nearest')
                    end
                	waveIn = downsample(waveIn, round(ratio));
                    app.CoreTable.DownsampledSR(j) = Fs/round(ratio);
                    Fs = Fs/round(ratio);
                    dSampOffset = round(timeOffset*Fs);
                else
                    % waveIn = waveIn;
                    app.CoreTable.DownsampledSR(j) = Fs;
                    dSampOffset = sampOffset;
                end

                % % create local copy of waveform so that rerunning the analysis doesn't overwrite
                app.CoreTable.WaveIn{j} = waveIn;
                 
                %% choose which analysis to do
                if strcmpi(app.AnalysisMode, "discrete")
                    
                    % grab other variables
                    minGap = app.MinGapField.Value;
                    minSoundLength = app.MinLengthField.Value;
                    
                    %% --Filter waveform--
                    filterMode = app.FilterDropDown.Value;
                    if strcmpi(filterMode, 'none')
                        % user has selected not to filter at all
                        waveIn.uPaFilt = waveIn.uPa;
                        waveIn.dBFilt = 20*log10(abs(waveIn.uPaFilt)/dBref);
                        app.CoreTable.WaveIn{j} = waveIn;
                    else
                        message = sprintf('Analyzing file %d of %d (Filtering waveform)', j, app.NumFiles);
                        UpdateWarning(app, message)
                        % for third band, lower freq is f_0/(2^(1/2))^(1/3) = f_0/(2^(1/6))
                        f1 = app.CoreTable.SigFreqStart(j);
                        f2 = app.CoreTable.SigFreqEnd(j);

                        %d = designfilt('bandpassiir','FilterOrder',8,'HalfPowerFrequency1',f1,'HalfPowerFrequency2',f2,'SampleRate',Fs);
                        fc=[f1 f2]/(Fs/2);
                        [b,a]=butter(3,fc);

                        waveIn.uPaFilt = filtfilt(b,a,waveIn.uPa);
                        waveIn.dBFilt = 20*log10(abs(waveIn.uPaFilt)/dBref);
                        %waveIn.VFilt = filtfilt(d,waveIn.V);
                        app.CoreTable.WaveIn{j} = waveIn;  % update the saved waveform so we can separately update the spectrogram, if needed

                        % make sure the waveform didn't get totally filtered away
                        try
                            assert(sum(isnan(app.CoreTable.WaveIn{j}.uPaFilt)) == 0)
                        catch
                            BlockOutput(app, true)
                            UpdateWarning(app,'Waveform filtered to nothing, please check filter settings')
                            app.AnalyzeButton.Enable = "on";
                            return
                        end

                    end
                    %% Identify onsets and offsets
                    % % -get first 2000 samples and calculate threshold for signal onset-
                    % waveIntro = waveIn(1:2000,:);  % redefine waveIntro because it didn't include VFilt before
                    % thresh = max(abs(waveIntro.VFilt))*Thresh;

                    % -now actually find the onsets-
                    sigWave = envelope(waveIn.uPaFilt, 5000);  % use envelope of signal 
                    
                    % other method: find continuous strings of points above threshold and classify each string as a signal
                    sigwaveT = sigWave > threshuPa;
                    sigStartsTemp = strfind([0 sigwaveT' 0], [0 1]);  %find starts of sequences above threshold
                    % for each start point, find the closest following
                    % point where the waveform is actually above the
                    % threshold also
                    sigEndsTemp = strfind([0 sigwaveT' 0], [1 0])-1;  %find ends of sequences above threshold
                    
                    % enforce a minimum length
                    % Iterate through valid segments and group nearby sounds
                    sigStarts = [];
                    sigEnds = [];
                    i = 1;
                    while i <= length(sigStartsTemp)
                    	% Get the current sound indices
                    	currentOnset = sigStartsTemp(i);
                    	currentOffset = sigEndsTemp(i);

                    	% Check for nearby sounds and group them
                    	while i < length(sigStartsTemp) && (sigStartsTemp(i+1) - currentOffset) <= (minGap * Fs)
                    		currentOffset = sigEndsTemp(i+1);
                    		i = i + 1;
                    	end

                    	% Add the grouped sound to the filtered onsets and offsets
                    	sigStarts = [sigStarts; currentOnset]; %#ok<AGROW>
                    	sigEnds = [sigEnds; currentOffset]; %#ok<AGROW>

                    	% Move to the next sound
                    	i = i + 1;
                    end
                    
                    % exclude any sounds that are too small
                    % Find sound segments that are longer than the minimum length
                    validSegments = find((sigEnds - sigStarts) >= (minSoundLength * Fs));

                    sigStarts = sigStarts(validSegments);
                    sigEnds = sigEnds(validSegments);

                    nSignals = length(sigStarts);
                    % create blank table to fill
                    signalI = 1:nSignals;
                    
                    % tempSignalTable = array2table([signalI', sigStarts', sigEnds', zeros(nSignals,5)], ...
                    %     'VariableNames',["SigNum","Onset","Offset", "OnsetS", "rms", "Peak", "SNR", "CSEL"]);  % Signal number, Onset, Offset
                    % app.statTableArray{j} = array2table(zeros(nSignals+1,5));  % plus one for a row for the ambient
        
        
                    %% get ambient measurements

                    doAmbient = ~app.SkipAmbientCheckBox.Value;
                    
                
                    if doAmbient

                        if nSignals == 0
                            % no signals, so just use first full second
                            ambOnset = 1;
                            ambOffset = 1*Fs;
                            app.CoreTable.AmbWaveform{j} = waveIn(ambOnset:ambOffset,:);
                            UpdateWarning(app, 'No signal detected above ambient noise, onset of signal(s) cannot be detected')
                            
                            ambRMSuPa = rms(app.CoreTable.AmbWaveform{j}.uPaFilt);
                            ambPeakuPa = max(abs(app.CoreTable.AmbWaveform{j}.uPaFilt));

                        else
                            signalI = [0 signalI];
                            % signals detected, use 1 second before first signal
                            if sigStarts(1) < 1*Fs
                                % first signal is less than 1 second in
                                ambOnset = nan;
                                ambOffset = nan;
                                ambRMSuPa = nan;
                                ambPeakuPa = nan;
                                % warn user
                                UpdateWarning(app, sprintf('Signal onset less than 1 second from waveform start, cannot get 1 sec of ambient noise (%0.2f s)', (sigStarts(1)+dSampOffset)/Fs))
                            else
                                ambOnset = round(sigStarts(1)-1*Fs);
                                ambOffset = sigStarts(1);
                                UpdateWarning(app)
                                
                                app.CoreTable.AmbWaveform{j} = waveIn(ambOnset-dSampOffset:ambOffset-dSampOffset,:);
                                
                                ambRMSuPa = rms(app.CoreTable.AmbWaveform{j}.uPaFilt);
                                ambPeakuPa = max(abs(app.CoreTable.AmbWaveform{j}.uPaFilt));
                            end
                        end
                        
                        % Convert RMS and peak to dB
                        ambRMS = 20*log10(ambRMSuPa);
                        ambPeak = 20*log10(ambPeakuPa);

                    end
                    
                    % tempSignalTable = convertvars(tempSignalTable, ["OnsetString","OffsetString","VocalType"], 'string');
                    
                    
                    
                    %% loop through detected signals and get measurements (rms, peak, SNR, CSEL) for each
                    recordLength = 0;  % for calculating CSEL, cumsum of total durations
                    
                    tableSigOnset = zeros(nSignals+doAmbient, 1);
                    tableSigOffset = zeros(nSignals+doAmbient, 1);

                    tableSigOnsetS = zeros(nSignals+doAmbient, 1);
                    tableSigrms = zeros(nSignals+doAmbient, 1);
                    tableSigPeak = zeros(nSignals+doAmbient, 1);
                    tableSigSpl90 = zeros(nSignals+doAmbient, 1);

                    tableSigSEL = zeros(nSignals+doAmbient, 1);
                    tableSigSNR = nan(nSignals+doAmbient, 1);
                    tableSigSNRdiff = nan(nSignals+doAmbient, 1);
                        
                    tableSigOnsetString = strings(nSignals+doAmbient, 1);
                    tableSigOffsetString = strings(nSignals+doAmbient, 1);
                    tableSigVocalType = strings(nSignals+doAmbient, 1);
                    tableSigDuration = zeros(nSignals+doAmbient, 1);

                    for i = (1:nSignals)
                        signalOnset = sigStarts(i) + dSampOffset;
                        
                        signalOffset = sigEnds(i) + dSampOffset;  % signalOffset is offset from trimmed waveform, so not including timeOffset
                        if signalOffset > height(waveIn)+dSampOffset
                            signalOffset = height(waveIn);
                        end
        
                        signalWaveform = waveIn(signalOnset-dSampOffset:signalOffset-dSampOffset,:);
                        %% Get peak and rms
                        sigPeakuPa = max(abs(signalWaveform.uPaFilt));
                        sigRMSuPa = rms(signalWaveform.uPaFilt);
                        sigSPL90 = app.calcT90(signalWaveform.uPaFilt);
                        
                        % convert to dB
                        sigRMS = 20*log10(sigRMSuPa/dBref);  % rmsV*TF = uPa, then 20*log10() to get dB re 1 uPa
                        sigPeak = 20*log10(sigPeakuPa/dBref);


                        %% Get SNR
                        % https://www.mathworks.com/matlabcentral/answers/35658-how-can-i-calculate-the-signal-to-noise-ratio-snr-of-a-chirp-signal
                        if doAmbient
                            snr = (sigRMS/ambRMS)^2;
                            snrDiff = sigRMS - ambRMS;
                        else
                            snr = nan;
                            snrDiff = nan;
                        end

                        %% Get SEL
                        % CSEL options:
                        %   https://dosits.org/science/advanced-topics/sound-pressure-levels-and-sound-exposure-levels/
                        %     CSEL is SEL_ss + 10*log_10(N)
                        %     where SEL_ss is SEL of single pulse and N is number of pulses
                        %   Theobald et al 2009 - https://www.researchgate.net/publication/229030710_CUMULATIVE_NOISE_EXPOSURE_ASSESSMENT_FOR_MARINE_MAMMALS_USING_SOUND_EXPOSURE_LEVEL_AS_A_METRIC
                        %     "The SEL for each impulsive noise event can be aggregated by summation to calculate the total SEL
                        %     (or cumulative SEL) for the entire exposure duration"
                        %   From selcalc.m
                        recordLength = recordLength + length(signalWaveform.uPaFilt)/Fs;
                        sigSEL = sigRMS + 10*log10(recordLength);

                        signalOnsetS = (signalOnset/Fs);
                        signalOffsetS = (signalOffset/Fs);
                        
                        tableSigOnset(i+doAmbient) = signalOnset;
                        tableSigOffset(i+doAmbient)  = signalOffset;
    
                        tableSigOnsetS(i+doAmbient)  = signalOnsetS;
                        tableSigrms(i+doAmbient)  = sigRMS;
                        tableSigPeak(i+doAmbient)  = sigPeak;
                        tableSigSpl90(i+doAmbient)  = sigSPL90;
    
                        tableSigSEL(i+doAmbient)  = sigSEL;
                        tableSigSNR(i+doAmbient)  = snr;
                        tableSigSNRdiff(i+doAmbient)  = snrDiff;
                            
                        tableSigOnsetString(i+doAmbient)  = string(seconds(signalOnsetS),"mm:ss.SS");
                        tableSigOffsetString(i+doAmbient)  = string(seconds(signalOffsetS),"mm:ss.SS");
                        tableSigVocalType(i+doAmbient)  = "potential call";
                        tableSigDuration(i+doAmbient)  = (signalOffsetS - signalOnsetS)*1000;

                        % app.statTableArray{j}(i+1,:) = {signalOnset/Fs, sigRMS, sigPeak, snr, sigSEL};
                        % % app.StatTable.Data(i,:) = {i, rmsSignal, sigPeak, snr, frequencydomainSEL};
                    end
                    
                    if doAmbient
                        tableSigOnset(1) = ambOnset-dSampOffset;
                        tableSigOffset(1)  = ambOffset-dSampOffset;
    
                        tableSigOnsetS(1)  = ambOnset/Fs;
                        tableSigrms(1)  = ambRMS;
                        tableSigPeak(1)  = ambPeak;
                        % tableSigSpl90(1)  = sigSPL90;
                            
                        tableSigOnsetString(1)  = string(seconds(ambOnset/Fs),"mm:ss.SS");
                        tableSigOffsetString(1)  = string(seconds(ambOffset/Fs),"mm:ss.SS");
                        tableSigVocalType(1)  = "ambient";
                        tableSigDuration(1)  = (ambOffset - ambOnset)/Fs;
                        
                    end
                    tempSignalTable = table( ...
                        signalI', ...
                        tableSigOnset, ...
                        tableSigOffset, ...
                        tableSigOnsetS, ...
                        tableSigOnsetString, ...
                        tableSigOffsetString, ...
                        tableSigVocalType, ...
                        tableSigDuration, ...
                        tableSigrms, ...
                        tableSigPeak, ...
                        tableSigSpl90, ...
                        tableSigSNR, ...
                        tableSigSNRdiff, ...
                        tableSigSEL ...
                        , ...
                            'VariableNames', ["SigNum","Onset","Offset", ...
                            "OnsetS", "OnsetString", "OffsetString", ...
                            "VocalType", "Duration", "rms", "Peak", ...
                            "spl90", "SNR", "SNRdiff","SigSEL"]);
                    

                    app.CoreTable.SignalTable{j} = tempSignalTable;
                    message = sprintf('Analyzing file %d of %d (Generating spectrogram)', j, app.NumFiles);
                    UpdateWarning(app, message)
                    SpectrogramUpdate(app,j)
                    
                    message = sprintf('Analyzing file %d of %d (Generating PSD)', j, app.NumFiles);
                    UpdateWarning(app, message)
                    PSDUpdate(app,j)
                
                else
                    %% third octave ambient noise analysis

                    
                    %% Determine if there is data clipping:

                    F=find(abs(waveIn.V)==1);

                    NF=length(F);

                    if NF == 0
                        % sprintf('There are no clipped data in this set');
                        clip=false;
                    else
                        % sprintf('There are clipped data in this set');
                        clip=true;
                    end

                    %% Calculate rms SPL (dB re 1uPa)
                    % sigRMS=20*log10(std(1000000*(signalWaveform-mean(signalWaveform)))); % Calculate dB re 1uPa
                    sigRMS=20*log10(std((signalWaveform-mean(signalWaveform)))/dBref); % Calculate dB re 1uPa


                    %% Perform third octave noise analysis to obtain the frequency content of the ambient noise:

                    % In this section we calculate the average power in each third octave
                    % subband (in vector TOPL) and the mean spectrum level in each third
                    % octave subband (in vector MSL):
                    UpdateWarning(app,sprintf('Analyzing file %d of %d (Calculating 3rd-oct bands)', j, app.NumFiles)  )
                    fNyq=Fs/2;     % The Nyquist frequency (Hz)

                    freqs = str2double(app.AmbFreqListBox.Value)';
                    
                    % get thirdOctTable with just selected frequencies
                    selectedTable = app.thirdOctTable(ismember(app.thirdOctTable.Middle,freqs),:);

                    % Limit table to max band that doesn't contain fNyq
                    idx = selectedTable.Edges(:,2) < fNyq;
                    selectedTable = selectedTable(idx,:);
                    nFreq = height(selectedTable);

                    % Create tempSignalTable with just center freq and
                    % columns for TOPL, MSL, sigRMS, and clip
                    tempSignalTable = table(selectedTable.Middle, zeros(nFreq,1), zeros(nFreq,1), zeros(nFreq,1), nan(nFreq,1), ...
                        'VariableNames',["Band","LZeq","MSL", "sigRMS", "Clip"]);
                    
                    % For each selected frequency, calculate TOPL and MSL
                    % and add to temp table
                    for k=1:nFreq
                        tempSignalTable.LZeq(k) = 10*log10(bandpower(signalWaveform,Fs,selectedTable.Edges(k,:))); 
                        % Calculate Mean Spectrum Levels, which are the
                        % LZeq (i.e. the TOPL) divided by the bandwidth of
                        % the appropriate third octave subband:
                        tempSignalTable.MSL(k) = tempSignalTable.LZeq(k) - 10*log10(selectedTable.Width(k));
                    end

                    % 


                    % 
                    % % ************************************************************************
                    % fBmax=max(selectedTable.Edges(:,2));  
                    % Nfbe=length(app.thirdOctTable.Edges);
                    % 
                    % % ************************************************************************
                    % 
                    % if fNyq > fBmax
                    %     % if nyquist frequency is higher than the uppermost
                    %     % band
                    %     KC=Nfbe-1;
                    % else
                    %     % otherwise get the highest complete band that
                    %     % doesn't include the nyquist (so no incomplete
                    %     % bands)
                    %     for n=1:Nfbe
                    %         if app.thirdOctTable.Edges(n+1,2) > fNyq
                    %             KC=n-1; 
                    %             break
                    %         end
                    %     end
                    % end

                    % for k=1:KC
                    %     TOPL(k)=10*log10(bandpower(signalWaveform,Fs,app.thirdOctTable.Edges(k,:))); %#ok<*AGROW>
                    % end
                    % 
                    % 
                    % %% Calculate Mean Spectrum Levels, which are the LZeq (i.e. the TOPL)
                    % % divided by the bandwidth of the appropriate third octave subband:
                    % 
                    % for k=1:length(TOPL)
                    %     MSL(k)=TOPL(k)-10*log10(app.thirdOctTable.Width(k));
                    % end

                    % ************************************************************************
                    
                    % tempSignalTable = table(app.thirdOctTable.Center(1:length(TOPL)), TOPL', MSL', zeros(length(TOPL),1), nan(length(TOPL),1), ...
                    %     'VariableNames',["Band","LZeq","MSL", "sigRMS", "Clip"]);
                    % app.statTableArray{j}.RowName = app.thirdOctBands;
                    % app.statTableArray{j}(:,1) = TOPL;
                    % app.statTableArray{j}(:,2) = MSL;
                    % app.statTableArray{j}(:,3) = NaN;
                    % app.statTableArray{j}(1,3) = sigRMS;  % signal RMS on first row only
                    % app.statTableArray{j}(:,4) = NaN;
                    % app.statTableArray{j}(1,4) = clip;  % clipping presence on first row only
                    tempSignalTable.sigRMS(1) = sigRMS;
                    tempSignalTable.Clip(1) = clip;
                    app.CoreTable.SignalTable{j} = tempSignalTable;
                end
            

            end
            app.AnalyzeButton.Text = "Analyze";
            CursorWait(app, 'off')
            UpdateWarning(app, 'Analysis Complete')
            app.AnalyzeButton.Enable = "on";
            % load data from row 1
            app.FileListBox.Value = app.CoreTable.Filename{1};
            CursorWait(app, 'on')
            drawnow;
            PlotSelectedData(app, 1);
            HighlightInputRow(app, 1);
            CursorWait(app, 'off')
            app.FileListBox.Enable = "on";  % enable the file selection list after first run

        end

        % Button pushed function: OutputPathSelect
        function OutputPathSelectButtonPushed(app, event)
            path = uigetdir();
            if ~isequal(path,0)
                app.OutputPathField.Value = path;
            end
            drawnow();
        end

        % Button pushed function: SaveStatsButton
        function SaveStatsButtonPushed(app, event)
            outPath = app.OutputPathField.Value;
            value = app.FileListBox.Value;
            items = app.CoreTable.("Filename");
            row = find(items==value);
            wavPath = GetValue(app, row, 'Path');
            [~,tempName] = fileparts(wavPath);
            tempName = strcat(tempName, '.csv');
            if isempty(outPath)
                [file, path] = uiputfile( {'*.csv;', 'Comma-Separated (*.csv)'},'Save File', tempName);
            else
                [file, path] = uiputfile( {'*.csv;', 'Comma-Separated (*.csv)'},'Save File', fullfile(outPath, tempName));
            end
            if file > 0
                if strcmpi(app.AnalysisMode, "discrete")
                    cols = ["OnsetString", "OffsetString", ...
                            "VocalType", "Duration", "rms", "Peak", "spl90"];
                    colNames = app.StatTable.ColumnName(:)';
                else
                    cols = ["Band", "LZeq", "MSL", "sigRMS", "Clip"];
                    colNames = [{'Band'}, app.StatTable.ColumnName(:)'];
                end
                tempCell = cell(1,app.NumFiles);  % create cell array for the output tables as a way of preallocating space

                
                
                tempTable = app.CoreTable.SignalTable{row}(:,cols);
                % tempTable = array2table(tempTable);
                tempTable.Properties.VariableNames = colNames;
                filenameCol = repmat(app.CoreTable.Filename{row}, height(tempTable),1);  % create a column with the filename
                tempTable = addvars(tempTable, filenameCol, 'Before', 1, 'NewVariableNames', "Filename");  % insert the filename into the table
                
                tempCell{row} = tempTable;
                    

                combinedTable = vertcat(tempCell{:});
                combinedTable.Properties.VariableNames = replace(tempTable.Properties.VariableNames, "|", " ");
                writetable(combinedTable,fullfile(path,file), 'Encoding', 'UTF-8')
                
                % tempTable = array2table(app.StatTable.Data);
                % tempTable.Properties.VariableNames = app.StatTable.ColumnName;
                % tempTable.Properties.RowNames = app.StatTable.RowName;
                % writetable(tempTable,fullfile(path,file),'WriteRowNames',true)
            end
        end

        % Button pushed function: SaveAllStatsButton
        function SaveAllStatsButtonPushed(app, event)
            % loop through all analyzed files, concatenate into single table, and export
            outPath = app.OutputPathField.Value;
            tempName = "summary_stats.csv";
            if isempty(outPath)
                [tempName, path] = uiputfile( {'*.csv;', 'Comma-Separated (*.csv)'},'Save File', tempName);
            else
                [tempName, path] = uiputfile( {'*.csv;', 'Comma-Separated (*.csv)'},'Save File', fullfile(outPath, tempName));
            end
            
            if path > 0
                if strcmpi(app.AnalysisMode, "discrete")
                    cols = ["OnsetString", "OffsetString", ...
                            "VocalType", "Duration", "rms", "Peak", "spl90"];
                    colNames = app.StatTable.ColumnName(:)';
                else
                    cols = ["Band", "LZeq", "MSL", "sigRMS", "Clip"];
                    colNames = [{'Band'}, app.StatTable.ColumnName(:)'];
                end
                tempCell = cell(1,app.NumFiles);  % create cell array for the output tables as a way of preallocating space

                for i=1:app.NumFiles
                    
                    tempTable = app.CoreTable.SignalTable{i}(:,cols);
                    % tempTable = array2table(tempTable);
                    tempTable.Properties.VariableNames = colNames;
                    filenameCol = repmat(app.CoreTable.Filename{i}, height(tempTable),1);  % create a column with the filename
                    tempTable = addvars(tempTable, filenameCol, 'Before', 1, 'NewVariableNames', "Filename");  % insert the filename into the table
                    
                    tempCell{i} = tempTable;
                    
                end
                combinedTable = vertcat(tempCell{:});
                combinedTable.Properties.VariableNames = replace(tempTable.Properties.VariableNames, "|", " ");
                writetable(combinedTable,fullfile(path,tempName), 'Encoding', 'UTF-8')
            end
            % % Old version: loop through all analyzed files and export
            % % stats for each as separate file
            % outPath = app.OutputPathField.Value;
            % if isempty(outPath)
            %     path = uigetdir();
            % else
            %     path = outPath;
            % end
            % if path > 0
            %     if strcmpi(app.AnalysisMode, "discrete")
            %         cols = ["SigNum", "OnsetString", "OffsetString", ...
            %                 "VocalType", "Duration","VocalType", "rms", "Peak"];
            %         colNames = [{'Signal Number'}, app.StatTable.ColumnName(:)'];
            %     else
            %         cols = ["Band", "LZeq", "MSL", "sigRMS", "Clip"];
            %         colNames = [{'Band'}, app.StatTable.ColumnName(:)'];
            %     end
            %     for i=1:app.NumFiles
            %         wavPath = GetValue(app, i, 'Path');
            %         [~,tempName] = fileparts(wavPath);
            %         tempName = strcat(tempName, '_stats', '.csv');
            %         tempTable = app.CoreTable.SignalTable{i}{:,cols};
            %         tempTable = array2table(tempTable);
            %         tempTable.Properties.VariableNames = colNames;
            %         writetable(tempTable,fullfile(path,tempName))
            %     end
            % end
        end

        % Button pushed function: SplitRecButton
        function SplitRecButtonPushed(app, event)
            % Split wav file into single file for each signal detected
            
            % get current row
            row = GetCurrentRow(app);
            nSignals = height(app.CoreTable.SignalTable{row});
            Fs = GetValue(app, row, 'SR');
            outPath = app.OutputPathField.Value;
            if isempty(outPath)
                warndlg('Please specify an output path.')
                return
            end
            [~,name,~] = fileparts(GetValue(app, row, 'Path'));
            outPathSub = fullfile(outPath, name);
            % make the folder if it doesn't exist
            if ~exist(outPathSub, 'dir')
                mkdir(outPathSub)
            end
            for i = 1:nSignals
                outPathFull = fullfile(outPathSub, sprintf('s_%02i.wav', i));
                waveOut = app.CoreTable.WaveInRaw{row}.V(app.CoreTable.SignalTable{row}.Onset(i):app.CoreTable.SignalTable{row}.Offset(i));
                audiowrite(outPathFull,waveOut,Fs)
            end
        end

        % Button pushed function: AddDiscreteRowButton
        function AddDiscreteRowButtonPushed(app, event)
            indices = app.InputDiscreteTable.Selection;
            if ~isempty(indices)
                row = indices(1);
            else
                row = 0;
            end
            AddNewRow(app,row);

        end

        % Button pushed function: DeleteDiscreteRowButton
        function DeleteDiscreteRowButtonPushed(app, event)
            indices = app.InputDiscreteTable.Selection;
            if ~isempty(indices)
                row = indices(1);

                app.CoreTable(row,:) = [];

                RefreshInputTable(app);
                app.NumFiles = app.NumFiles - 1;
                app.FileListBox.Items = app.CoreTable.('Filename');
            end
        end

        % Selection changed function: InputDiscreteTable
        function InputDiscreteTableSelectionChanged(app, event)
            indices = event.Selection;
            colName = app.InputDiscreteTable.ColumnName;
            if ~isempty(indices)
                currColName = colName{indices(2)};
                if startsWith(currColName, 'Path')
                    % selected path cell
                    [file, path] = uigetfile( ...
                        {'*.wav;*.csv;*.txt', 'Recording Files (*.wav,*.csv,*.txt)'; ...
                        '*.wav','WAV Files (*.wav)'; ...
                        '*.csv;*.txt','Text Files (*.csv, *.wav)'}, 'MultiSelect', 'on');
                    if ~isequal(file,0)
                        if iscell(file)
                            fileCount = size(file, 2);
                            % set current row to first file, then add new rows
                            % for all remaining files
                            for i=(1:fileCount)
                                currRow = indices(1) + i - 1;
                                app.CoreTable.Path(currRow) = fullfile(path,file{i});
                                UpdateWav(app, currRow);
                                UpdateFilenames(app,currRow);
                                if i<fileCount
                                    AddNewRow(app, currRow);
                                end
                            end
                        else
                            app.CoreTable.Path(indices(1)) = fullfile(path,file);
                            UpdateWav(app, indices(1))
                            UpdateFilenames(app,indices(1));
                        end
                        RefreshInputTable(app)
                        BlockOutput(app, true)
                        AnalyzeEnable(app)
                    end
                % elseif startsWith(currColName, 'Cal File')
                %     % selected path cell
                %     [file, path] = uigetfile( ...
                %         {'*.wav;*.csv;*.txt', 'Recording Files (*.wav,*.csv,*.txt)'; ...
                %         '*.wav','WAV Files (*.wav)'; ...
                %         '*.csv;*.txt','Text Files (*.csv, *.wav)'});
                %     if ~isequal(file,0)
                %         UpdateTable(app, indices(1), 'Cal File', fullfile(path,file));
                %         UpdateCalibration(app, indices(1))
                %         BlockOutput(app, true)
                %         AnalyzeEnable(app)
                %     end
                end
                drawnow();
            end


            
        end

        % Cell edit callback: InputDiscreteTable
        function InputDiscreteTableCellEdit(app, event)
            % get edited cell, update CoreTable
            indices = event.Indices;
            newData = event.NewData;
            row = indices(1);
            oldColName = app.InputDiscreteTable.ColumnName{indices(2)};
            colName = app.colNameTranslate((app.colNameTranslate(:,2)==oldColName),1);
            if islogical(app.CoreTable.(colName)(row))
                newData = logical(str2double(newData));
            end
            app.CoreTable.(colName)(row) = newData;

            % then rerun any calcs
            if ismember(colName, app.recalcCols)
                % rerun frequency calculations
                UpdateFreqs(app, row)
                UpdateSigCal(app, row)
                UpdateAmbCal(app, row)
                UpdateFilenames(app, row)
            end
            BlockOutput(app, true)
            AnalyzeEnable(app)
            % app.analysisHasRun = false;
        end

        % Button pushed function: FreqAllButton
        function FreqAllButtonPushed(app, event)
            ItemsData = app.AmbFreqListBox.ItemsData;
            app.AmbFreqListBox.Value = ItemsData;
        end

        % Button pushed function: FreqNoneButton
        function FreqNoneButtonPushed(app, event)
            app.AmbFreqListBox.Value = {};
        end

        % Selection changed function: ModeButtonGroup
        function ModeButtonGroupSelectionChanged(app, event)
            selectedButton = app.ModeButtonGroup.SelectedObject.Text;
            if strcmpi(selectedButton, "Discrete")
                app.AnalysisMode = "Discrete";
                dBrefUnit = app.ReferenceLevelDropDown.Value;
                if strcmpi(dBrefUnit, "1 µPa")
                    dBref = 1;
                else
                    dBref = 20;
                end
                newColNames = {'Call Start|Time'; ...
                        'Call End|Time'; 'Vocal Type'; 'Duration|(ms)'; ...
                        sprintf('RMS|(dB re %d µPa)', dBref); ...
                        sprintf('Peak|(dB re %d µPa)', dBref); ...
                        sprintf('SPL 90%|(dB re %d µPa)', dBref)};
                
                % app.StatTable.('newCol') = zeros(height(app.StatTable),1);
                % app.StatTable.('newCol2') = zeros(height(app.StatTable),1);
                app.StatTable.ColumnName = newColNames;
                app.StatTable.ColumnWidth = {60,75,75,75,75,86,86,86};
                app.AmbientSettingsPanel.Enable = "off";
                app.MinGapField.Enable = "on";
                app.MinLengthField.Enable = "on";
                app.ResultsGrid.ColumnWidth = {'fit','1x',0,'fit'};
                app.AnalysisSettingsGrid.ColumnWidth = {'fit','fit', 'fit', '1x', 0,'fit'};
                app.DiscreteSettingsPanel.Enable = "on";
                app.SkipAmbientCheckBox.Visible = "on";
                app.SpectrogramCheckBox.Visible = "on";
            else
                app.AnalysisMode = "Ambient";
                app.StatTable.ColumnName = {'LZeq'; 'MSL'; 'RMS|(dB re 1µPa)'; 'Clipping?'};
                app.StatTable.ColumnWidth = {86, 86, 86, 86};
                app.AmbientSettingsPanel.Enable = "on";
                app.MinGapField.Enable = "off";
                app.MinLengthField.Enable = "off";
                app.ResultsGrid.ColumnWidth = {'fit',0,'1x','fit'};
                app.DiscreteSettingsPanel.Enable = "off";
                app.AnalysisSettingsGrid.ColumnWidth = {'fit','fit', 'fit', '1x','fit',0};
                app.SkipAmbientCheckBox.Visible = "off";
                app.SpectrogramCheckBox.Visible = "off";
            end
        end

        % Value changed function: MinGapField, MinLengthField
        function MinGapFieldValueChanged(app, event)
            BlockOutput(app, true)
            % app.analysisHasRun = false;
            
        end

        % Value changed function: AmbFreqListBox
        function AmbFreqListBoxValueChanged(app, event)
            % Change which values are shown in the table 
            % ARNOTE: maybe highlight the columns in the figure?
            if app.analysisHasRun
                if strcmpi(app.AnalysisMode, 'ambient')
                    row = GetCurrentRow(app);
                    value = app.AmbFreqListBox.Value;
                    statTable = app.statTableArray{row};
                    % you can index a table by row names, which is what value
                    % returns
                    app.StatTable.Data = statTable(value,:);
                    
                end
            end
            AnalyzeEnable(app);  % recheck for missing values
        end

        % Value changed function: FileListBox
        function FileListBoxValueChanged(app, event)
            value = app.FileListBox.Value;
            items = app.CoreTable.("Filename");
            row = find(items==value);
            % change displayed figures
            if app.analysisHasRun
                CursorWait(app, 'on')
                drawnow;
                PlotSelectedData(app, row);
                HighlightInputRow(app, row);
                app.CurrSpecTimeRes.Value = app.CoreTable.SpecTimeRes(row);
                CursorWait(app, 'off')
            end
        end

        % Button pushed function: SaveButton
        function SaveButtonPushed(app, event)
            filter = {'*.csv'};
            [filename,filepath] = uiputfile(filter);
            if ~isequal(filename,0)
                % just get column names from InputDiscreteTable, translate
                % them to column names in CoreTable, and pull data directly
                % from CoreTable (which is already a table), as opposed to
                % InputDiscreteTable (which can have wonky formatting and
                % isn't pulled as a table directly)
                tempNames = app.InputDiscreteTable.ColumnName;
                [~, indices] = ismember(tempNames, app.colNameTranslate(:,2));
                tempNames = app.colNameTranslate(indices,1);
                tempTable = app.CoreTable(:,tempNames);

                writetable(tempTable,[filepath, filename],'Delimiter','\t');
            end
            drawnow();
        end

        % Button pushed function: LoadButton
        function LoadButtonPushed(app, event)
            filter = {'*.csv'};
            [filename,filepath] = uigetfile(filter);
            % tempTable = app.InputDiscreteTable.Data;
            if ~isequal(filename,0)
                tempTable = readtable([filepath, filename],'Delimiter','\t');

                % write to inputDiscreteTable?
                
                % clear CoreTable
                ResetCoreTable(app);
                
                % write to CoreTable
                numFiles = height(tempTable);
                for row=(1:numFiles)
                    if row == 1
                        app.CoreTable = app.newRowCore;
                    else
                        app.CoreTable = [app.CoreTable; app.newRowCore];
                    end
                    app.NumFiles = app.NumFiles + 1;
                    app.CoreTable.Path(row) = tempTable.Path(row);
                    app.CoreTable.SR(row) = tempTable.SR(row);
                    app.CoreTable.Gain(row) = tempTable.Gain(row);
                    app.CoreTable.RemoveOffsetCheck(row) = tempTable.RemoveOffsetCheck(row);
                    app.CoreTable.TimeOffset(row) = tempTable.TimeOffset(row);
                    app.CoreTable.SigFreqU(row) = tempTable.SigFreqU(row);
                    app.CoreTable.SigSens(row) = tempTable.SigSens(row);
                    app.CoreTable.Thresh(row) = tempTable.Thresh(row);
                    % fill other values in CoreTable: Filename, CalMode,
                    % SigFreqStart, SigFreqEnd, SigFreqMid,
                    UpdateFreqs(app, row)
                    UpdateSigCal(app, row)
                    UpdateAmbCal(app, row)
                    UpdateFilenames(app, row)
                    UpdateWav(app, row);
                                
                end
                RefreshInputTable(app)
                BlockOutput(app, true)
                AnalyzeEnable(app)

            end
            drawnow();
        end

        % Cell selection callback: StatTable
        function StatTableCellSelection(app, event)
            % select cell in table to highlight that signal in the graph
            indices = event.Indices;
            % loop through all existing patches to clear highlighting from any others
            patchList = findobj(app.WaveAxes, 'type', 'patch');
            if height(indices) > 0  % one or more cells selected
                idx = unique(indices(:,1));  % get rows that are included in selection
            else
                idx = 0;
            end
            
            for i = 1:length(patchList)
                currPatch = patchList(i);
                if any(idx(:) == i)

                    currPatch.EdgeColor = [0 0 0];
                else
                    % clear border from all other patches
                    currPatch.EdgeColor = 'none';
                end

            end
            
        end

        % Button pushed function: SpecSettingsButton
        function SpecSettingsButtonPushed(app, event)
            row = GetCurrentRow(app);
            SpecSettingsPopup(app, row)
        end

        % Value changed function: DownSampCheckBox
        function DownSampCheckBoxValueChanged(app, event)
            value = app.DownSampCheckBox.Value;
            app.DownSampField.Enable = value;
            BlockOutput(app, true)
        end

        % Value changed function: FilterDropDown
        function FilterDropDownValueChanged(app, event)
            for row=1:app.NumFiles
                UpdateFreqs(app, row)
            end
            BlockOutput(app, true)
        end

        % Value changed function: DownSampField
        function DownSampFieldValueChanged(app, event)
            BlockOutput(app, true)
            app.analysisHasRun = false;
        end

        % Value changed function: CurrSpecTimeRes
        function CurrSpecTimeResValueChanged(app, event)
            CursorWait(app, 'on')
            row = GetCurrentRow(app);
            value = app.CurrSpecTimeRes.Value;
            
            app.CoreTable.SpecTimeRes(row) = value;
            SpectrogramUpdate(app, row)
            SpectrogramPlot(app, row)
            % BlockOutput(app, true)
            % AnalyzeEnable(app)
            CursorWait(app, 'off')
        end

        % Value changed function: ReferenceLevelDropDown
        function ReferenceLevelDropDownValueChanged(app, event)
            value = app.ReferenceLevelDropDown.Value;
            
            if strcmpi(value, "1 µPa")
                dBref = 1;
            else
                dBref = 20;
            end
            newColNames = {'Call Start|Time'; ...
                    'Call End|Time'; 'Vocal Type'; 'Duration|(ms)'; ...
                    sprintf('RMS|(dB re %d µPa)', dBref); ...
                    sprintf('Peak|(dB re %d µPa)', dBref); ...
                    sprintf('SPL 90%|(dB re %d µPa)', dBref)};
            app.StatTable.ColumnName = newColNames;
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create SignalFinderUIFigure and hide until all components are created
            app.SignalFinderUIFigure = uifigure('Visible', 'off');
            app.SignalFinderUIFigure.Position = [100 100 1200 670];
            app.SignalFinderUIFigure.Name = 'Signal Finder';

            % Create GridLayout
            app.GridLayout = uigridlayout(app.SignalFinderUIFigure);
            app.GridLayout.ColumnWidth = {'1x', 'fit'};
            app.GridLayout.RowHeight = {'fit', 23, 23, '3x', 'fit'};
            app.GridLayout.ColumnSpacing = 8;
            app.GridLayout.RowSpacing = 8;
            app.GridLayout.Padding = [8 8 8 8];

            % Create ResultsGrid
            app.ResultsGrid = uigridlayout(app.GridLayout);
            app.ResultsGrid.ColumnWidth = {'fit', '1x', '1x', 'fit'};
            app.ResultsGrid.RowHeight = {'1x', 'fit'};
            app.ResultsGrid.ColumnSpacing = 8;
            app.ResultsGrid.RowSpacing = 5;
            app.ResultsGrid.Padding = [0 0 0 5];
            app.ResultsGrid.Layout.Row = 4;
            app.ResultsGrid.Layout.Column = [1 2];

            % Create GridLayout2
            app.GridLayout2 = uigridlayout(app.ResultsGrid);
            app.GridLayout2.ColumnWidth = {'1x'};
            app.GridLayout2.RowHeight = {'fit', '1x'};
            app.GridLayout2.ColumnSpacing = 8;
            app.GridLayout2.RowSpacing = 8;
            app.GridLayout2.Padding = [0 0 0 0];
            app.GridLayout2.Layout.Row = 1;
            app.GridLayout2.Layout.Column = 1;

            % Create FileListBoxLabel
            app.FileListBoxLabel = uilabel(app.GridLayout2);
            app.FileListBoxLabel.HorizontalAlignment = 'center';
            app.FileListBoxLabel.Layout.Row = 1;
            app.FileListBoxLabel.Layout.Column = 1;
            app.FileListBoxLabel.Text = 'File';

            % Create FileListBox
            app.FileListBox = uilistbox(app.GridLayout2);
            app.FileListBox.Items = {};
            app.FileListBox.ValueChangedFcn = createCallbackFcn(app, @FileListBoxValueChanged, true);
            app.FileListBox.Enable = 'off';
            app.FileListBox.Layout.Row = 2;
            app.FileListBox.Layout.Column = 1;
            app.FileListBox.Value = {};

            % Create ResultsButtonGrid
            app.ResultsButtonGrid = uigridlayout(app.ResultsGrid);
            app.ResultsButtonGrid.ColumnWidth = {'1x', '1x', '1x'};
            app.ResultsButtonGrid.RowHeight = {22};
            app.ResultsButtonGrid.ColumnSpacing = 8;
            app.ResultsButtonGrid.RowSpacing = 0;
            app.ResultsButtonGrid.Padding = [0 0 0 0];
            app.ResultsButtonGrid.Layout.Row = 2;
            app.ResultsButtonGrid.Layout.Column = 4;

            % Create SaveStatsButton
            app.SaveStatsButton = uibutton(app.ResultsButtonGrid, 'push');
            app.SaveStatsButton.ButtonPushedFcn = createCallbackFcn(app, @SaveStatsButtonPushed, true);
            app.SaveStatsButton.Enable = 'off';
            app.SaveStatsButton.Tooltip = {'Saves call table for currently selected file'};
            app.SaveStatsButton.Layout.Row = 1;
            app.SaveStatsButton.Layout.Column = 2;
            app.SaveStatsButton.Text = 'Save Stats';

            % Create SaveAllStatsButton
            app.SaveAllStatsButton = uibutton(app.ResultsButtonGrid, 'push');
            app.SaveAllStatsButton.ButtonPushedFcn = createCallbackFcn(app, @SaveAllStatsButtonPushed, true);
            app.SaveAllStatsButton.Enable = 'off';
            app.SaveAllStatsButton.Tooltip = {'Saves call table for all analyzed files into a single csv file'};
            app.SaveAllStatsButton.Layout.Row = 1;
            app.SaveAllStatsButton.Layout.Column = 3;
            app.SaveAllStatsButton.Text = 'Save All Stats';

            % Create SplitRecButton
            app.SplitRecButton = uibutton(app.ResultsButtonGrid, 'push');
            app.SplitRecButton.ButtonPushedFcn = createCallbackFcn(app, @SplitRecButtonPushed, true);
            app.SplitRecButton.Enable = 'off';
            app.SplitRecButton.Tooltip = {'Split selected recording into individual files for each detected call'};
            app.SplitRecButton.Layout.Row = 1;
            app.SplitRecButton.Layout.Column = 1;
            app.SplitRecButton.Text = 'Split Recording File';

            % Create SaveWaveButton
            app.SaveWaveButton = uibutton(app.ResultsGrid, 'push');
            app.SaveWaveButton.ButtonPushedFcn = createCallbackFcn(app, @SaveWaveButtonPushed, true);
            app.SaveWaveButton.Enable = 'off';
            app.SaveWaveButton.Layout.Row = 2;
            app.SaveWaveButton.Layout.Column = [2 3];
            app.SaveWaveButton.Text = 'Save Figure';

            % Create DiscreteResultsPanel
            app.DiscreteResultsPanel = uipanel(app.ResultsGrid);
            app.DiscreteResultsPanel.Title = 'Discrete Results';
            app.DiscreteResultsPanel.Layout.Row = 1;
            app.DiscreteResultsPanel.Layout.Column = 2;

            % Create DiscreteResultsPanelGrid
            app.DiscreteResultsPanelGrid = uigridlayout(app.DiscreteResultsPanel);
            app.DiscreteResultsPanelGrid.ColumnWidth = {'1x'};
            app.DiscreteResultsPanelGrid.RowHeight = {'1x'};
            app.DiscreteResultsPanelGrid.Padding = [0 0 0 0];

            % Create DiscreteResultsTabGroup
            app.DiscreteResultsTabGroup = uitabgroup(app.DiscreteResultsPanelGrid);
            app.DiscreteResultsTabGroup.Layout.Row = 1;
            app.DiscreteResultsTabGroup.Layout.Column = 1;

            % Create WaveformuPaTab
            app.WaveformuPaTab = uitab(app.DiscreteResultsTabGroup);
            app.WaveformuPaTab.Title = 'Waveform (uPa)';

            % Create WaveGrid
            app.WaveGrid = uigridlayout(app.WaveformuPaTab);
            app.WaveGrid.ColumnWidth = {'1x'};
            app.WaveGrid.RowHeight = {'1x'};
            app.WaveGrid.ColumnSpacing = 8;
            app.WaveGrid.RowSpacing = 8;
            app.WaveGrid.Padding = [0 8 0 0];

            % Create WaveAxes
            app.WaveAxes = uiaxes(app.WaveGrid);
            xlabel(app.WaveAxes, 'Time (s)')
            ylabel(app.WaveAxes, 'Amplitude (µPa)')
            zlabel(app.WaveAxes, 'Z')
            app.WaveAxes.YTick = [-1 0 1];
            app.WaveAxes.YTickLabel = {'-1'; '0'; '1'};
            app.WaveAxes.ColorOrder = [0 0.447058823529412 0.741176470588235;0.850980392156863 0.325490196078431 0.0980392156862745;0.929411764705882 0.694117647058824 0.125490196078431;0.494117647058824 0.184313725490196 0.556862745098039;0.466666666666667 0.674509803921569 0.188235294117647;0.301960784313725 0.745098039215686 0.933333333333333;0.63921568627451 0.0784313725490196 0.180392156862745];
            app.WaveAxes.Layout.Row = 1;
            app.WaveAxes.Layout.Column = 1;

            % Create WaveformdBTab
            app.WaveformdBTab = uitab(app.DiscreteResultsTabGroup);
            app.WaveformdBTab.Title = 'Waveform (dB)';

            % Create WavedBGrid
            app.WavedBGrid = uigridlayout(app.WaveformdBTab);
            app.WavedBGrid.ColumnWidth = {'1x'};
            app.WavedBGrid.RowHeight = {'1x'};
            app.WavedBGrid.ColumnSpacing = 8;
            app.WavedBGrid.RowSpacing = 8;
            app.WavedBGrid.Padding = [0 8 0 0];

            % Create WavedBAxes
            app.WavedBAxes = uiaxes(app.WavedBGrid);
            xlabel(app.WavedBAxes, 'Time (s)')
            ylabel(app.WavedBAxes, 'Amplitude (dB)')
            zlabel(app.WavedBAxes, 'Z')
            app.WavedBAxes.YTick = [-1 0 1];
            app.WavedBAxes.YTickLabel = {'-1'; '0'; '1'};
            app.WavedBAxes.ColorOrder = [0 0.447058823529412 0.741176470588235;0.850980392156863 0.325490196078431 0.0980392156862745;0.929411764705882 0.694117647058824 0.125490196078431;0.494117647058824 0.184313725490196 0.556862745098039;0.466666666666667 0.674509803921569 0.188235294117647;0.301960784313725 0.745098039215686 0.933333333333333;0.63921568627451 0.0784313725490196 0.180392156862745];
            app.WavedBAxes.Layout.Row = 1;
            app.WavedBAxes.Layout.Column = 1;

            % Create SpectrogramTab
            app.SpectrogramTab = uitab(app.DiscreteResultsTabGroup);
            app.SpectrogramTab.Title = 'Spectrogram';

            % Create SpecGrid
            app.SpecGrid = uigridlayout(app.SpectrogramTab);
            app.SpecGrid.ColumnWidth = {'1x', 'fit', 'fit', '1x'};
            app.SpecGrid.RowHeight = {'1x', 22};
            app.SpecGrid.ColumnSpacing = 8;
            app.SpecGrid.RowSpacing = 8;
            app.SpecGrid.Padding = [0 8 0 0];

            % Create SpecAxes
            app.SpecAxes = uiaxes(app.SpecGrid);
            xlabel(app.SpecAxes, 'Time (s)')
            ylabel(app.SpecAxes, 'Frequency (Hz)')
            zlabel(app.SpecAxes, 'Z')
            app.SpecAxes.Layout.Row = 1;
            app.SpecAxes.Layout.Column = [1 4];

            % Create TimeResolutionLabel
            app.TimeResolutionLabel = uilabel(app.SpecGrid);
            app.TimeResolutionLabel.HorizontalAlignment = 'right';
            app.TimeResolutionLabel.Layout.Row = 2;
            app.TimeResolutionLabel.Layout.Column = 2;
            app.TimeResolutionLabel.Text = 'Time Resolution';

            % Create CurrSpecTimeRes
            app.CurrSpecTimeRes = uieditfield(app.SpecGrid, 'numeric');
            app.CurrSpecTimeRes.Limits = [0 Inf];
            app.CurrSpecTimeRes.ValueDisplayFormat = '%11.4g s';
            app.CurrSpecTimeRes.ValueChangedFcn = createCallbackFcn(app, @CurrSpecTimeResValueChanged, true);
            app.CurrSpecTimeRes.Layout.Row = 2;
            app.CurrSpecTimeRes.Layout.Column = 3;

            % Create PSDTab
            app.PSDTab = uitab(app.DiscreteResultsTabGroup);
            app.PSDTab.Title = 'PSD';

            % Create PSDGrid
            app.PSDGrid = uigridlayout(app.PSDTab);
            app.PSDGrid.ColumnWidth = {'1x'};
            app.PSDGrid.RowHeight = {'1x'};
            app.PSDGrid.ColumnSpacing = 8;
            app.PSDGrid.RowSpacing = 8;
            app.PSDGrid.Padding = [0 8 0 0];

            % Create PSDAxes
            app.PSDAxes = uiaxes(app.PSDGrid);
            xlabel(app.PSDAxes, 'Frequency (Hz)')
            ylabel(app.PSDAxes, 'PSD (dB re 1 uPa^2/Hz)')
            zlabel(app.PSDAxes, 'Z')
            app.PSDAxes.Layout.Row = 1;
            app.PSDAxes.Layout.Column = 1;

            % Create StatTable
            app.StatTable = uitable(app.ResultsGrid);
            app.StatTable.ColumnName = {'Call Start|Time'; 'Call End|Time'; 'Vocal Type'; 'Duration|(ms)'; 'RMS|(dB re 1µPa)'; 'Peak|(dB re 1µPa)'; 'SPL 90%|(dB re 1µPa)'};
            app.StatTable.ColumnWidth = {75, 75, 75, 75, 86, 86, 86};
            app.StatTable.RowName = {};
            app.StatTable.CellSelectionCallback = createCallbackFcn(app, @StatTableCellSelection, true);
            app.StatTable.Enable = 'off';
            app.StatTable.Layout.Row = 1;
            app.StatTable.Layout.Column = 4;

            % Create AmbientResultsPanel
            app.AmbientResultsPanel = uipanel(app.ResultsGrid);
            app.AmbientResultsPanel.Title = 'Ambient Results';
            app.AmbientResultsPanel.Layout.Row = 1;
            app.AmbientResultsPanel.Layout.Column = 3;

            % Create AmbientResultsPanelGrid
            app.AmbientResultsPanelGrid = uigridlayout(app.AmbientResultsPanel);
            app.AmbientResultsPanelGrid.ColumnWidth = {'1x'};
            app.AmbientResultsPanelGrid.RowHeight = {'1x'};
            app.AmbientResultsPanelGrid.Padding = [0 0 0 0];

            % Create AmbientResultsTabGroup
            app.AmbientResultsTabGroup = uitabgroup(app.AmbientResultsPanelGrid);
            app.AmbientResultsTabGroup.Layout.Row = 1;
            app.AmbientResultsTabGroup.Layout.Column = 1;

            % Create LZeqTab
            app.LZeqTab = uitab(app.AmbientResultsTabGroup);
            app.LZeqTab.Title = 'LZeq';

            % Create LZeqGrid
            app.LZeqGrid = uigridlayout(app.LZeqTab);
            app.LZeqGrid.ColumnWidth = {'1x'};
            app.LZeqGrid.RowHeight = {'1x'};
            app.LZeqGrid.ColumnSpacing = 8;
            app.LZeqGrid.RowSpacing = 8;
            app.LZeqGrid.Padding = [0 8 0 0];

            % Create LZeqAxes
            app.LZeqAxes = uiaxes(app.LZeqGrid);
            xlabel(app.LZeqAxes, 'Center Frequency (Hz)')
            ylabel(app.LZeqAxes, 'LZeq (dB re 1uPa^2)')
            zlabel(app.LZeqAxes, 'Z')
            app.LZeqAxes.YTick = [-1 0 1];
            app.LZeqAxes.YTickLabel = {'-1'; '0'; '1'};
            app.LZeqAxes.ColorOrder = [0 0.447058823529412 0.741176470588235;0.850980392156863 0.325490196078431 0.0980392156862745;0.929411764705882 0.694117647058824 0.125490196078431;0.494117647058824 0.184313725490196 0.556862745098039;0.466666666666667 0.674509803921569 0.188235294117647;0.301960784313725 0.745098039215686 0.933333333333333;0.63921568627451 0.0784313725490196 0.180392156862745];
            app.LZeqAxes.Layout.Row = 1;
            app.LZeqAxes.Layout.Column = 1;

            % Create MSLTab
            app.MSLTab = uitab(app.AmbientResultsTabGroup);
            app.MSLTab.Title = 'MSL';

            % Create MSLGrid
            app.MSLGrid = uigridlayout(app.MSLTab);
            app.MSLGrid.ColumnWidth = {'1x'};
            app.MSLGrid.RowHeight = {'1x'};
            app.MSLGrid.ColumnSpacing = 8;
            app.MSLGrid.RowSpacing = 8;
            app.MSLGrid.Padding = [0 8 0 0];

            % Create MSLAxes
            app.MSLAxes = uiaxes(app.MSLGrid);
            xlabel(app.MSLAxes, 'Center Frequency (Hz)')
            ylabel(app.MSLAxes, 'MSL (dB re 1 uPa^2/Hz)')
            zlabel(app.MSLAxes, 'Z')
            app.MSLAxes.Layout.Row = 1;
            app.MSLAxes.Layout.Column = 1;

            % Create AnalyzeButton
            app.AnalyzeButton = uibutton(app.GridLayout, 'push');
            app.AnalyzeButton.ButtonPushedFcn = createCallbackFcn(app, @AnalyzeButtonPushed, true);
            app.AnalyzeButton.Enable = 'off';
            app.AnalyzeButton.Layout.Row = 3;
            app.AnalyzeButton.Layout.Column = [1 2];
            app.AnalyzeButton.Text = 'Analysis Unavailable';

            % Create WarningLabel
            app.WarningLabel = uilabel(app.GridLayout);
            app.WarningLabel.HorizontalAlignment = 'center';
            app.WarningLabel.WordWrap = 'on';
            app.WarningLabel.FontWeight = 'bold';
            app.WarningLabel.FontColor = [1 0 0];
            app.WarningLabel.Visible = 'off';
            app.WarningLabel.Layout.Row = 5;
            app.WarningLabel.Layout.Column = 1;
            app.WarningLabel.Text = 'Parameters changed, re-run analysis for updated results';

            % Create OutputGrid
            app.OutputGrid = uigridlayout(app.GridLayout);
            app.OutputGrid.ColumnWidth = {80, '1x', 22};
            app.OutputGrid.RowHeight = {'fit'};
            app.OutputGrid.ColumnSpacing = 4;
            app.OutputGrid.RowSpacing = 8;
            app.OutputGrid.Padding = [0 0 0 0];
            app.OutputGrid.Layout.Row = 2;
            app.OutputGrid.Layout.Column = [1 2];

            % Create OutputPathSelect
            app.OutputPathSelect = uibutton(app.OutputGrid, 'push');
            app.OutputPathSelect.ButtonPushedFcn = createCallbackFcn(app, @OutputPathSelectButtonPushed, true);
            app.OutputPathSelect.IconAlignment = 'center';
            app.OutputPathSelect.Tooltip = {'Select file'};
            app.OutputPathSelect.Layout.Row = 1;
            app.OutputPathSelect.Layout.Column = 3;
            app.OutputPathSelect.Text = '...';

            % Create OutputPathLabel
            app.OutputPathLabel = uilabel(app.OutputGrid);
            app.OutputPathLabel.HorizontalAlignment = 'right';
            app.OutputPathLabel.Layout.Row = 1;
            app.OutputPathLabel.Layout.Column = 1;
            app.OutputPathLabel.Text = 'Output Folder';

            % Create OutputPathField
            app.OutputPathField = uieditfield(app.OutputGrid, 'text');
            app.OutputPathField.Layout.Row = 1;
            app.OutputPathField.Layout.Column = 2;

            % Create InputGrid
            app.InputGrid = uigridlayout(app.GridLayout);
            app.InputGrid.ColumnWidth = {'fit', 200, 150, 'fit'};
            app.InputGrid.RowHeight = {24, '1x'};
            app.InputGrid.ColumnSpacing = 8;
            app.InputGrid.RowSpacing = 8;
            app.InputGrid.Padding = [0 0 0 0];
            app.InputGrid.Layout.Row = 1;
            app.InputGrid.Layout.Column = [1 2];

            % Create FilePanel
            app.FilePanel = uipanel(app.InputGrid);
            app.FilePanel.BackgroundColor = [0.9412 0.9412 0.9412];
            app.FilePanel.Layout.Row = [1 2];
            app.FilePanel.Layout.Column = 4;

            % Create DiscreteButtonGrid
            app.DiscreteButtonGrid = uigridlayout(app.FilePanel);
            app.DiscreteButtonGrid.ColumnWidth = {'1x', 23, 23, 4, 38, 4};
            app.DiscreteButtonGrid.RowHeight = {23, '1x', 'fit', 4, 'fit', '1x', 23};
            app.DiscreteButtonGrid.ColumnSpacing = 0;
            app.DiscreteButtonGrid.RowSpacing = 0;
            app.DiscreteButtonGrid.Padding = [0 0 0 0];
            app.DiscreteButtonGrid.BackgroundColor = [0.902 0.902 0.902];

            % Create LoadButton
            app.LoadButton = uibutton(app.DiscreteButtonGrid, 'push');
            app.LoadButton.ButtonPushedFcn = createCallbackFcn(app, @LoadButtonPushed, true);
            app.LoadButton.Tooltip = {'Load .csv file to table'};
            app.LoadButton.Layout.Row = 5;
            app.LoadButton.Layout.Column = 5;
            app.LoadButton.Text = 'Load';

            % Create SaveButton
            app.SaveButton = uibutton(app.DiscreteButtonGrid, 'push');
            app.SaveButton.ButtonPushedFcn = createCallbackFcn(app, @SaveButtonPushed, true);
            app.SaveButton.Tooltip = {'Save table to .csv file'};
            app.SaveButton.Layout.Row = 3;
            app.SaveButton.Layout.Column = 5;
            app.SaveButton.Text = 'Save';

            % Create DeleteDiscreteRowButton
            app.DeleteDiscreteRowButton = uibutton(app.DiscreteButtonGrid, 'push');
            app.DeleteDiscreteRowButton.ButtonPushedFcn = createCallbackFcn(app, @DeleteDiscreteRowButtonPushed, true);
            app.DeleteDiscreteRowButton.IconAlignment = 'center';
            app.DeleteDiscreteRowButton.FontWeight = 'bold';
            app.DeleteDiscreteRowButton.Tooltip = {'Remove a row'};
            app.DeleteDiscreteRowButton.Layout.Row = 7;
            app.DeleteDiscreteRowButton.Layout.Column = 3;
            app.DeleteDiscreteRowButton.Text = '−';

            % Create AddDiscreteRowButton
            app.AddDiscreteRowButton = uibutton(app.DiscreteButtonGrid, 'push');
            app.AddDiscreteRowButton.ButtonPushedFcn = createCallbackFcn(app, @AddDiscreteRowButtonPushed, true);
            app.AddDiscreteRowButton.IconAlignment = 'center';
            app.AddDiscreteRowButton.Tooltip = {'Add a row'};
            app.AddDiscreteRowButton.Layout.Row = 7;
            app.AddDiscreteRowButton.Layout.Column = 2;
            app.AddDiscreteRowButton.Text = '+';

            % Create InputDiscreteTable
            app.InputDiscreteTable = uitable(app.DiscreteButtonGrid);
            app.InputDiscreteTable.ColumnName = {'Path'; 'SR|(Hz)'; 'Gain|(dB)'; 'Remove|Offset'; 'Start Time|Offset (s)'; 'Sig Freq|(Hz)'; 'Sig|Sens'; 'Thresh|(dB)'};
            app.InputDiscreteTable.ColumnWidth = {170, 60, 60, 70, 80, 80, 60, 70};
            app.InputDiscreteTable.RowName = {};
            app.InputDiscreteTable.ColumnEditable = true;
            app.InputDiscreteTable.CellEditCallback = createCallbackFcn(app, @InputDiscreteTableCellEdit, true);
            app.InputDiscreteTable.SelectionChangedFcn = createCallbackFcn(app, @InputDiscreteTableSelectionChanged, true);
            app.InputDiscreteTable.Multiselect = 'off';
            app.InputDiscreteTable.Layout.Row = [1 6];
            app.InputDiscreteTable.Layout.Column = [1 3];

            % Create AnalysisSettingsPanel
            app.AnalysisSettingsPanel = uipanel(app.InputGrid);
            app.AnalysisSettingsPanel.Layout.Row = 2;
            app.AnalysisSettingsPanel.Layout.Column = [1 3];

            % Create AnalysisSettingsGrid
            app.AnalysisSettingsGrid = uigridlayout(app.AnalysisSettingsPanel);
            app.AnalysisSettingsGrid.ColumnWidth = {'fit', 89, 105, '1x', 204, 203};
            app.AnalysisSettingsGrid.RowHeight = {23, 23, 17, '1x'};
            app.AnalysisSettingsGrid.ColumnSpacing = 8;
            app.AnalysisSettingsGrid.RowSpacing = 8;
            app.AnalysisSettingsGrid.Padding = [4 4 4 4];
            app.AnalysisSettingsGrid.BackgroundColor = [0.9216 0.9216 0.9216];

            % Create UnitDropDownLabel
            app.UnitDropDownLabel = uilabel(app.AnalysisSettingsGrid);
            app.UnitDropDownLabel.HorizontalAlignment = 'right';
            app.UnitDropDownLabel.Layout.Row = 1;
            app.UnitDropDownLabel.Layout.Column = 2;
            app.UnitDropDownLabel.Text = 'Calibration Unit';

            % Create DiscreteSettingsPanel
            app.DiscreteSettingsPanel = uipanel(app.AnalysisSettingsGrid);
            app.DiscreteSettingsPanel.Layout.Row = [1 4];
            app.DiscreteSettingsPanel.Layout.Column = 6;

            % Create GridLayout3
            app.GridLayout3 = uigridlayout(app.DiscreteSettingsPanel);
            app.GridLayout3.ColumnWidth = {100, 'fit'};
            app.GridLayout3.RowHeight = {'fit', 'fit', 'fit'};
            app.GridLayout3.ColumnSpacing = 8;
            app.GridLayout3.RowSpacing = 8;
            app.GridLayout3.Padding = [8 8 8 8];

            % Create MinGapLabel
            app.MinGapLabel = uilabel(app.GridLayout3);
            app.MinGapLabel.HorizontalAlignment = 'right';
            app.MinGapLabel.Layout.Row = 1;
            app.MinGapLabel.Layout.Column = 1;
            app.MinGapLabel.Text = 'Minimum Gap';

            % Create MinGapField
            app.MinGapField = uieditfield(app.GridLayout3, 'numeric');
            app.MinGapField.Limits = [0 Inf];
            app.MinGapField.ValueDisplayFormat = '%11.4g s';
            app.MinGapField.ValueChangedFcn = createCallbackFcn(app, @MinGapFieldValueChanged, true);
            app.MinGapField.Tooltip = {'Minimum gap between detected sounds before they''re considered separate'};
            app.MinGapField.Layout.Row = 1;
            app.MinGapField.Layout.Column = 2;
            app.MinGapField.Value = 0.4;

            % Create MinLengthLabel
            app.MinLengthLabel = uilabel(app.GridLayout3);
            app.MinLengthLabel.HorizontalAlignment = 'right';
            app.MinLengthLabel.Layout.Row = 2;
            app.MinLengthLabel.Layout.Column = 1;
            app.MinLengthLabel.Text = 'Minimum Length';

            % Create MinLengthField
            app.MinLengthField = uieditfield(app.GridLayout3, 'numeric');
            app.MinLengthField.Limits = [0.1 Inf];
            app.MinLengthField.ValueDisplayFormat = '%11.4g s';
            app.MinLengthField.ValueChangedFcn = createCallbackFcn(app, @MinGapFieldValueChanged, true);
            app.MinLengthField.Layout.Row = 2;
            app.MinLengthField.Layout.Column = 2;
            app.MinLengthField.Value = 0.1;

            % Create FilterDropDownLabel
            app.FilterDropDownLabel = uilabel(app.GridLayout3);
            app.FilterDropDownLabel.HorizontalAlignment = 'right';
            app.FilterDropDownLabel.Layout.Row = 3;
            app.FilterDropDownLabel.Layout.Column = 1;
            app.FilterDropDownLabel.Text = 'Filter';

            % Create FilterDropDown
            app.FilterDropDown = uidropdown(app.GridLayout3);
            app.FilterDropDown.Items = {'None', '3rd Oct', 'Exact'};
            app.FilterDropDown.ValueChangedFcn = createCallbackFcn(app, @FilterDropDownValueChanged, true);
            app.FilterDropDown.Layout.Row = 3;
            app.FilterDropDown.Layout.Column = 2;
            app.FilterDropDown.Value = '3rd Oct';

            % Create AmbientSettingsPanel
            app.AmbientSettingsPanel = uipanel(app.AnalysisSettingsGrid);
            app.AmbientSettingsPanel.Layout.Row = [1 4];
            app.AmbientSettingsPanel.Layout.Column = 5;

            % Create AmbientSettingsGrid
            app.AmbientSettingsGrid = uigridlayout(app.AmbientSettingsPanel);
            app.AmbientSettingsGrid.ColumnWidth = {56, 75, 39};
            app.AmbientSettingsGrid.RowHeight = {22, 22, 23};
            app.AmbientSettingsGrid.ColumnSpacing = 8;
            app.AmbientSettingsGrid.RowSpacing = 8;
            app.AmbientSettingsGrid.Padding = [8 8 8 8];

            % Create FreqNoneButton
            app.FreqNoneButton = uibutton(app.AmbientSettingsGrid, 'push');
            app.FreqNoneButton.ButtonPushedFcn = createCallbackFcn(app, @FreqNoneButtonPushed, true);
            app.FreqNoneButton.Layout.Row = 2;
            app.FreqNoneButton.Layout.Column = 3;
            app.FreqNoneButton.Text = 'None';

            % Create FreqAllButton
            app.FreqAllButton = uibutton(app.AmbientSettingsGrid, 'push');
            app.FreqAllButton.ButtonPushedFcn = createCallbackFcn(app, @FreqAllButtonPushed, true);
            app.FreqAllButton.Layout.Row = 1;
            app.FreqAllButton.Layout.Column = 3;
            app.FreqAllButton.Text = 'All';

            % Create AmbFreqListBoxLabel
            app.AmbFreqListBoxLabel = uilabel(app.AmbientSettingsGrid);
            app.AmbFreqListBoxLabel.HorizontalAlignment = 'right';
            app.AmbFreqListBoxLabel.VerticalAlignment = 'top';
            app.AmbFreqListBoxLabel.WordWrap = 'on';
            app.AmbFreqListBoxLabel.Layout.Row = [1 2];
            app.AmbFreqListBoxLabel.Layout.Column = 1;
            app.AmbFreqListBoxLabel.Text = 'Freq Band (Hz)';

            % Create AmbFreqListBox
            app.AmbFreqListBox = uilistbox(app.AmbientSettingsGrid);
            app.AmbFreqListBox.Items = {'6.3', '8', '10', '12.5', '16', '20', '25', '31.5', '40', '50', '63', '80', '100', '125', '160', '200', '250', '315', '400', '500', '630', '800', '1000', '1250', '1600', '2000', '2500', '3150', '4000', '5000', '6300', '8000', '10000', '12500', '16000', '20000', '25000', '31500', '40000'};
            app.AmbFreqListBox.ItemsData = {'6.3', '8', '10', '12.5', '16', '20', '25', '31.5', '40', '50', '63', '80', '100', '125', '160', '200', '250', '315', '400', '500', '630', '800', '1000', '1250', '1600', '2000', '2500', '3150', '4000', '5000', '6300', '8000', '10000', '12500', '16000', '20000', '25000', '31500', '40000'};
            app.AmbFreqListBox.Multiselect = 'on';
            app.AmbFreqListBox.ValueChangedFcn = createCallbackFcn(app, @AmbFreqListBoxValueChanged, true);
            app.AmbFreqListBox.Layout.Row = [1 3];
            app.AmbFreqListBox.Layout.Column = 2;
            app.AmbFreqListBox.Value = {};

            % Create SpectrogramCheckBox
            app.SpectrogramCheckBox = uicheckbox(app.AnalysisSettingsGrid);
            app.SpectrogramCheckBox.Text = 'Spectrogram';
            app.SpectrogramCheckBox.Layout.Row = 4;
            app.SpectrogramCheckBox.Layout.Column = 3;

            % Create DownSampField
            app.DownSampField = uieditfield(app.AnalysisSettingsGrid, 'numeric');
            app.DownSampField.Limits = [0 Inf];
            app.DownSampField.ValueDisplayFormat = '%11.0f Hz';
            app.DownSampField.ValueChangedFcn = createCallbackFcn(app, @DownSampFieldValueChanged, true);
            app.DownSampField.Layout.Row = 3;
            app.DownSampField.Layout.Column = 3;
            app.DownSampField.Value = 1000;

            % Create DownSampCheckBox
            app.DownSampCheckBox = uicheckbox(app.AnalysisSettingsGrid);
            app.DownSampCheckBox.ValueChangedFcn = createCallbackFcn(app, @DownSampCheckBoxValueChanged, true);
            app.DownSampCheckBox.Text = 'Downsampling';
            app.DownSampCheckBox.Layout.Row = 3;
            app.DownSampCheckBox.Layout.Column = [1 2];
            app.DownSampCheckBox.Value = true;

            % Create UnitDropDown
            app.UnitDropDown = uidropdown(app.AnalysisSettingsGrid);
            app.UnitDropDown.Items = {'dB re 1V/µPa', 'mV/Pa', 'dB re 1V/Pa', 'dB re 1µPa'};
            app.UnitDropDown.Layout.Row = 1;
            app.UnitDropDown.Layout.Column = 3;
            app.UnitDropDown.Value = 'dB re 1µPa';

            % Create ReferenceLevelDropDownLabel
            app.ReferenceLevelDropDownLabel = uilabel(app.AnalysisSettingsGrid);
            app.ReferenceLevelDropDownLabel.HorizontalAlignment = 'right';
            app.ReferenceLevelDropDownLabel.Layout.Row = 2;
            app.ReferenceLevelDropDownLabel.Layout.Column = 2;
            app.ReferenceLevelDropDownLabel.Text = 'Reference Level';

            % Create ReferenceLevelDropDown
            app.ReferenceLevelDropDown = uidropdown(app.AnalysisSettingsGrid);
            app.ReferenceLevelDropDown.Items = {'1 µPa', '20 µPa'};
            app.ReferenceLevelDropDown.ValueChangedFcn = createCallbackFcn(app, @ReferenceLevelDropDownValueChanged, true);
            app.ReferenceLevelDropDown.Layout.Row = 2;
            app.ReferenceLevelDropDown.Layout.Column = 3;
            app.ReferenceLevelDropDown.Value = '1 µPa';

            % Create SkipAmbientCheckBox
            app.SkipAmbientCheckBox = uicheckbox(app.InputGrid);
            app.SkipAmbientCheckBox.Text = 'Skip Ambient Analysis';
            app.SkipAmbientCheckBox.Layout.Row = 1;
            app.SkipAmbientCheckBox.Layout.Column = 3;

            % Create ModeButtonGroup
            app.ModeButtonGroup = uibuttongroup(app.InputGrid);
            app.ModeButtonGroup.SelectionChangedFcn = createCallbackFcn(app, @ModeButtonGroupSelectionChanged, true);
            app.ModeButtonGroup.BorderWidth = 2;
            app.ModeButtonGroup.Layout.Row = 1;
            app.ModeButtonGroup.Layout.Column = 2;

            % Create DiscreteButton
            app.DiscreteButton = uiradiobutton(app.ModeButtonGroup);
            app.DiscreteButton.Text = 'Discrete';
            app.DiscreteButton.Position = [19 1 66 22];
            app.DiscreteButton.Value = true;

            % Create AmbientButton
            app.AmbientButton = uiradiobutton(app.ModeButtonGroup);
            app.AmbientButton.Text = 'Ambient';
            app.AmbientButton.Position = [116 1 66 22];

            % Create VersionLabel
            app.VersionLabel = uilabel(app.GridLayout);
            app.VersionLabel.Layout.Row = 5;
            app.VersionLabel.Layout.Column = 2;
            app.VersionLabel.Text = 'v1.2.0';

            % Create SpecSettingsButton
            app.SpecSettingsButton = uibutton(app.SignalFinderUIFigure, 'push');
            app.SpecSettingsButton.ButtonPushedFcn = createCallbackFcn(app, @SpecSettingsButtonPushed, true);
            app.SpecSettingsButton.Enable = 'off';
            app.SpecSettingsButton.Position = [288 -62 284 22];
            app.SpecSettingsButton.Text = 'Spectrogram Settings';

            % Show the figure after all components are created
            app.SignalFinderUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = signalFinder_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.SignalFinderUIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.SignalFinderUIFigure)
        end
    end
end