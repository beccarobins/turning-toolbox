Exp = {'Participant'};
load('ExpInfo');
[j,k] = size(ExpConditions);
for c = 1:j
    Exp = horzcat(Exp,ExpConditions(c,1)); %#ok<*AGROW>
end
Exp = horzcat(Exp,'Trial Number');
Heading = {};
for j = 1:20
    Heading = horzcat(Heading,strcat('Fast Phase',{' '},num2str(j),{' '},'Onset'));
    Heading = horzcat(Heading,strcat('Fast Phase',{' '},num2str(j),{' '},'Amplitude'));
    Heading = horzcat(Heading,strcat('Fast Phase',{' '},num2str(j),{' '},'Velocity'));
    Heading = horzcat(Heading,strcat('Fast Phase',{' '},num2str(j),{' '},'Acceleration'));
end
Heading = horzcat(Heading,'Mean Fast Phase Amplitude');
Heading = horzcat(Heading,'SD Fast Phase Amplitude');
Heading = horzcat(Heading,'Maximum Fast Phase Amplitude');
Heading = horzcat(Heading,'Mean Fast Phase Velocity');
Heading = horzcat(Heading,'SD Fast Phase Velocity');
Heading = horzcat(Heading,'Peak Fast Phase Velocity');
Heading = horzcat(Heading,'Mean Fast Phase Acceleration');
Heading = horzcat(Heading,'SD Fast Phase Acceleration');
Heading = horzcat(Heading,'Peak Fast Phase Acceleration');
Heading = horzcat(Heading,'# of Fast Phases');
Heading = horzcat(Heading,'Nystagmus Fast Phase Frequency');

HeadingExport = horzcat(Exp,Heading);

load('ParticipantID');
load('ExpInfo');

Filename = sprintf(char(strcat(ExpName,{' '},ParticipantID,{' '},'Eye Data.xlsx')));
warning('off','all');
xlswrite(Filename,HeadingExport,'Trial Data','A1');
xlswrite(Filename,HeadingExport,'Mean Data','A1');
TF = strcmp(ExpConditions(1,1),'Direction');
if TF==1
    xlswrite(Filename,HeadingExport,'Collapsed Mean Data','A1');
end

excelFilePath = pwd; % Current working directory.
sheetName = 'Sheet'; % EN: Sheet, DE: Tabelle, etc. (Lang. dependent)
% Open Excel file.
objExcel = actxserver('Excel.Application');
objExcel.Workbooks.Open(fullfile(excelFilePath, Filename)); % Full path is necessary!
% Delete sheets.
try
    % Throws an error if the sheets do not exist.
    objExcel.ActiveWorkbook.Worksheets.Item([sheetName '1']).Delete;
    objExcel.ActiveWorkbook.Worksheets.Item([sheetName '2']).Delete;
    objExcel.ActiveWorkbook.Worksheets.Item([sheetName '3']).Delete;
catch
    % Do nothing.
end
% Save, close and clean up.
objExcel.ActiveWorkbook.Save;
objExcel.ActiveWorkbook.Close;
objExcel.Quit;
objExcel.delete;
%xlswrite(Filename,Heading,'Sheet1','CV1');
for k = 1:NumTrials
    ParticipantNum(k,:) = {ParticipantID}; %#ok<*SAGROW>
    TrialNumbers(k,:) = num2cell(k);
    Conditions(k,:) = {ParticipantID};
end
Conditions = horzcat(Conditions,TrialList,TrialNumbers);
for TrialNum = 1:NumTrials;
    load('ParticipantID');
    load('ExpInfo');
    if TrialNum<=9
        load(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
    elseif TrialNum>9
        load(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
    end
    
    TF = strcmp(TrialCondition,'Dummy Trial');
    
    if TF == 0;
        DataExport = [];
        if FastPhases.Total>0
            for k = 1:FastPhases.Total
                DataExport= horzcat(DataExport,FastPhases.Onsets_sec(k,:),FastPhases.Amplitudes(k,:),FastPhases.Velocities(k,:),FastPhases.Accelerations(k,:));
            end
            Blank = NaN(1,(20-FastPhases.Total)*4);
            DataExport = horzcat(DataExport,Blank);
            DataExport = horzcat(DataExport,FastPhases.MeanAmp);
            DataExport = horzcat(DataExport,FastPhases.SDAmp);
            DataExport = horzcat(DataExport,FastPhases.MaxAmp);
            DataExport = horzcat(DataExport,FastPhases.MeanVel);
            DataExport = horzcat(DataExport,FastPhases.SDVel);
            DataExport = horzcat(DataExport,FastPhases.PeakVel);
            DataExport = horzcat(DataExport,FastPhases.MeanAcc);
            DataExport = horzcat(DataExport,FastPhases.SDAcc);
            DataExport = horzcat(DataExport,FastPhases.PeakAcc);
            DataExport = horzcat(DataExport,FastPhases.Total);
            DataExport = horzcat(DataExport,FastPhases.NFPF);
            Data(TrialNum,:) = DataExport;
        elseif FastPhases.Total==0
            [j,k] = size(ExpConditions);
            DataExport = nan(1,length(Heading));
            Data(TrialNum,:) = DataExport;
        end
    elseif TF == 1
        [j,k] = size(ExpConditions);
        DataExport = nan(1,length(Heading));
        Data(TrialNum,:) = DataExport;
    end
    clearvars -except Data Conditions Exp Heading HeadingExport j
end

AllData = horzcat(Conditions,num2cell(Data));
load('ParticipantID');
load('ExpInfo');
Filename = sprintf(char(strcat(ExpName,{' '},ParticipantID,{' '},'Eye Data.xlsx')));
xlswrite(Filename,AllData,'Trial Data','A2');

[a,b,c] = xlsread(char(strcat(ExpName,{' '},ParticipantID,{' '},'Eye Data.xlsx'))); %#ok<*ASGLU>

[row,col] = size(ExpConditions);

Condition1AOrdered = {};Condition1BOrdered = {};Condition1COrdered = {};Condition1DOrdered = {};

Condition1A_2AOrdered = {};Condition1B_2AOrdered = {};Condition1C_2AOrdered = {};Condition1D_2AOrdered = {};
Condition1A_2BOrdered = {};Condition1B_2BOrdered = {};Condition1C_2BOrdered = {};Condition1D_2BOrdered = {};
Condition1A_2COrdered = {};Condition1B_2COrdered = {};Condition1C_2COrdered = {};Condition1D_2COrdered = {};
Condition1A_2DOrdered = {};Condition1B_2DOrdered = {};Condition1C_2DOrdered = {};Condition1D_2DOrdered = {};

Condition1A_2A_3AOrdered = {};Condition1B_2A_3AOrdered = {};Condition1C_2A_3AOrdered = {};Condition1D_2A_3AOrdered = {};
Condition1A_2B_3AOrdered = {};Condition1B_2B_3AOrdered = {};Condition1C_2B_3AOrdered = {};Condition1D_2B_3AOrdered = {};
Condition1A_2C_3AOrdered = {};Condition1B_2C_3AOrdered = {};Condition1C_2C_3AOrdered = {};Condition1D_2C_3AOrdered = {};
Condition1A_2D_3AOrdered = {};Condition1B_2D_3AOrdered = {};Condition1C_2D_3AOrdered = {};Condition1D_2D_3AOrdered = {};
Condition1A_2A_3BOrdered = {};Condition1B_2A_3BOrdered = {};Condition1C_2A_3BOrdered = {};Condition1D_2A_3BOrdered = {};
Condition1A_2B_3BOrdered = {};Condition1B_2B_3BOrdered = {};Condition1C_2B_3BOrdered = {};Condition1D_2B_3BOrdered = {};
Condition1A_2C_3BOrdered = {};Condition1B_2C_3BOrdered = {};Condition1C_2C_3BOrdered = {};Condition1D_2C_3BOrdered = {};
Condition1A_2D_3BOrdered = {};Condition1B_2D_3BOrdered = {};Condition1C_2D_3BOrdered = {};Condition1D_2D_3BOrdered = {};
Condition1A_2A_3COrdered = {};Condition1B_2A_3COrdered = {};Condition1C_2A_3COrdered = {};Condition1D_2A_3COrdered = {};
Condition1A_2B_3COrdered = {};Condition1B_2B_3COrdered = {};Condition1C_2B_3COrdered = {};Condition1D_2B_3COrdered = {};
Condition1A_2C_3COrdered = {};Condition1B_2C_3COrdered = {};Condition1C_2C_3COrdered = {};Condition1D_2C_3COrdered = {};
Condition1A_2D_3COrdered = {};Condition1B_2D_3COrdered = {};Condition1C_2D_3COrdered = {};Condition1D_2D_3COrdered = {};
Condition1A_2A_3DOrdered = {};Condition1B_2A_3DOrdered = {};Condition1C_2A_3DOrdered = {};Condition1D_2A_3DOrdered = {};
Condition1A_2B_3DOrdered = {};Condition1B_2B_3DOrdered = {};Condition1C_2B_3DOrdered = {};Condition1D_2B_3DOrdered = {};
Condition1A_2C_3DOrdered = {};Condition1B_2C_3DOrdered = {};Condition1C_2C_3DOrdered = {};Condition1D_2C_3DOrdered = {};
Condition1A_2D_3DOrdered = {};Condition1B_2D_3DOrdered = {};Condition1C_2D_3DOrdered = {};Condition1D_2D_3DOrdered = {};

if cell2mat(ExpConditions(1,2))>=2
    Condition1A = find(strcmp(ExpConditions(1,3), c(:,2)));
    Condition1B = find(strcmp(ExpConditions(1,4), c(:,2)));
    for n = 1:length(Condition1A);
        B = Condition1A(n,1);
        Condition1AOrdered(n,:) = c(B,:);
    end
    
    for n = 1:length(Condition1B);
        B = Condition1B(n,1);
        Condition1BOrdered(n,:) = c(B,:);
    end
end
if cell2mat(ExpConditions(1,2))>=3
    Condition1C = find(strcmp(ExpConditions(1,5), c(:,2)));
    for n = 1:length(Condition1C);
        B = Condition1C(n,1);
        Condition1COrdered(n,:) = c(B,:);
    end
end

if cell2mat(ExpConditions(1,2))==4
    Condition1D = find(strcmp(ExpConditions(1,6), c(:,2)));
    for n = 1:length(Condition1D);
        B = Condition1D(n,1);
        Condition1DOrdered(n,:) = c(B,:);
    end
end

if row>=2
    if cell2mat(ExpConditions(1,2))>=2&&cell2mat(ExpConditions(2,2))>=2
        Condition1A_2A= find(strcmp(ExpConditions(2,3), Condition1AOrdered(:,3)));
        Condition1A_2B = find(strcmp(ExpConditions(2,4), Condition1AOrdered(:,3)));
        Condition1B_2A= find(strcmp(ExpConditions(2,3), Condition1BOrdered(:,3)));
        Condition1B_2B = find(strcmp(ExpConditions(2,4), Condition1BOrdered(:,3)));
        for n = 1:length(Condition1A_2A);
            B = Condition1A_2A(n,1);
            Condition1A_2AOrdered(n,:) = Condition1AOrdered(B,:);
        end
        for n = 1:length(Condition1A_2B);
            B = Condition1A_2B(n,1);
            Condition1A_2BOrdered(n,:) = Condition1AOrdered(B,:);
        end
        for n = 1:length(Condition1B_2A);
            B = Condition1B_2A(n,1);
            Condition1B_2AOrdered(n,:) = Condition1BOrdered(B,:);
        end
        for n = 1:length(Condition1B_2B);
            B = Condition1B_2B(n,1);
            Condition1B_2BOrdered(n,:) = Condition1BOrdered(B,:);
        end
    end
    if cell2mat(ExpConditions(1,2))>=2&&cell2mat(ExpConditions(2,2))>=3
        Condition1A_2C = find(strcmp(ExpConditions(2,5), Condition1AOrdered(:,3)));
        Condition1B_2C = find(strcmp(ExpConditions(2,5), Condition1BOrdered(:,3)));
        for n = 1:length(Condition1A_2C);
            B = Condition1A_2C(n,1);
            Condition1A_2COrdered(n,:) = Condition1AOrdered(B,:);
        end
        for n = 1:length(Condition1B_2C);
            B = Condition1B_2C(n,1);
            Condition1B_2COrdered(n,:) = Condition1BOrdered(B,:);
        end
    end
    if cell2mat(ExpConditions(1,2))>=2&&cell2mat(ExpConditions(2,2))>=4
        Condition1A_2D = find(strcmp(ExpConditions(2,6), Condition1AOrdered(:,3)));
        Condition1B_2D = find(strcmp(ExpConditions(2,6), Condition1BOrdered(:,3)));
        for n = 1:length(Condition1A_2D);
            B = Condition1A_2D(n,1);
            Condition1A_2DOrdered(n,:) = Condition1AOrdered(B,:);
        end
        for n = 1:length(Condition1B_2D);
            B = Condition1B_2D(n,1);
            Condition1B_2DOrdered(n,:) = Condition1BOrdered(B,:);
        end
    end
    if cell2mat(ExpConditions(1,2))>=3&&cell2mat(ExpConditions(2,2))>=2
        Condition1C_2A= find(strcmp(ExpConditions(2,3), Condition1COrdered(:,3)));
        Condition1C_2B = find(strcmp(ExpConditions(2,4), Condition1COrdered(:,3)));
        for n = 1:length(Condition1C_2A);
            B = Condition1C_2A(n,1);
            Condition1C_2AOrdered(n,:) = Condition1COrdered(B,:);
        end
        for n = 1:length(Condition1C_2B);
            B = Condition1C_2B(n,1);
            Condition1C_2BOrdered(n,:) = Condition1COrdered(B,:);
        end
    end
    if cell2mat(ExpConditions(1,2))>=3&&cell2mat(ExpConditions(2,2))>=3
        Condition1C_2C = find(strcmp(ExpConditions(2,6), Condition1COrdered(:,3)));
        for n = 1:length(Condition1C_2C);
            B = Condition1C_2C(n,1);
            Condition1C_2COrdered(n,:) = Condition1COrdered(B,:);
        end
    end
    if cell2mat(ExpConditions(1,2))==3&&cell2mat(ExpConditions(2,2))==4
        Condition1C_2D = find(strcmp(ExpConditions(2,6), Condition1COrdered(:,3)));
        for n = 1:length(Condition1C_2D);
            B = Condition1C_2D(n,1);
            Condition1C_2DOrdered(n,:) = Condition1COrdered(B,:);
        end
    end
    if cell2mat(ExpConditions(1,2))==4&&cell2mat(ExpConditions(2,2))>=2
        Condition1D_2A= find(strcmp(ExpConditions(2,3), Condition1DOrdered(:,3)));
        Condition1D_2B = find(strcmp(ExpConditions(2,4), Condition1DOrdered(:,3)));
        for n = 1:length(Condition1D_2A);
            B = Condition1D_2A(n,1);
            Condition1D_2AOrdered(n,:) = Condition1DOrdered(B,:);
        end
        for n = 1:length(Condition1D_2B);
            B = Condition1D_2B(n,1);
            Condition1D_2BOrdered(n,:) = Condition1DOrdered(B,:);
        end
    end
    if cell2mat(ExpConditions(1,2))==4&&cell2mat(ExpConditions(2,2))>=3
        Condition1D_2C = find(strcmp(ExpConditions(2,5), Condition1DOrdered(:,3)));
        for n = 1:length(Condition1D_2C);
            B = Condition1D_2C(n,1);
            Condition1D_2COrdered(n,:) = Condition1DOrdered(B,:);
        end
    end
    if cell2mat(ExpConditions(1,2))==4&&cell2mat(ExpConditions(2,2))==4
        Condition1D_2D = find(strcmp(ExpConditions(2,6), Condition1DOrdered(:,3)));
        for n = 1:length(Condition1D_2D);
            B = Condition1D_2D(n,1);
            Condition1D_2DOrdered(n,:) = Condition1DOrdered(B,:);
        end
    end
end

if row>2
    if cell2mat(ExpConditions(1,2))>=2&&cell2mat(ExpConditions(2,2))>=2&&cell2mat(ExpConditions(3,2))>=2
        
        Condition1A_2A_3A= find(strcmp(ExpConditions(3,3), Condition1A_2AOrdered(:,4)));
        Condition1A_2A_3B = find(strcmp(ExpConditions(3,4), Condition1A_2AOrdered(:,4)));
        Condition1A_2B_3A= find(strcmp(ExpConditions(3,3), Condition1A_2BOrdered(:,4)));
        Condition1A_2B_3B = find(strcmp(ExpConditions(3,4), Condition1A_2BOrdered(:,4)));
        Condition1B_2A_3A= find(strcmp(ExpConditions(3,3), Condition1B_2AOrdered(:,4)));
        Condition1B_2A_3B = find(strcmp(ExpConditions(3,4), Condition1B_2AOrdered(:,4)));
        Condition1B_2B_3A= find(strcmp(ExpConditions(3,3), Condition1B_2BOrdered(:,4)));
        Condition1B_2B_3B = find(strcmp(ExpConditions(3,4), Condition1B_2BOrdered(:,4)));
        
        for n = 1:length(Condition1A_2A_3A);
            B = Condition1A_2A_3A(n,1);
            Condition1A_2A_3AOrdered(n,:) = Condition1A_2AOrdered(B,:);
        end
        for n = 1:length(Condition1A_2A_3B);
            B = Condition1A_2A_3B(n,1);
            Condition1A_2A_3BOrdered(n,:) = Condition1A_2AOrdered(B,:);
        end
        for n = 1:length(Condition1A_2B_3A);
            B = Condition1A_2B_3A(n,1);
            Condition1A_2B_3AOrdered(n,:) = Condition1A_2BOrdered(B,:);
        end
        for n = 1:length(Condition1A_2B_3B);
            B = Condition1A_2B_3B(n,1);
            Condition1A_2B_3BOrdered(n,:) = Condition1A_2BOrdered(B,:);
        end
        for n = 1:length(Condition1B_2A_3A);
            B = Condition1B_2A_3A(n,1);
            Condition1B_2A_3AOrdered(n,:) = Condition1B_2AOrdered(B,:);
        end
        for n = 1:length(Condition1B_2A_3B);
            B = Condition1B_2A_3B(n,1);
            Condition1B_2A_3BOrdered(n,:) = Condition1B_2AOrdered(B,:);
        end
        for n = 1:length(Condition1B_2B_3A);
            B = Condition1B_2B_3A(n,1);
            Condition1B_2B_3AOrdered(n,:) = Condition1B_2BOrdered(B,:);
        end
        for n = 1:length(Condition1B_2B_3B);
            B = Condition1B_2B_3B(n,1);
            Condition1B_2B_3BOrdered(n,:) = Condition1B_2BOrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=2&&cell2mat(ExpConditions(2,2))>=2&&cell2mat(ExpConditions(3,2))>=3
        
        Condition1A_2A_3C= find(strcmp(ExpConditions(3,5), Condition1A_2AOrdered(:,4)));
        Condition1A_2B_3C= find(strcmp(ExpConditions(3,5), Condition1A_2BOrdered(:,4)));
        Condition1B_2A_3C= find(strcmp(ExpConditions(3,5), Condition1B_2AOrdered(:,4)));
        Condition1B_2B_3C= find(strcmp(ExpConditions(3,5), Condition1B_2BOrdered(:,4)));
        
        for n = 1:length(Condition1A_2A_3C);
            B = Condition1A_2A_3C(n,1);
            Condition1A_2A_3COrdered(n,:) = Condition1A_2AOrdered(B,:);
        end
        for n = 1:length(Condition1A_2B_3C);
            B = Condition1A_2B_3C(n,1);
            Condition1A_2B_3COrdered(n,:) = Condition1A_2BOrdered(B,:);
        end
        for n = 1:length(Condition1B_2A_3C);
            B = Condition1B_2A_3C(n,1);
            Condition1B_2A_3COrdered(n,:) = Condition1B_2AOrdered(B,:);
        end
        for n = 1:length(Condition1B_2B_3C);
            B = Condition1B_2B_3C(n,1);
            Condition1B_2B_3COrdered(n,:) = Condition1B_2BOrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=2&&cell2mat(ExpConditions(2,2))>=2&&cell2mat(ExpConditions(3,2))>=4
        
        Condition1A_2A_3D= find(strcmp(ExpConditions(3,6), Condition1A_2AOrdered(:,4)));
        Condition1A_2B_3D= find(strcmp(ExpConditions(3,6), Condition1A_2BOrdered(:,4)));
        Condition1B_2A_3D= find(strcmp(ExpConditions(3,6), Condition1B_2AOrdered(:,4)));
        Condition1B_2B_3D= find(strcmp(ExpConditions(3,6), Condition1B_2BOrdered(:,4)));
        
        for n = 1:length(Condition1A_2A_3D);
            B = Condition1A_2A_3D(n,1);
            Condition1A_2A_3DOrdered(n,:) = Condition1A_2AOrdered(B,:);
        end
        for n = 1:length(Condition1A_2B_3D);
            B = Condition1A_2B_3D(n,1);
            Condition1A_2B_3DOrdered(n,:) = Condition1A_2BOrdered(B,:);
        end
        for n = 1:length(Condition1B_2A_3D);
            B = Condition1B_2A_3D(n,1);
            Condition1B_2A_3DOrdered(n,:) = Condition1B_2AOrdered(B,:);
        end
        for n = 1:length(Condition1B_2B_3D);
            B = Condition1B_2B_3D(n,1);
            Condition1B_2B_3DOrdered(n,:) = Condition1B_2BOrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=2&&cell2mat(ExpConditions(2,2))>=3&&cell2mat(ExpConditions(3,2))>=2
        
        Condition1A_2C_3A= find(strcmp(ExpConditions(3,3), Condition1A_2COrdered(:,4)));
        Condition1A_2C_3B= find(strcmp(ExpConditions(3,4), Condition1A_2COrdered(:,4)));
        Condition1B_2C_3A= find(strcmp(ExpConditions(3,3), Condition1B_2COrdered(:,4)));
        Condition1B_2C_3B= find(strcmp(ExpConditions(3,4), Condition1B_2COrdered(:,4)));
        
        for n = 1:length(Condition1A_2C_3A);
            B = Condition1A_2C_3A(n,1);
            Condition1A_2C_3AOrdered(n,:) = Condition1A_2COrdered(B,:);
        end
        for n = 1:length(Condition1A_2C_3B);
            B = Condition1A_2C_3B(n,1);
            Condition1A_2C_3BOrdered(n,:) = Condition1A_2COrdered(B,:);
        end
        for n = 1:length(Condition1B_2C_3A);
            B = Condition1B_2C_3A(n,1);
            Condition1B_2C_3AOrdered(n,:) = Condition1B_2COrdered(B,:);
        end
        for n = 1:length(Condition1B_2C_3B);
            B = Condition1B_2C_3B(n,1);
            Condition1B_2C_3BOrdered(n,:) = Condition1B_2COrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=2&&cell2mat(ExpConditions(2,2))>=3&&cell2mat(ExpConditions(3,2))>=3
        
        Condition1A_2C_3C= find(strcmp(ExpConditions(3,5), Condition1A_2COrdered(:,4)));
        Condition1B_2C_3C= find(strcmp(ExpConditions(3,5), Condition1B_2COrdered(:,4)));
        
        for n = 1:length(Condition1A_2C_3C);
            B = Condition1A_2C_3C(n,1);
            Condition1A_2C_3COrdered(n,:) = Condition1A_2COrdered(B,:);
        end
        for n = 1:length(Condition1B_2C_3C);
            B = Condition1B_2C_3C(n,1);
            Condition1B_2C_3COrdered(n,:) = Condition1B_2COrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=2&&cell2mat(ExpConditions(2,2))>=3&&cell2mat(ExpConditions(3,2))>=4
        
        Condition1A_2C_3D= find(strcmp(ExpConditions(3,6), Condition1A_2COrdered(:,4)));
        Condition1B_2C_3D= find(strcmp(ExpConditions(3,6), Condition1B_2COrdered(:,4)));
        
        for n = 1:length(Condition1A_2C_3D);
            B = Condition1A_2C_3D(n,1);
            Condition1A_2C_3DOrdered(n,:) = Condition1A_2COrdered(B,:);
        end
        for n = 1:length(Condition1B_2C_3D);
            B = Condition1B_2C_3D(n,1);
            Condition1B_2C_3DOrdered(n,:) = Condition1B_2COrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=2&&cell2mat(ExpConditions(2,2))>=4&&cell2mat(ExpConditions(3,2))>=2
        
        Condition1A_2D_3A= find(strcmp(ExpConditions(3,3), Condition1A_2DOrdered(:,4)));
        Condition1A_2D_3B= find(strcmp(ExpConditions(3,4), Condition1A_2DOrdered(:,4)));
        Condition1B_2D_3A= find(strcmp(ExpConditions(3,3), Condition1B_2DOrdered(:,4)));
        Condition1B_2D_3B= find(strcmp(ExpConditions(3,4), Condition1B_2DOrdered(:,4)));
        
        for n = 1:length(Condition1A_2D_3A);
            B = Condition1A_2D_3A(n,1);
            Condition1A_2D_3AOrdered(n,:) = Condition1A_2DOrdered(B,:);
        end
        for n = 1:length(Condition1A_2D_3B);
            B = Condition1A_2D_3B(n,1);
            Condition1A_2D_3BOrdered(n,:) = Condition1A_2DOrdered(B,:);
        end
        for n = 1:length(Condition1B_2D_3A);
            B = Condition1B_2D_3A(n,1);
            Condition1B_2D_3AOrdered(n,:) = Condition1B_2DOrdered(B,:);
        end
        for n = 1:length(Condition1B_2D_3B);
            B = Condition1B_2D_3B(n,1);
            Condition1B_2D_3BOrdered(n,:) = Condition1B_2DOrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=2&&cell2mat(ExpConditions(2,2))>=4&&cell2mat(ExpConditions(3,2))>=3
        
        Condition1A_2D_3C= find(strcmp(ExpConditions(3,5), Condition1A_2DOrdered(:,4)));
        Condition1B_2D_3C= find(strcmp(ExpConditions(3,5), Condition1B_2DOrdered(:,4)));
        
        for n = 1:length(Condition1A_2D_3C);
            B = Condition1A_2D_3C(n,1);
            Condition1A_2D_3COrdered(n,:) = Condition1A_2DOrdered(B,:);
        end
        for n = 1:length(Condition1B_2D_3C);
            B = Condition1B_2D_3C(n,1);
            Condition1B_2D_3COrdered(n,:) = Condition1B_2DOrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=2&&cell2mat(ExpConditions(2,2))>=4&&cell2mat(ExpConditions(3,2))>=4
        
        Condition1A_2D_3D= find(strcmp(ExpConditions(3,6), Condition1A_2DOrdered(:,4)));
        Condition1B_2D_3D= find(strcmp(ExpConditions(3,6), Condition1B_2DOrdered(:,4)));
        
        for n = 1:length(Condition1A_2D_3D);
            B = Condition1A_2D_3D(n,1);
            Condition1A_2D_3DOrdered(n,:) = Condition1A_2DOrdered(B,:);
        end
        for n = 1:length(Condition1B_2D_3D);
            B = Condition1B_2D_3D(n,1);
            Condition1B_2D_3DOrdered(n,:) = Condition1B_2DOrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=3&&cell2mat(ExpConditions(2,2))>=2&&cell2mat(ExpConditions(3,2))>=2
        
        Condition1C_2A_3A= find(strcmp(ExpConditions(3,3), Condition1C_2AOrdered(:,4)));
        Condition1C_2A_3B = find(strcmp(ExpConditions(3,4), Condition1C_2AOrdered(:,4)));
        Condition1C_2B_3A= find(strcmp(ExpConditions(3,3), Condition1C_2BOrdered(:,4)));
        Condition1C_2B_3B = find(strcmp(ExpConditions(3,4), Condition1C_2BOrdered(:,4)));
        
        for n = 1:length(Condition1C_2A_3A);
            B = Condition1C_2A_3A(n,1);
            Condition1C_2A_3AOrdered(n,:) = Condition1C_2AOrdered(B,:);
        end
        for n = 1:length(Condition1C_2A_3B);
            B = Condition1C_2A_3B(n,1);
            Condition1C_2A_3BOrdered(n,:) = Condition1C_2AOrdered(B,:);
        end
        for n = 1:length(Condition1C_2B_3A);
            B = Condition1C_2B_3A(n,1);
            Condition1C_2B_3AOrdered(n,:) = Condition1C_2BOrdered(B,:);
        end
        for n = 1:length(Condition1C_2B_3B);
            B = Condition1C_2B_3B(n,1);
            Condition1C_2B_3BOrdered(n,:) = Condition1C_2BOrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=3&&cell2mat(ExpConditions(2,2))>=2&&cell2mat(ExpConditions(3,2))>=3
        Condition1C_2A_3C= find(strcmp(ExpConditions(3,5), Condition1C_2AOrdered(:,4)));
        Condition1C_2B_3C= find(strcmp(ExpConditions(3,5), Condition1C_2BOrdered(:,4)));
        
        for n = 1:length(Condition1C_2A_3C);
            B = Condition1C_2A_3C(n,1);
            Condition1C_2A_3COrdered(n,:) = Condition1C_2AOrdered(B,:);
        end
        for n = 1:length(Condition1C_2B_3C);
            B = Condition1C_2B_3C(n,1);
            Condition1C_2B_3COrdered(n,:) = Condition1C_2BOrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=3&&cell2mat(ExpConditions(2,2))>=2&&cell2mat(ExpConditions(3,2))>=4
        
        Condition1C_2A_3D= find(strcmp(ExpConditions(3,6), Condition1C_2AOrdered(:,4)));
        Condition1C_2B_3D= find(strcmp(ExpConditions(3,6), Condition1C_2BOrdered(:,4)));
        
        for n = 1:length(Condition1C_2A_3D);
            B = Condition1C_2A_3D(n,1);
            Condition1C_2A_3DOrdered(n,:) = Condition1C_2AOrdered(B,:);
        end
        for n = 1:length(Condition1C_2B_3D);
            B = Condition1C_2B_3D(n,1);
            Condition1C_2B_3DOrdered(n,:) = Condition1C_2BOrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=3&&cell2mat(ExpConditions(2,2))>=3&&cell2mat(ExpConditions(3,2))>=2
        
        Condition1C_2C_3A= find(strcmp(ExpConditions(3,3), Condition1C_2COrdered(:,4)));
        Condition1C_2C_3B= find(strcmp(ExpConditions(3,4), Condition1C_2COrdered(:,4)));
        
        for n = 1:length(Condition1C_2C_3A);
            B = Condition1C_2C_3A(n,1);
            Condition1C_2C_3AOrdered(n,:) = Condition1C_2COrdered(B,:);
        end
        for n = 1:length(Condition1C_2C_3B);
            B = Condition1C_2C_3B(n,1);
            Condition1C_2C_3BOrdered(n,:) = Condition1C_2COrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=3&&cell2mat(ExpConditions(2,2))>=3&&cell2mat(ExpConditions(3,2))>=3
        
        Condition1C_2C_3C= find(strcmp(ExpConditions(3,5), Condition1C_2COrdered(:,4)));
        
        for n = 1:length(Condition1C_2C_3C);
            B = Condition1C_2C_3C(n,1);
            Condition1C_2C_3COrdered(n,:) = Condition1C_2COrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=3&&cell2mat(ExpConditions(2,2))>=3&&cell2mat(ExpConditions(3,2))>=4
        
        Condition1C_2C_3D= find(strcmp(ExpConditions(3,6), Condition1C_2COrdered(:,4)));
        
        for n = 1:length(Condition1C_2C_3D);
            B = Condition1C_2C_3D(n,1);
            Condition1C_2C_3DOrdered(n,:) = Condition1C_2COrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=3&&cell2mat(ExpConditions(2,2))>=4&&cell2mat(ExpConditions(3,2))>=2
        
        Condition1C_2D_3A= find(strcmp(ExpConditions(3,3), Condition1C_2DOrdered(:,4)));
        Condition1C_2D_3B= find(strcmp(ExpConditions(3,4), Condition1C_2DOrdered(:,4)));
        
        for n = 1:length(Condition1C_2D_3A);
            B = Condition1C_2D_3A(n,1);
            Condition1C_2D_3AOrdered(n,:) = Condition1C_2DOrdered(B,:);
        end
        for n = 1:length(Condition1C_2D_3B);
            B = Condition1C_2D_3B(n,1);
            Condition1C_2D_3BOrdered(n,:) = Condition1C_2DOrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=3&&cell2mat(ExpConditions(2,2))>=4&&cell2mat(ExpConditions(3,2))>=3
        
        Condition1C_2D_3C= find(strcmp(ExpConditions(3,5), Condition1C_2DOrdered(:,4)));
        
        for n = 1:length(Condition1C_2D_3C);
            B = Condition1C_2D_3C(n,1);
            Condition1C_2D_3COrdered(n,:) = Condition1C_2DOrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=3&&cell2mat(ExpConditions(2,2))>=4&&cell2mat(ExpConditions(3,2))>=4
        
        Condition1C_2D_3D= find(strcmp(ExpConditions(3,6), Condition1C_2DOrdered(:,4)));
        
        for n = 1:length(Condition1C_2D_3D);
            B = Condition1C_2D_3D(n,1);
            Condition1C_2D_3DOrdered(n,:) = Condition1C_2DOrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=4&&cell2mat(ExpConditions(2,2))>=2&&cell2mat(ExpConditions(3,2))>=2
        
        Condition1D_2A_3A= find(strcmp(ExpConditions(3,3), Condition1D_2AOrdered(:,4)));
        Condition1D_2A_3B = find(strcmp(ExpConditions(3,4), Condition1D_2AOrdered(:,4)));
        Condition1D_2B_3A= find(strcmp(ExpConditions(3,3), Condition1D_2BOrdered(:,4)));
        Condition1D_2B_3B = find(strcmp(ExpConditions(3,4), Condition1D_2BOrdered(:,4)));
        
        for n = 1:length(Condition1D_2A_3A);
            B = Condition1D_2A_3A(n,1);
            Condition1D_2A_3AOrdered(n,:) = Condition1D_2AOrdered(B,:);
        end
        for n = 1:length(Condition1D_2A_3B);
            B = Condition1D_2A_3B(n,1);
            Condition1D_2A_3BOrdered(n,:) = Condition1D_2AOrdered(B,:);
        end
        for n = 1:length(Condition1D_2B_3A);
            B = Condition1D_2B_3A(n,1);
            Condition1D_2B_3AOrdered(n,:) = Condition1D_2BOrdered(B,:);
        end
        for n = 1:length(Condition1D_2B_3B);
            B = Condition1D_2B_3B(n,1);
            Condition1D_2B_3BOrdered(n,:) = Condition1D_2BOrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=4&&cell2mat(ExpConditions(2,2))>=2&&cell2mat(ExpConditions(3,2))>=3
        
        Condition1D_2A_3C= find(strcmp(ExpConditions(3,5), Condition1D_2AOrdered(:,4)));
        Condition1D_2B_3C= find(strcmp(ExpConditions(3,5), Condition1D_2BOrdered(:,4)));
        
        for n = 1:length(Condition1D_2A_3C);
            B = Condition1D_2A_3C(n,1);
            Condition1D_2A_3COrdered(n,:) = Condition1D_2AOrdered(B,:);
        end
        for n = 1:length(Condition1D_2B_3C);
            B = Condition1D_2B_3C(n,1);
            Condition1D_2B_3COrdered(n,:) = Condition1D_2BOrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=4&&cell2mat(ExpConditions(2,2))>=2&&cell2mat(ExpConditions(3,2))>=4
        
        Condition1D_2A_3D= find(strcmp(ExpConditions(3,6), Condition1D_2AOrdered(:,4)));
        Condition1D_2B_3D= find(strcmp(ExpConditions(3,6), Condition1D_2BOrdered(:,4)));
        
        for n = 1:length(Condition1D_2A_3D);
            B = Condition1D_2A_3D(n,1);
            Condition1D_2A_3DOrdered(n,:) = Condition1D_2AOrdered(B,:);
        end
        for n = 1:length(Condition1D_2B_3D);
            B = Condition1D_2B_3D(n,1);
            Condition1D_2B_3DOrdered(n,:) = Condition1D_2BOrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=4&&cell2mat(ExpConditions(2,2))>=3&&cell2mat(ExpConditions(3,2))>=2
        
        Condition1D_2C_3A= find(strcmp(ExpConditions(3,3), Condition1D_2COrdered(:,4)));
        Condition1D_2C_3B= find(strcmp(ExpConditions(3,4), Condition1D_2COrdered(:,4)));
        
        for n = 1:length(Condition1D_2C_3A);
            B = Condition1D_2C_3A(n,1);
            Condition1D_2C_3AOrdered(n,:) = Condition1D_2COrdered(B,:);
        end
        for n = 1:length(Condition1D_2C_3B);
            B = Condition1D_2C_3B(n,1);
            Condition1D_2C_3BOrdered(n,:) = Condition1D_2COrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=4&&cell2mat(ExpConditions(2,2))>=3&&cell2mat(ExpConditions(3,2))>=3
        
        Condition1D_2C_3C= find(strcmp(ExpConditions(3,5), Condition1D_2COrdered(:,4)));
        
        for n = 1:length(Condition1D_2C_3C);
            B = Condition1D_2C_3C(n,1);
            Condition1D_2C_3COrdered(n,:) = Condition1D_2COrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=4&&cell2mat(ExpConditions(2,2))>=3&&cell2mat(ExpConditions(3,2))>=4
        
        Condition1D_2C_3D= find(strcmp(ExpConditions(3,6), Condition1D_2COrdered(:,4)));
        
        for n = 1:length(Condition1D_2C_3D);
            B = Condition1D_2C_3D(n,1);
            Condition1D_2C_3DOrdered(n,:) = Condition1D_2COrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=4&&cell2mat(ExpConditions(2,2))>=4&&cell2mat(ExpConditions(3,2))>=2
        
        Condition1D_2D_3A= find(strcmp(ExpConditions(3,3), Condition1D_2DOrdered(:,4)));
        Condition1D_2D_3B= find(strcmp(ExpConditions(3,4), Condition1D_2DOrdered(:,4)));
        
        for n = 1:length(Condition1D_2D_3A);
            B = Condition1D_2D_3A(n,1);
            Condition1D_2D_3AOrdered(n,:) = Condition1D_2DOrdered(B,:);
        end
        for n = 1:length(Condition1D_2D_3B);
            B = Condition1D_2D_3B(n,1);
            Condition1D_2D_3BOrdered(n,:) = Condition1D_2DOrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=4&&cell2mat(ExpConditions(2,2))>=4&&cell2mat(ExpConditions(3,2))>=3
        
        Condition1D_2D_3C= find(strcmp(ExpConditions(3,5), Condition1D_2DOrdered(:,4)));
        
        for n = 1:length(Condition1D_2D_3C);
            B = Condition1D_2D_3C(n,1);
            Condition1D_2D_3COrdered(n,:) = Condition1D_2DOrdered(B,:);
        end
    end
    
    if cell2mat(ExpConditions(1,2))>=4&&cell2mat(ExpConditions(2,2))>=4&&cell2mat(ExpConditions(3,2))>=4
        
        Condition1D_2D_3D= find(strcmp(ExpConditions(3,6), Condition1D_2DOrdered(:,4)));
        
        for n = 1:length(Condition1D_2D_3D);
            B = Condition1D_2D_3D(n,1);
            Condition1D_2D_3DOrdered(n,:) = Condition1D_2DOrdered(B,:);
        end
    end
end

if row==1
    AllDataOrdered = vertcat(Condition1AOrdered,Condition1BOrdered,Condition1COrdered,Condition1DOrdered);
elseif row==2
    AllDataOrdered = vertcat(Condition1A_2AOrdered,Condition1B_2AOrdered,Condition1C_2AOrdered,Condition1D_2AOrdered,...
        Condition1A_2BOrdered,Condition1B_2BOrdered,Condition1C_2BOrdered,Condition1D_2BOrdered,...
        Condition1A_2COrdered,Condition1B_2COrdered,Condition1C_2COrdered,Condition1D_2COrdered,...
        Condition1A_2DOrdered,Condition1B_2DOrdered,Condition1C_2DOrdered,Condition1D_2DOrdered);
elseif row==3
    AllDataOrdered = vertcat(Condition1A_2A_3AOrdered,Condition1B_2A_3AOrdered,Condition1C_2A_3AOrdered,Condition1D_2A_3AOrdered,Condition1A_2B_3AOrdered,Condition1B_2B_3AOrdered,Condition1C_2B_3AOrdered,Condition1D_2B_3AOrdered,Condition1A_2C_3AOrdered,Condition1B_2C_3AOrdered,Condition1C_2C_3AOrdered,Condition1D_2C_3AOrdered,Condition1A_2D_3AOrdered,Condition1B_2D_3AOrdered,Condition1C_2D_3AOrdered,Condition1D_2D_3AOrdered,Condition1A_2A_3BOrdered,Condition1B_2A_3BOrdered,Condition1C_2A_3BOrdered,Condition1D_2A_3BOrdered,Condition1A_2B_3BOrdered,Condition1B_2B_3BOrdered,Condition1C_2B_3BOrdered,Condition1D_2B_3BOrdered,Condition1A_2C_3BOrdered,Condition1B_2C_3BOrdered,Condition1C_2C_3BOrdered,Condition1D_2C_3BOrdered,Condition1A_2D_3BOrdered,Condition1B_2D_3BOrdered,Condition1C_2D_3BOrdered,Condition1D_2D_3BOrdered,Condition1A_2A_3COrdered,Condition1B_2A_3COrdered,Condition1C_2A_3COrdered,Condition1D_2A_3COrdered,Condition1A_2B_3COrdered,Condition1B_2B_3COrdered,Condition1C_2B_3COrdered,Condition1D_2B_3COrdered,Condition1A_2C_3COrdered,Condition1B_2C_3COrdered,Condition1C_2C_3COrdered,Condition1D_2C_3COrdered,Condition1A_2D_3COrdered,Condition1B_2D_3COrdered,Condition1C_2D_3COrdered,Condition1D_2D_3COrdered,Condition1A_2A_3DOrdered,Condition1B_2A_3DOrdered,Condition1C_2A_3DOrdered,Condition1D_2A_3DOrdered,Condition1A_2B_3DOrdered,Condition1B_2B_3DOrdered,Condition1C_2B_3DOrdered,Condition1D_2B_3DOrdered,Condition1A_2C_3DOrdered,Condition1B_2C_3DOrdered,Condition1C_2C_3DOrdered,Condition1D_2C_3DOrdered,Condition1A_2D_3DOrdered,Condition1B_2D_3DOrdered,Condition1C_2D_3DOrdered,Condition1D_2D_3DOrdered);
    
end

Filename = sprintf(char(strcat(ExpName,{' '},ParticipantID,{' '},'Eye Data.xlsx')));
xlswrite(Filename,AllDataOrdered,'Trial Data','A2');

NumConditions = prod(cell2mat(ExpConditions(:,2)));
TrialsPerCondition = NumTrials/NumConditions;
[row,col] = size(ExpConditions);
for j = 1:NumConditions
    MeanHeadings((j*3)-2,1) =  {ParticipantID};
    MeanHeadings((j*3)-2,row+2) = {'Mean'};
    MeanHeadings((j*3)-1,row+2) = {'SD'};
end

[a,b,c] = xlsread(char(strcat(ExpName,{' '},ParticipantID,{' '},'Eye Data.xlsx')));
b = b(2:end,:);

for j = 1:NumConditions
    k = (TrialsPerCondition*j)-(TrialsPerCondition-1);
    MeanHeadings((j*3)-2,2:row+1) = b(k,2:row+1);
end

xlswrite(Filename,MeanHeadings,'Mean Data','A2');

b = (length(a)-(length(HeadingExport)-length(Exp)))+1;
c = length(Exp)+1; %#ok<*NASGU>
a = a(:,b:end);

TrialsPerCondition = NumTrials/NumConditions;

MeanCondition = [];
SDCondition = [];

for k = 1:NumConditions
    j = (TrialsPerCondition*k)-(TrialsPerCondition-1);
    i = TrialsPerCondition*k;
    u = genvarname('MeanCondition', who);
    v = genvarname('SDCondition', who);
    evalc([u ' = nanmean(a(j:i,:))']);
    evalc([v ' = nanstd(a(j:i,:))']);
end

for k = NumConditions+1:16;
    u = genvarname('MeanCondition', who);
    v = genvarname('SDCondition', who);
    evalc([u ' = nan(1,length(MeanCondition1))']);
    evalc([v ' = nan(1,length(MeanCondition1))']);
end

AllMeansSDs = [];
Blank = nan(1,length(MeanCondition1));

AllMeansSDs = vertcat(AllMeansSDs,MeanCondition1,SDCondition1,Blank,MeanCondition2,SDCondition2,Blank,...
    MeanCondition3,SDCondition3,Blank,MeanCondition4,SDCondition4,Blank,MeanCondition5,SDCondition5,Blank,...
    MeanCondition6,SDCondition6,Blank,MeanCondition7,SDCondition7,Blank,MeanCondition8,SDCondition8,Blank,...
    MeanCondition9,SDCondition9,Blank,MeanCondition10,SDCondition10,Blank,MeanCondition11,SDCondition11,Blank,...
    MeanCondition12,SDCondition12,Blank,MeanCondition13,SDCondition13,Blank,MeanCondition14,SDCondition14,Blank,...
    MeanCondition15,SDCondition15,Blank,MeanCondition16,SDCondition16,Blank);

Filename = sprintf(char(strcat(ExpName,{' '},ParticipantID,{' '},'Eye Data.xlsx')));
if row==1
    Cell = 'D2';
elseif row==2
    Cell = 'E2';
elseif row==3
    Cell = 'F2';
end

xlswrite(Filename,AllMeansSDs,'Mean Data',Cell);

[a,b,c] = xlsread(char(strcat(ExpName,{' '},ParticipantID,{' '},'Eye Data.xlsx')));
b = b(2:end,:);
c = c(2:end,(length(Exp)+1):length(c));
clearvars Conditions
Trials = [];

for j = 1:NumConditions
    k = (TrialsPerCondition*j)-(TrialsPerCondition-1);
    Conditions(j,:) = b(k,2:row+1);
    u = genvarname('Trials', who);
    evalc([u ' = c(k:k+(TrialsPerCondition-1),:)']);
end

for k = NumConditions+1:16;
    w = genvarname('Trials', who);
    evalc([w ' = nan(1,length(MeanCondition1))']);
end

Condition = [];

for k = 1:NumConditions;
    u = genvarname('Condition', who);
    evalc([u ' = Conditions(k,:)']);
end

clearvars -except AllDataOrdered Condition1 Condition2 Condition3 Condition4 Condition5 Condition6...
    Condition7 Condition8 Condition9 Condition10 Condition11 Condition12 Condition13...
    Condition14 Condition15 Condition16 MeanCondition1 SDCondition1 MeanCondition2 SDCondition2...
    MeanCondition3 SDCondition3 MeanCondition4 SDCondition4 MeanCondition5 SDCondition5 ...
    MeanCondition6 SDCondition6 MeanCondition7 SDCondition7 MeanCondition8 SDCondition8 ...
    MeanCondition9 SDCondition9 MeanCondition10 SDCondition10 MeanCondition11 SDCondition11 ...
    MeanCondition12 SDCondition12 MeanCondition13 SDCondition13 MeanCondition14 SDCondition14 ...
    MeanCondition15 SDCondition15 MeanCondition16 SDCondition16 ParticipantID ExpName MainFolder...
    Trials1 Trials2 Trials3 Trials4 Trials5 Trials6 Trials7 Trials8 Trials9 Trials10...
    Trials11 Trials12 Trials13 Trials14 Trials15 Trials16

load('ParticipantID')
load('ExpInfo')
TF = strcmp(ExpConditions(1,1),'Direction');

if TF==1
    Exp = {'Participant'};
    load('ExpInfo');
    [j,k] = size(ExpConditions);
    for c = 1:j
        Exp = horzcat(Exp,ExpConditions(c,1)); %#ok<*AGROW>
    end
    Exp = horzcat(Exp,'Trial Number');
    
    [a,b,c] = xlsread(char(strcat(ExpName,{' '},ParticipantID,{' '},'Eye Data.xlsx'))); %#ok<*ASGLU>
    
    [row,col] = size(ExpConditions);
    
    Condition1AOrdered = {};Condition1BOrdered = {};Condition1COrdered = {};Condition1DOrdered = {};
    
    Condition1A_2AOrdered = {};Condition1B_2AOrdered = {};Condition1C_2AOrdered = {};Condition1D_2AOrdered = {};
    Condition1A_2BOrdered = {};Condition1B_2BOrdered = {};Condition1C_2BOrdered = {};Condition1D_2BOrdered = {};
    Condition1A_2COrdered = {};Condition1B_2COrdered = {};Condition1C_2COrdered = {};Condition1D_2COrdered = {};
    Condition1A_2DOrdered = {};Condition1B_2DOrdered = {};Condition1C_2DOrdered = {};Condition1D_2DOrdered = {};
    
    if cell2mat(ExpConditions(2,2))>=2
        Condition1A = find(strcmp(ExpConditions(2,3), c(:,3)));
        Condition1B = find(strcmp(ExpConditions(2,4), c(:,3)));
        for n = 1:length(Condition1A);
            B = Condition1A(n,1);
            Condition1AOrdered(n,:) = c(B,:);
        end
        
        for n = 1:length(Condition1B);
            B = Condition1B(n,1);
            Condition1BOrdered(n,:) = c(B,:);
        end
    end
    if cell2mat(ExpConditions(2,2))>=3
        Condition1C = find(strcmp(ExpConditions(2,5), c(:,3)));
        for n = 1:length(Condition1C);
            B = Condition1C(n,1);
            Condition1COrdered(n,:) = c(B,:);
        end
    end
    
    if cell2mat(ExpConditions(2,2))==4
        Condition1D = find(strcmp(ExpConditions(2,6), c(:,3)));
        for n = 1:length(Condition1D);
            B = Condition1D(n,1);
            Condition1DOrdered(n,:) = c(B,:);
        end
    end
    
    if row>2
        if cell2mat(ExpConditions(2,2))>=2&&cell2mat(ExpConditions(3,2))>=2
            Condition1A_2A= find(strcmp(ExpConditions(3,3), Condition1AOrdered(:,4)));
            Condition1A_2B = find(strcmp(ExpConditions(3,4), Condition1AOrdered(:,4)));
            Condition1B_2A= find(strcmp(ExpConditions(3,3), Condition1BOrdered(:,4)));
            Condition1B_2B = find(strcmp(ExpConditions(3,4), Condition1BOrdered(:,4)));
            for n = 1:length(Condition1A_2A);
                B = Condition1A_2A(n,1);
                Condition1A_2AOrdered(n,:) = Condition1AOrdered(B,:);
            end
            for n = 1:length(Condition1A_2B);
                B = Condition1A_2B(n,1);
                Condition1A_2BOrdered(n,:) = Condition1AOrdered(B,:);
            end
            for n = 1:length(Condition1B_2A);
                B = Condition1B_2A(n,1);
                Condition1B_2AOrdered(n,:) = Condition1BOrdered(B,:);
            end
            for n = 1:length(Condition1B_2B);
                B = Condition1B_2B(n,1);
                Condition1B_2BOrdered(n,:) = Condition1BOrdered(B,:);
            end
        end
        if cell2mat(ExpConditions(2,2))>=2&&cell2mat(ExpConditions(3,2))>=3
            Condition1A_2C = find(strcmp(ExpConditions(3,5), Condition1AOrdered(:,4)));
            Condition1B_2C = find(strcmp(ExpConditions(3,5), Condition1BOrdered(:,4)));
            for n = 1:length(Condition1A_2C);
                B = Condition1A_2C(n,1);
                Condition1A_2COrdered(n,:) = Condition1AOrdered(B,:);
            end
            for n = 1:length(Condition1B_2C);
                B = Condition1B_2C(n,1);
                Condition1B_2COrdered(n,:) = Condition1BOrdered(B,:);
            end
        end
        if cell2mat(ExpConditions(2,2))>=2&&cell2mat(ExpConditions(3,2))>=4
            Condition1A_2D = find(strcmp(ExpConditions(3,6), Condition1AOrdered(:,4)));
            Condition1B_2D = find(strcmp(ExpConditions(3,6), Condition1BOrdered(:,4)));
            for n = 1:length(Condition1A_2D);
                B = Condition1A_2D(n,1);
                Condition1A_2DOrdered(n,:) = Condition1AOrdered(B,:);
            end
            for n = 1:length(Condition1B_2D);
                B = Condition1B_2D(n,1);
                Condition1B_2DOrdered(n,:) = Condition1BOrdered(B,:);
            end
        end
        if cell2mat(ExpConditions(2,2))>=3&&cell2mat(ExpConditions(3,2))>=2
            Condition1C_2A= find(strcmp(ExpConditions(3,3), Condition1COrdered(:,3)));
            Condition1C_2B = find(strcmp(ExpConditions(3,4), Condition1COrdered(:,3)));
            for n = 1:length(Condition1C_2A);
                B = Condition1C_2A(n,1);
                Condition1C_2AOrdered(n,:) = Condition1COrdered(B,:);
            end
            for n = 1:length(Condition1C_2B);
                B = Condition1C_2B(n,1);
                Condition1C_2BOrdered(n,:) = Condition1COrdered(B,:);
            end
        end
        if cell2mat(ExpConditions(2,2))>=3&&cell2mat(ExpConditions(3,2))>=3
            Condition1C_2C = find(strcmp(ExpConditions(3,6), Condition1COrdered(:,4)));
            for n = 1:length(Condition1C_2C);
                B = Condition1C_2C(n,1);
                Condition1C_2COrdered(n,:) = Condition1COrdered(B,:);
            end
        end
        if cell2mat(ExpConditions(2,2))==3&&cell2mat(ExpConditions(3,2))==4
            Condition1C_2D = find(strcmp(ExpConditions(3,6), Condition1COrdered(:,4)));
            for n = 1:length(Condition1C_2D);
                B = Condition1C_2D(n,1);
                Condition1C_2DOrdered(n,:) = Condition1COrdered(B,:);
            end
        end
        if cell2mat(ExpConditions(2,2))==4&&cell2mat(ExpConditions(3,2))>=2
            Condition1D_2A= find(strcmp(ExpConditions(3,3), Condition1DOrdered(:,4)));
            Condition1D_2B = find(strcmp(ExpConditions(2,4), Condition1DOrdered(:,4)));
            for n = 1:length(Condition1D_2A);
                B = Condition1D_2A(n,1);
                Condition1D_2AOrdered(n,:) = Condition1DOrdered(B,:);
            end
            for n = 1:length(Condition1D_2B);
                B = Condition1D_2B(n,1);
                Condition1D_2BOrdered(n,:) = Condition1DOrdered(B,:);
            end
        end
        if cell2mat(ExpConditions(2,2))==4&&cell2mat(ExpConditions(3,2))>=3
            Condition1D_2C = find(strcmp(ExpConditions(3,5), Condition1DOrdered(:,4)));
            for n = 1:length(Condition1D_2C);
                B = Condition1D_2C(n,1);
                Condition1D_2COrdered(n,:) = Condition1DOrdered(B,:);
            end
        end
        if cell2mat(ExpConditions(2,2))==4&&cell2mat(ExpConditions(3,2))==4
            Condition1D_2D = find(strcmp(ExpConditions(3,6), Condition1DOrdered(:,4)));
            for n = 1:length(Condition1D_2D);
                B = Condition1D_2D(n,1);
                Condition1D_2DOrdered(n,:) = Condition1DOrdered(B,:);
            end
        end
    end
    if row==2
        AllDataOrdered = vertcat(Condition1AOrdered,Condition1BOrdered,Condition1COrdered,Condition1DOrdered);
    elseif row==3
        AllDataOrdered = vertcat(Condition1A_2AOrdered,Condition1B_2AOrdered,Condition1C_2AOrdered,Condition1D_2AOrdered,...
            Condition1A_2BOrdered,Condition1B_2BOrdered,Condition1C_2BOrdered,Condition1D_2BOrdered,...
            Condition1A_2COrdered,Condition1B_2COrdered,Condition1C_2COrdered,Condition1D_2COrdered,...
            Condition1A_2DOrdered,Condition1B_2DOrdered,Condition1C_2DOrdered,Condition1D_2DOrdered);
    end
    
    Filename = sprintf(char(strcat(ExpName,{' '},ParticipantID,{' '},'Eye Data.xlsx')));
    
    NumConditions = (prod(cell2mat(ExpConditions(:,2))))/2;
    TrialsPerCondition = (NumTrials/NumConditions);
    [row,col] = size(ExpConditions);
    for j = 1:NumConditions
        MeanHeadings((j*3)-2,1) =  {ParticipantID};
        MeanHeadings((j*3)-2,row+2) = {'Mean'};
        MeanHeadings((j*3)-1,row+2) = {'SD'};
    end
    
    [a,b,c] = xlsread(char(strcat(ExpName,{' '},ParticipantID,{' '},'Eye Data.xlsx')));
    b = b(2:end,:);
    HeadingExport = c(1,:);
    
    for j = 1:NumConditions
        k = (TrialsPerCondition*j)-(TrialsPerCondition-1);
        MeanHeadings((j*3)-2,3:row+1) = b(k,3:row+1);
    end
    
    xlswrite(Filename,MeanHeadings,'Collapsed Mean Data','A2');
    
    b = (length(a)-(length(HeadingExport)-length(Exp)))+1;
    c = length(Exp)+1; %#ok<*NASGU>
    a = a(:,b:end);
    
    CollapsedMeanCondition = [];
    CollapsedSDCondition = [];
    
    for k = 1:NumConditions
        j = (TrialsPerCondition*k)-(TrialsPerCondition-1);
        i = TrialsPerCondition*k;
        u = genvarname('CollapsedMeanCondition', who);
        v = genvarname('CollapsedSDCondition', who);
        evalc([u ' = nanmean(a(j:i,:))']);
        evalc([v ' = nanstd(a(j:i,:))']);
    end
    
    for k = NumConditions+1:8;
        u = genvarname('CollapsedMeanCondition', who);
        v = genvarname('CollapsedSDCondition', who);
        evalc([u ' = nan(1,length(CollapsedMeanCondition1))']);
        evalc([v ' = nan(1,length(CollapsedMeanCondition1))']);
    end
    
    AllCollapsedMeansSDs = [];
    Blank = nan(1,length(CollapsedMeanCondition1));
    
    AllCollapsedMeansSDs = vertcat(AllCollapsedMeansSDs,CollapsedMeanCondition1,CollapsedSDCondition1,Blank,CollapsedMeanCondition2,CollapsedSDCondition2,Blank,CollapsedMeanCondition3,CollapsedSDCondition3,Blank,CollapsedMeanCondition4,CollapsedSDCondition4,Blank,CollapsedMeanCondition5,CollapsedSDCondition5,Blank,CollapsedMeanCondition6,CollapsedSDCondition6,Blank,CollapsedMeanCondition7,CollapsedSDCondition7,Blank,CollapsedMeanCondition8,CollapsedSDCondition8,Blank);
    
    if row==2
        Cell = 'E2';
    elseif row==3
        Cell = 'F2';
    end
    
    xlswrite(Filename,AllCollapsedMeansSDs,'Collapsed Mean Data',Cell);
    
    [a,b,c] = xlsread(char(strcat(ExpName,{' '},ParticipantID,{' '},'Eye Data.xlsx')));
    b = b(2:end,:);
    c = c(2:end,(length(Exp)+1):length(c));
    clearvars Conditions
    CollapsedTrials = [];
    
    for j = 1:NumConditions
        k = (TrialsPerCondition*j)-(TrialsPerCondition-1);
        CollapsedConditions(j,:) = b(k,2:row+1);
        u = genvarname('CollapsedTrials', who);
        evalc([u ' = c(k:k+(TrialsPerCondition-1),:)']);
    end
    
    for k = NumConditions+1:8;
        w = genvarname('CollapsedTrials', who);
        evalc([w ' = nan(1,length(CollapsedMeanCondition1))']);
    end
    
    CollapsedCondition = [];
    
    for k = 1:NumConditions;
        u = genvarname('CollapsedCondition', who);
        evalc([u ' = CollapsedConditions(k,2:end)']);
    end
    
    clearvars -except AllDataOrdered Condition1 Condition2 Condition3 Condition4 Condition5 Condition6...
        Condition7 Condition8 Condition9 Condition10 Condition11 Condition12 Condition13...
        Condition14 Condition15 Condition16 MeanCondition1 SDCondition1 MeanCondition2 SDCondition2...
        MeanCondition3 SDCondition3 MeanCondition4 SDCondition4 MeanCondition5 SDCondition5 ...
        MeanCondition6 SDCondition6 MeanCondition7 SDCondition7 MeanCondition8 SDCondition8 ...
        MeanCondition9 SDCondition9 MeanCondition10 SDCondition10 MeanCondition11 SDCondition11 ...
        MeanCondition12 SDCondition12 MeanCondition13 SDCondition13 MeanCondition14 SDCondition14 ...
        MeanCondition15 SDCondition15 MeanCondition16 SDCondition16 ParticipantID ExpName MainFolder...
        Trials1 Trials2 Trials3 Trials4 Trials5 Trials6 Trials7 Trials8 Trials9 Trials10...
        Trials11 Trials12 Trials13 Trials14 Trials15 Trials16 CollapsedCondition1 CollapsedCondition2...
        CollapsedCondition3 CollapsedCondition4 CollapsedCondition5 CollapsedCondition6...
        CollapsedCondition7 CollapsedCondition8 AllCollapsedMeansSDs CollapsedMeanCondition1....
        CollapsedSDCondition1 CollapsedMeanCondition2 CollapsedSDCondition2 CollapsedMeanCondition3...
        CollapsedSDCondition3 CollapsedMeanCondition4 CollapsedSDCondition4 CollapsedMeanCondition5...
        CollapsedSDCondition5 CollapsedMeanCondition6 CollapsedSDCondition6 CollapsedMeanCondition7...
        CollapsedSDCondition7 CollapsedMeanCondition8 CollapsedSDCondition8 CollapsedTrials1....
        CollapsedTrials2 CollapsedTrials3 CollapsedTrials4 CollapsedTrials5 CollapsedTrials6....
        CollapsedTrials7 CollapsedTrials8
    
end

save(char(strcat(ExpName,{' '},ParticipantID,{' '},'Eye Data.mat')));
Folder = pwd;
Name = strsplit(Folder,'\');
subject = char(Name(1,end-2));
Destination = '';
for j = 1:length(Name)-2
    Destination = char(strcat(Destination,Name(1,j),'\'));
end
movefile(char(strcat(ExpName,{' '},ParticipantID,{' '},'Eye Data.mat')),Destination);

disp('Export Eye Data script complete');

Question = input('Would you like to continue analysing?\n(0)No\n(1)Yes\n');

if Question==1
    clr
    Turning_Analysis
else
    clr
end