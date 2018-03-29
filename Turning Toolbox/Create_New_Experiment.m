
function Create_New_Experiment
%FOR REPEATED MEASURES DESIGN
%Creates variable which has all information about experiment
%Do not use more than three main conditions/factprs in the experimental design
%For Conditions with sizes/units, name them with the units followed by the
%value, i.e. 90 degrees = Degrees90

ExpName = input('What is the experiment called?\n','s');
NumConditions = input('How many main conditions/factors in the experiment?\n');

for j = 1:NumConditions
    Question = strcat('What is factor',{' '},num2str(j),'?\n');
    Condition= input(strcat(char(Question)),'s');
    ExpConditions(j,:) = cellstr(Condition); %#ok<*AGROW,*SAGROW>
end

for j = 1:NumConditions
    Condition = char(ExpConditions(j,1));
    Question = strcat('How many conditions in',{' '},Condition,{' '},'condition?\n');
    SubConditions= input(char(Question));
    ExpConditions(j,2) = {SubConditions};
end

S = ExpConditions(:,2);
M = max(cell2mat(S));
ExpConditions(:,3:3+M) = {NaN};

TotalConditions = prod(cell2mat(ExpConditions(:,2)));

if TotalConditions>12
    S = 'There are several conditions in this experiment. Consider reducing.';
    disp(S)
    pause
end

for j = 1:NumConditions
    for k = 1:cell2mat(ExpConditions(j,2));
        Question = strcat('What is condition',{' '},num2str(k),{' '},'for',{' '},ExpConditions(j,1),'?\n');
        Condition= input(strcat(char(Question)),'s');
        ExpConditions(j,2+k) = cellstr(Condition);
    end
end

NumTrials = input('How many trials per condition?\n');
TotalConditions = prod(cell2mat(ExpConditions(:,2)));
NumTrials = NumTrials*TotalConditions;
Blocks = ceil(NumTrials/10); %#ok<*NASGU>
NumCal = Blocks+1;

Design = input('Blocked (1) or Randomised (2)\n');

if Design ==1;
    ExpDesign = 'Blocked';
elseif Design ==2;
    ExpDesign = 'Randomised';
end

%Ask for the sampling rate for each type of data captured
%comment out where appropriate

MoCapSampFreq = input('What was the motion capture sampling rate?\n');
EOGSampFreq = input('What was the EOG sampling rate?\n');
% EMGSampFreq = input('What was the EMG sampling rate?\n');
% GazeSampFreq = input('What was the EMG sampling rate?\n');
% ForceSampFreq = input('What was the force plate sampling rate?\n');
PreTrialLength = input('How much pre-trial processing time(sec)?\n');
TrialLength = input('How long were the trials (sec)?\n');

ParticipantList = {};

save('ParticipantList','ParticipantList');

Filename = sprintf(strcat(ExpName,' Trial List.xlsx'));

if Design == 1
elseif Design ==2
    if NumTrials<=30
        copyfile('Randomised Trial List30.xlsx',Filename)
    elseif NumTrials>30 && NumTrials<=40
        copyfile('Randomised Trial List40.xlsx',Filename)
    elseif NumTrials>40 && NumTrials<=50
        copyfile('Randomised Trial List50.xlsx',Filename)
    elseif NumTrials>50 && NumTrials<=60
        copyfile('Randomised Trial List60.xlsx',Filename)
    elseif NumTrials>60 && NumTrials<=70
        copyfile('Randomised Trial List70.xlsx',Filename)
    elseif NumTrials==80
        copyfile('Randomised Trial List80.xlsx',Filename)
    end
end

clearvars Condition j k M Question S NumConditions SubConditions ParticipantList Design
save('ExpInfo');

TF = strcmp(ExpDesign,'Randomised');
if TF==1
    Randomised_Trial_List_Maker
elseif TF==0
    Blocked_Trial_List_Maker
end

clc