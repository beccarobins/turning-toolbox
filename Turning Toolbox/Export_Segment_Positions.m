%Finds the positions of gaze, head, thorax and pelvis at the beginning and
%end of all steps taken throughout the turn

load('ParticipantID');
load('ExpInfo');

NumConditions = prod(cell2mat(ExpConditions(:,2)));
TrialsPerCondition = NumTrials/NumConditions;
[row,col] = size(ExpConditions);

[a,b,c] = xlsread(char(strcat(ExpName,{' '},ParticipantID,{' '},'Stepping Data.xlsx')));
b = b(2:end,:);

for j = 1:NumConditions
    k = (TrialsPerCondition*j)-(TrialsPerCondition-1);
    Conditions(j,:) = b(k,2:row+1); %#ok<*SAGROW>
end

Condition = [];
Data = [];

for k = 1:NumConditions;
    u = genvarname('Condition', who);
    v = genvarname('Data', who);
    evalc([u ' = Conditions(k,:)']);
    evalc([v ' = []']);
end

for k = NumConditions+1:16;
    u = genvarname('Condition', who);
    v = genvarname('Data', who);
    evalc([u ' = []']);
    evalc([v ' = []']);
end

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
        
        LeftSteps = horzcat(LeftFoot.Steps.Onsets_sec,...
            (Head.Yaw.Displacement(LeftFoot.Steps.Onsets)+EOG.Subsampled.Displacement.Filt30(LeftFoot.Steps.Onsets)),...
            Head.Yaw.Displacement(LeftFoot.Steps.Onsets),Thorax.Yaw.Displacement(LeftFoot.Steps.Onsets),...
            Pelvis.Yaw.Displacement(LeftFoot.Steps.Onsets));
        LeftSteps = horzcat(LeftSteps,LeftFoot.Steps.Ends_sec,...
            (Head.Yaw.Displacement(LeftFoot.Steps.Ends)+EOG.Subsampled.Displacement.Filt30(LeftFoot.Steps.Ends)),...
            Head.Yaw.Displacement(LeftFoot.Steps.Ends),Thorax.Yaw.Displacement(LeftFoot.Steps.Ends),...
            Pelvis.Yaw.Displacement(LeftFoot.Steps.Ends)); %#ok<*AGROW>
        
        RightSteps = horzcat(RightFoot.Steps.Onsets_sec,...
            (Head.Yaw.Displacement(RightFoot.Steps.Onsets)+EOG.Subsampled.Displacement.Filt30(RightFoot.Steps.Onsets)),...
            Head.Yaw.Displacement(RightFoot.Steps.Onsets),Thorax.Yaw.Displacement(RightFoot.Steps.Onsets),...
            Pelvis.Yaw.Displacement(RightFoot.Steps.Onsets));
        RightSteps = horzcat(RightSteps,RightFoot.Steps.Ends_sec,...
            (Head.Yaw.Displacement(RightFoot.Steps.Ends)+EOG.Subsampled.Displacement.Filt30(RightFoot.Steps.Ends)),...
            Head.Yaw.Displacement(RightFoot.Steps.Ends),Thorax.Yaw.Displacement(RightFoot.Steps.Ends),...
            Pelvis.Yaw.Displacement(RightFoot.Steps.Ends));
        
        StackedSteps = vertcat(LeftSteps,RightSteps);
        Data = sortrows(StackedSteps,1);
        
        for j = 1:NumConditions
            TF(j,:) = strcmp(TrialCondition,Conditions(j,:));
            Sum(j,:) = sum(TF(j,:));
        end
        
        [Max,MaxRow] = max(Sum);
        if MaxRow==1
            Data1 = vertcat(Data1,Data);
        elseif MaxRow==2
            Data2 = vertcat(Data2,Data);
        elseif MaxRow==3
            Data3 = vertcat(Data3,Data);
        elseif MaxRow==4
            Data4 = vertcat(Data4,Data);
        elseif MaxRow==5
            Data5 = vertcat(Data5,Data);
        elseif MaxRow==6
            Data6 = vertcat(Data6,Data);
        elseif MaxRow==7
            Data7 = vertcat(Data7,Data);
        elseif MaxRow==8
            Data8 = vertcat(Data8,Data);
        elseif MaxRow==9
            Data9 = vertcat(Data9,Data);
        elseif MaxRow==10
            Data10 = vertcat(Data10,Data);
        elseif MaxRow==11
            Data11 = vertcat(Data11,Data);
        elseif MaxRow==12
            Data12 = vertcat(Data12,Data);
        elseif MaxRow==13
            Data13 = vertcat(Data13,Data);
        elseif MaxRow==14
            Data14 = vertcat(Data14,Data);
        elseif MaxRow==15
            Data15 = vertcat(Data15,Data);
        elseif MaxRow==16
            Data16 = vertcat(Data16,Data);
        end
        
    end
    clearvars -except ExpName ParticipantID NumConditions Conditions Data1 Condition1 Data2 Condition2 Data3 Condition3 Data4 Condition4...
        Data5 Condition5 Data6 Condition6 Data7 Condition7 Data8 Condition8...
        Data9 Condition9 Data10 Condition10 Data11 Condition11 Data12 Condition12...
        Data13 Condition13 Data14 Condition14 Data15 Condition15 Data16 Condition16 MainFolder
end

save([char(strcat(ExpName,{' '},ParticipantID,{' '},'Segment Positions'))]); %#ok<*NBRAK>
Folder = pwd;
Name = strsplit(Folder,'\');
subject = char(Name(1,end-2));
Destination = '';
for j = 1:length(Name)-2
    Destination = char(strcat(Destination,Name(1,j),'\'));
end
movefile(char(strcat(ExpName,{' '},ParticipantID,{' '},'Segment Positions.mat')),Destination);

disp('Export Segment Positions script complete');

Question = input('Would you like to continue analysing?\n(0)No\n(1)Yes\n');

if Question==1
    clr
    Turning_Analysis
else
    clr
end