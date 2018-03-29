load('ExpInfo');

HeadingExport = horzcat({'Step Onset Latency'},{'Gaze at Step Onset'},{'Head at Step Onset'},{'Thorax at Step Onset'},{'Pelvis at Step Onset'},{'Step Placement Time'},{'Gaze  at Step End'},{'Head at Step End'},{'Thorax at Step End'},{'Pelvis at Step End'});
Filename = sprintf(char(strcat(ExpName,{' '},'Segment Positions.xlsx')));

NumConditions = prod(cell2mat(ExpConditions(:,2)));
TrialsPerCondition = NumTrials/NumConditions;

load('ParticipantList');
[NumParticipants,c] = size(ParticipantList);

AllDataCondition = [];

for j = 1:16;
    u = genvarname('AllDataCondition', who);
    evalc([u ' = []']);
end

for k = 1:NumParticipants;
    ParticipantID = char(ParticipantList(k,1));
    load(char(strcat(ExpName,{' '},ParticipantID,{' '},'Segment Positions.mat')));
    AllDataCondition1 = vertcat(AllDataCondition1,Data1); %#ok<*AGROW>
    AllDataCondition2 = vertcat(AllDataCondition2,Data2);
    AllDataCondition3 = vertcat(AllDataCondition3,Data3);
    AllDataCondition4 = vertcat(AllDataCondition4,Data4);
    AllDataCondition5 = vertcat(AllDataCondition5,Data5);
    AllDataCondition6 = vertcat(AllDataCondition6,Data6);
    AllDataCondition7 = vertcat(AllDataCondition7,Data7);
    AllDataCondition8 = vertcat(AllDataCondition8,Data8);
    AllDataCondition9 = vertcat(AllDataCondition9,Data9);
    AllDataCondition10 = vertcat(AllDataCondition10,Data10);
    AllDataCondition11 = vertcat(AllDataCondition11,Data11);
    AllDataCondition12 = vertcat(AllDataCondition12,Data12);
    AllDataCondition13 = vertcat(AllDataCondition13,Data13);
    AllDataCondition14 = vertcat(AllDataCondition14,Data14);
    AllDataCondition15 = vertcat(AllDataCondition15,Data15);
    AllDataCondition16 = vertcat(AllDataCondition16,Data16);
end

warning('off','all');

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

for j = 1:NumConditions
    ConditionHeading = char(eval(strcat('Condition',num2str(j))));
    Data = eval(strcat('AllDataCondition',num2str(j)));
    xlswrite(Filename,HeadingExport,ConditionHeading,'A1');
    xlswrite(Filename,Data,ConditionHeading,'A2');
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

load handel
sound(y,Fs);
dips('Compile Segment Positions Script Complete');
clear