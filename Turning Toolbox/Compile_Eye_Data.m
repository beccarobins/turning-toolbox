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

load('ExpInfo');

Filename = sprintf(char(strcat(ExpName,{' '},'Eye Data.xlsx')));
Filename2 = sprintf(char(strcat(ExpName,{' '},'Eye Data - SPSS.xlsx')));

NumConditions = prod(cell2mat(ExpConditions(:,2)));
TrialsPerCondition = NumTrials/NumConditions;

warning('off','all');
load('ParticipantList');
ParticipantID = char(ParticipantList(1,1));
load(char(strcat(ExpName,{' '},ParticipantID,{' '},'Eye Data.mat')));
[row,col] = size(Condition1); %#ok<*ASGLU>
for i = 1:NumConditions
    if col==1
    elseif col==2
        Condition = eval(strcat('Condition',num2str(i)));
        Condition = strcat(Condition(1,1),{' '},Condition(1,2)); %#ok<*NASGU>
        u = strcat('Condition',num2str(i));
        evalc([u ' = Condition']);
    elseif col==3
        Condition = eval(strcat('Condition',num2str(i)));
        Condition = strcat(Condition(1,1),{' '},Condition(1,2),{' '},Condition(1,3));
        u = strcat('Condition',num2str(i));
        evalc([u ' = Condition']);
    end
end

for j = 1:NumConditions
    Condition = eval(strcat('Condition',num2str(j)));
    ConditionTrials = char(strcat(Condition,{' - '},'Trials'));
    ConditionMeans = char(strcat(Condition,{' - '},'Means'));
    xlswrite(Filename,HeadingExport,'All Trials','A1');
    xlswrite(Filename,HeadingExport,ConditionTrials,'A1');
    xlswrite(Filename,HeadingExport,ConditionMeans,'A1');
    xlswrite(Filename2,HeadingExport,ConditionMeans,'A1');
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

excelFilePath = pwd; % Current working directory.
sheetName = 'Sheet'; % EN: Sheet, DE: Tabelle, etc. (Lang. dependent)
% Open Excel file.
objExcel = actxserver('Excel.Application');
objExcel.Workbooks.Open(fullfile(excelFilePath, Filename2)); % Full path is necessary!
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

load('ParticipantList');
[NumParticipants,c] = size(ParticipantList);

AllData = [];
AllMeansCondition = [];
AllMeansSDsCondition = [];
AllTrialsCondition = [];

for j = 1:16;
    u = genvarname('AllMeansCondition', who);
    v = genvarname('AllMeansSDsCondition', who);
    w = genvarname('AllTrialsCondition', who);
    evalc([u ' = []']);
    evalc([v ' = []']);
    evalc([w ' = []']);
end

for k = 1:NumParticipants;
    ParticipantID = char(ParticipantList(k,1));
    load(char(strcat(ExpName,{' '},ParticipantID,{' '},'Eye Data.mat')));
    AllData = vertcat(AllData,AllDataOrdered); %#ok<*AGROW>
    AllMeansCondition1 = vertcat(AllMeansCondition1,MeanCondition1);
    AllMeansCondition2 = vertcat(AllMeansCondition2,MeanCondition2);
    AllMeansCondition3 = vertcat(AllMeansCondition3,MeanCondition3);
    AllMeansCondition4 = vertcat(AllMeansCondition4,MeanCondition4);
    AllMeansCondition5 = vertcat(AllMeansCondition5,MeanCondition5);
    AllMeansCondition6 = vertcat(AllMeansCondition6,MeanCondition6);
    AllMeansCondition7 = vertcat(AllMeansCondition7,MeanCondition7);
    AllMeansCondition8 = vertcat(AllMeansCondition8,MeanCondition8);
    AllMeansCondition9 = vertcat(AllMeansCondition9,MeanCondition9);
    AllMeansCondition10 = vertcat(AllMeansCondition10,MeanCondition10);
    AllMeansCondition11 = vertcat(AllMeansCondition11,MeanCondition11);
    AllMeansCondition12 = vertcat(AllMeansCondition12,MeanCondition12);
    AllMeansCondition13 = vertcat(AllMeansCondition13,MeanCondition13);
    AllMeansCondition14 = vertcat(AllMeansCondition14,MeanCondition14);
    AllMeansCondition15 = vertcat(AllMeansCondition15,MeanCondition15);
    AllMeansCondition16 = vertcat(AllMeansCondition16,MeanCondition16);
    AllMeansSDsCondition1 = vertcat(AllMeansSDsCondition1,MeanCondition1,SDCondition1);
    AllMeansSDsCondition2 = vertcat(AllMeansSDsCondition2,MeanCondition2,SDCondition2);
    AllMeansSDsCondition3 = vertcat(AllMeansSDsCondition3,MeanCondition3,SDCondition3);
    AllMeansSDsCondition4 = vertcat(AllMeansSDsCondition4,MeanCondition4,SDCondition4);
    AllMeansSDsCondition5 = vertcat(AllMeansSDsCondition5,MeanCondition5,SDCondition5);
    AllMeansSDsCondition6 = vertcat(AllMeansSDsCondition6,MeanCondition6,SDCondition6);
    AllMeansSDsCondition7 = vertcat(AllMeansSDsCondition7,MeanCondition7,SDCondition7);
    AllMeansSDsCondition8 = vertcat(AllMeansSDsCondition8,MeanCondition8,SDCondition8);
    AllMeansSDsCondition9 = vertcat(AllMeansSDsCondition9,MeanCondition9,SDCondition9);
    AllMeansSDsCondition10 = vertcat(AllMeansSDsCondition10,MeanCondition10,SDCondition10);
    AllMeansSDsCondition11 = vertcat(AllMeansSDsCondition11,MeanCondition11,SDCondition11);
    AllMeansSDsCondition12 = vertcat(AllMeansSDsCondition12,MeanCondition12,SDCondition12);
    AllMeansSDsCondition13 = vertcat(AllMeansSDsCondition13,MeanCondition13,SDCondition13);
    AllMeansSDsCondition14 = vertcat(AllMeansSDsCondition14,MeanCondition14,SDCondition14);
    AllMeansSDsCondition15 = vertcat(AllMeansSDsCondition15,MeanCondition15,SDCondition15);
    AllMeansSDsCondition16 = vertcat(AllMeansSDsCondition16,MeanCondition16,SDCondition16);
    AllTrialsCondition1 = vertcat(AllTrialsCondition1,Trials1);
    AllTrialsCondition2 = vertcat(AllTrialsCondition2,Trials2);
    AllTrialsCondition3 = vertcat(AllTrialsCondition3,Trials3);
    AllTrialsCondition4 = vertcat(AllTrialsCondition4,Trials4);
    AllTrialsCondition5 = vertcat(AllTrialsCondition5,Trials5);
    AllTrialsCondition6 = vertcat(AllTrialsCondition6,Trials6);
    AllTrialsCondition7 = vertcat(AllTrialsCondition7,Trials7);
    AllTrialsCondition8 = vertcat(AllTrialsCondition8,Trials8);
    AllTrialsCondition9 = vertcat(AllTrialsCondition9,Trials9);
    AllTrialsCondition10 = vertcat(AllTrialsCondition10,Trials10);
    AllTrialsCondition11 = vertcat(AllTrialsCondition11,Trials11);
    AllTrialsCondition12 = vertcat(AllTrialsCondition12,Trials12);
    AllTrialsCondition13 = vertcat(AllTrialsCondition13,Trials13);
    AllTrialsCondition14 = vertcat(AllTrialsCondition14,Trials14);
    AllTrialsCondition15 = vertcat(AllTrialsCondition15,Trials15);
    AllTrialsCondition16 = vertcat(AllTrialsCondition16,Trials16);
    ParticipantHeading((k*2)-1,:)= {ParticipantID}; %#ok<*SAGROW>
    ParticipantHeading2(k,:)= {ParticipantID};
    i = (TrialsPerCondition*k)-(TrialsPerCondition-1);
    ParticipantHeading3(i:i+(TrialsPerCondition-1),:) = {ParticipantID};
end

xlswrite(Filename,AllData,'All Trials','A2');

load('ParticipantList');
ParticipantID = char(ParticipantList(1,1));
load(char(strcat(ExpName,{' '},ParticipantID,{' '},'Eye Data.mat')));
[row,col] = size(Condition1);
for i = 1:NumConditions
    if col==1
    elseif col==2
        Condition = eval(strcat('Condition',num2str(i)));
        Condition = strcat(Condition(1,1),{' '},Condition(1,2));
        u = strcat('Condition',num2str(i));
        evalc([u ' = Condition']);
    elseif col==3
        Condition = eval(strcat('Condition',num2str(i)));
        Condition = strcat(Condition(1,1),{' '},Condition(1,2),{' '},Condition(1,3));
        u = strcat('Condition',num2str(i));
        evalc([u ' = Condition']);
    end
end

if col==1
    Cell = 'D2';
elseif col==2
    Cell = 'E2';
elseif col==3
    Cell = 'F2';
end

for j = 1:NumConditions
    Condition = eval(strcat('Condition',num2str(j)));
    ConditionTrials = char(strcat(Condition,{' - '},'Trials'));
    ConditionMeans = char(strcat(Condition,{' - '},'Means'));
    MeanSDData = eval(strcat('AllMeansSDsCondition',num2str(j)));
    MeanData = eval(strcat('AllMeansCondition',num2str(j)));
    TrialData = eval(strcat('AllTrialsCondition',num2str(j)));
    xlswrite(Filename,TrialData,ConditionTrials,Cell);
    xlswrite(Filename,ParticipantHeading3,ConditionTrials,'A2');
    xlswrite(Filename,MeanSDData,ConditionMeans,Cell);
    xlswrite(Filename,ParticipantHeading,ConditionMeans,'A2');
    xlswrite(Filename2,MeanData,ConditionMeans,Cell);
    xlswrite(Filename2,ParticipantHeading2,ConditionMeans,'A2');
end

    Condition = eval('Condition1');
    ConditionMeans = char(strcat(Condition,{' - '},'Means'));
    [a,b,c] = xlsread(Filename2,ConditionMeans);
    Variable = b(:,length(Exp)+1:end);
    
    for k = 1:length(Variable);
        Name = char(Variable(:,k));
        NameSize = length(Name);
        while NameSize>31
            disp(Name)
            Name = input('Variable name is too long for Excel. Make shorter name\n','s');
            NameSize = length(Name);
            Variable(:,k) = {Name};
            clc
        end
    end

for j = 1:NumConditions
    Condition = eval(strcat('Condition',num2str(j)));
    ConditionMeans = char(strcat(Condition,{' - '},'Means'));
    [a,b,c] = xlsread(Filename2,ConditionMeans);
    VariableData = a(:,length(Exp)+1:end);
    for k = 1:length(Variable);
        Sheet = char(Variable(:,k));
        Export = VariableData(:,k);
        if j==1
            Cell = 'A1';
        elseif j==2
            Cell = 'B1';
        elseif j==3
            Cell = 'C1';
        elseif j==4
            Cell = 'D1';
        elseif j==5
            Cell = 'E1';
        elseif j==6
            Cell = 'F1';
        elseif j==7
            Cell = 'G1';
        elseif j==8
            Cell = 'H1';
        elseif j==9
            Cell = 'I1';
        elseif j==10
            Cell = 'J1';
        elseif j==11
            Cell = 'K1';
        elseif j==12
            Cell = 'L1';
        elseif j==13
            Cell = 'M1';
        elseif j==14
            Cell = 'N1';
        elseif j==15
            Cell = 'O1';
        elseif j==16
            Cell = 'P1';
        end
        xlswrite(Filename2,Export,Sheet,Cell);
    end
end

clear

%Direction collapsed spreadsheet

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
    
    load('ExpInfo');
    
    Filename = sprintf(char(strcat(ExpName,{' '},'Eye Data - Direction Collapsed.xlsx')));
    Filename2 = sprintf(char(strcat(ExpName,{' '},'Eye Data - Direction Collapsed - SPSS.xlsx')));
    
    NumConditions = prod(cell2mat(ExpConditions(:,2)))/2;
    TrialsPerCondition = NumTrials/NumConditions;
    
    warning('off','all');
    load('ParticipantList');
    ParticipantID = char(ParticipantList(1,1));
    load(char(strcat(ExpName,{' '},ParticipantID,{' '},'Eye Data.mat')));
    [row,col] = size(Condition1); %#ok<*ASGLU>
    
    for i = 1:NumConditions
        if col==1
        elseif col==2
            CollapsedCondition = eval(strcat('Condition',num2str((i*2)-1)));
            CollapsedCondition = CollapsedCondition(1,2);
            u = strcat('CollapsedCondition',num2str(i));
            evalc([u ' = CollapsedCondition']);
        elseif col==3
            CollapsedCondition = eval(strcat('Condition',num2str((i*2)-1)));
            CollapsedCondition = strcat(CollapsedCondition(1,2),{' '},CollapsedCondition(1,3));
            u = strcat('CollapsedCondition',num2str(i));
            evalc([u ' = CollapsedCondition']);
        end
    end
    
    for j = 1:NumConditions
        k = j*2;
        CollapsedCondition = eval(strcat('CollapsedCondition',num2str(j)));
        CollapsedConditionTrials = char(strcat(CollapsedCondition,{' - '},'Trials'));
        CollapsedConditionMeans = char(strcat(CollapsedCondition,{' - '},'Means'));
        xlswrite(Filename,HeadingExport,'All Trials','A1');
        xlswrite(Filename,HeadingExport,CollapsedConditionTrials,'A1');
        xlswrite(Filename,HeadingExport,CollapsedConditionMeans,'A1');
        xlswrite(Filename2,HeadingExport,CollapsedConditionMeans,'A1');
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
    
    excelFilePath = pwd; % Current working directory.
    sheetName = 'Sheet'; % EN: Sheet, DE: Tabelle, etc. (Lang. dependent)
    % Open Excel file.
    objExcel = actxserver('Excel.Application');
    objExcel.Workbooks.Open(fullfile(excelFilePath, Filename2)); % Full path is necessary!
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
    
    load('ParticipantList');
    [NumParticipants,c] = size(ParticipantList);
    
    AllData = [];
    AllCollapsedMeansCondition = [];
    AllCollapsedMeansSDsCondition = [];
    AllCollapsedTrialsCondition = [];
    
    for j = 1:8;
        u = genvarname('AllCollapsedMeansCondition', who);
        v = genvarname('AllCollapsedMeansSDsCondition', who);
        w = genvarname('AllCollapsedTrialsCondition', who);
        evalc([u ' = []']);
        evalc([v ' = []']);
        evalc([w ' = []']);
    end
    
    for k = 1:NumParticipants;
        ParticipantID = char(ParticipantList(k,1));
        load(char(strcat(ExpName,{' '},ParticipantID,{' '},'Eye Data.mat')));
        AllData = vertcat(AllData,AllDataOrdered);
        AllCollapsedMeansCondition1 = vertcat(AllCollapsedMeansCondition1,CollapsedMeanCondition1);
        AllCollapsedMeansCondition2 = vertcat(AllCollapsedMeansCondition2,CollapsedMeanCondition2);
        AllCollapsedMeansCondition3 = vertcat(AllCollapsedMeansCondition3,CollapsedMeanCondition3);
        AllCollapsedMeansCondition4 = vertcat(AllCollapsedMeansCondition4,CollapsedMeanCondition4);
        AllCollapsedMeansCondition5 = vertcat(AllCollapsedMeansCondition5,CollapsedMeanCondition5);
        AllCollapsedMeansCondition6 = vertcat(AllCollapsedMeansCondition6,CollapsedMeanCondition6);
        AllCollapsedMeansCondition7 = vertcat(AllCollapsedMeansCondition7,CollapsedMeanCondition7);
        AllCollapsedMeansCondition8 = vertcat(AllCollapsedMeansCondition8,CollapsedMeanCondition8);
        AllCollapsedMeansSDsCondition1 = vertcat(AllCollapsedMeansSDsCondition1,CollapsedMeanCondition1,CollapsedSDCondition1);
        AllCollapsedMeansSDsCondition2 = vertcat(AllCollapsedMeansSDsCondition2,CollapsedMeanCondition2,CollapsedSDCondition2);
        AllCollapsedMeansSDsCondition3 = vertcat(AllCollapsedMeansSDsCondition3,CollapsedMeanCondition3,CollapsedSDCondition3);
        AllCollapsedMeansSDsCondition4 = vertcat(AllCollapsedMeansSDsCondition4,CollapsedMeanCondition4,CollapsedSDCondition4);
        AllCollapsedMeansSDsCondition5 = vertcat(AllCollapsedMeansSDsCondition5,CollapsedMeanCondition5,CollapsedSDCondition5);
        AllCollapsedMeansSDsCondition6 = vertcat(AllCollapsedMeansSDsCondition6,CollapsedMeanCondition6,CollapsedSDCondition6);
        AllCollapsedMeansSDsCondition7 = vertcat(AllCollapsedMeansSDsCondition7,CollapsedMeanCondition7,CollapsedSDCondition7);
        AllCollapsedMeansSDsCondition8 = vertcat(AllCollapsedMeansSDsCondition8,CollapsedMeanCondition8,CollapsedSDCondition8);
        AllCollapsedTrialsCondition1 = vertcat(AllCollapsedTrialsCondition1,CollapsedTrials1);
        AllCollapsedTrialsCondition2 = vertcat(AllCollapsedTrialsCondition2,CollapsedTrials2);
        AllCollapsedTrialsCondition3 = vertcat(AllCollapsedTrialsCondition3,CollapsedTrials3);
        AllCollapsedTrialsCondition4 = vertcat(AllCollapsedTrialsCondition4,CollapsedTrials4);
        AllCollapsedTrialsCondition5 = vertcat(AllCollapsedTrialsCondition5,CollapsedTrials5);
        AllCollapsedTrialsCondition6 = vertcat(AllCollapsedTrialsCondition6,CollapsedTrials6);
        AllCollapsedTrialsCondition7 = vertcat(AllCollapsedTrialsCondition7,CollapsedTrials7);
        AllCollapsedTrialsCondition8 = vertcat(AllCollapsedTrialsCondition8,CollapsedTrials8);
        ParticipantHeading((k*2)-1,:)= {ParticipantID}; %#ok<*SAGROW>
        ParticipantHeading2(k,:)= {ParticipantID};
        i = (TrialsPerCondition*k)-(TrialsPerCondition-1);
        ParticipantHeading3(i:i+(TrialsPerCondition-1),:) = {ParticipantID};
    end
    
    xlswrite(Filename,AllData,'All Trials','A2');
    
    load('ParticipantList');
    ParticipantID = char(ParticipantList(1,1));
    load(char(strcat(ExpName,{' '},ParticipantID,{' '},'Eye Data.mat')));
    [row,col] = size(Condition1); %#ok<*ASGLU>
    for i = 1:NumConditions
        if col==1
        elseif col==2
            CollapsedCondition = eval(strcat('Condition',num2str((i*2)-1)));
            CollapsedCondition = CollapsedCondition(1,2);
            u = strcat('CollapsedCondition',num2str(i));
            evalc([u ' = CollapsedCondition']);
        elseif col==3
            CollapsedCondition = eval(strcat('Condition',num2str((i*2)-1)));
            CollapsedCondition = strcat(CollapsedCondition(1,2),{' '},CollapsedCondition(1,3));
            u = strcat('CollapsedCondition',num2str(i));
            evalc([u ' = CollapsedCondition']);
        end
    end
    
    if col==2
        Cell = 'E2';
    elseif col==3
        Cell = 'F2';
    end
    
    for j = 1:NumConditions
        CollapsedCondition = eval(strcat('CollapsedCondition',num2str(j)));
        CollapsedConditionTrials = char(strcat(CollapsedCondition,{' - '},'Trials'));
        CollapsedConditionMeans = char(strcat(CollapsedCondition,{' - '},'Means'));
        CollapsedMeanSDData = eval(strcat('AllCollapsedMeansSDsCondition',num2str(j)));
        CollapsedMeanData = eval(strcat('AllCollapsedMeansCondition',num2str(j)));
        CollapsedTrialData = eval(strcat('AllCollapsedTrialsCondition',num2str(j)));
        xlswrite(Filename,CollapsedTrialData,CollapsedConditionTrials,Cell);
        xlswrite(Filename,ParticipantHeading3,CollapsedConditionTrials,'A2');
        xlswrite(Filename,CollapsedMeanSDData,CollapsedConditionMeans,Cell);
        xlswrite(Filename,ParticipantHeading,CollapsedConditionMeans,'A2');
        xlswrite(Filename2,CollapsedMeanData,CollapsedConditionMeans,Cell);
        xlswrite(Filename2,ParticipantHeading2,CollapsedConditionMeans,'A2');
    end
    
    CollapsedCondition = eval('CollapsedCondition1');
    CollapsedConditionMeans = char(strcat(CollapsedCondition,{' - '},'Means'));
    [a,b,c] = xlsread(Filename2,CollapsedConditionMeans);
    Variable = b(:,length(Exp)+1:end);
    
    for k = 1:length(Variable);
        Name = char(Variable(:,k));
        NameSize = length(Name);
        while NameSize>31
            disp(Name)
            Name = input('Variable name is too long for Excel. Make shorter name\n','s');
            NameSize = length(Name);
            Variable(:,k) = {Name};
            clc
        end
    end
    
    for j = 1:NumConditions
        CollapsedCondition = eval(strcat('CollapsedCondition',num2str(j)));
        CollapsedConditionMeans = char(strcat(CollapsedCondition,{' - '},'Means'));
        [a,b,c] = xlsread(Filename2,CollapsedConditionMeans);
        VariableData = a(:,length(Exp)+1:end);
        for k = 1:length(Variable);
            Sheet = char(Variable(:,k));
            Export = VariableData(:,k);
            if j==1
                Cell = 'A1';
            elseif j==2
                Cell = 'B1';
            elseif j==3
                Cell = 'C1';
            elseif j==4
                Cell = 'D1';
            elseif j==5
                Cell = 'E1';
            elseif j==6
                Cell = 'F1';
            elseif j==7
                Cell = 'G1';
            elseif j==8
                Cell = 'H1';
            end
            xlswrite(Filename2,Export,Sheet,Cell);
        end
    end
end

load handel
sound(y,Fs);
disp('Compile Eye Data Script Complete');
clear