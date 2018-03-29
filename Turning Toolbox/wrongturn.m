function wrongturn

Answer = 2;
while Answer==2
    TrialNum = input('On which trial did the participant turn in the wrong direction?\n');
    Question = strcat('Are you sure you want to flip Trial',{' '},num2str(TrialNum));
    disp(Question);
    Answer = input('(1) yes (2) no\n');
end

load('ExpInfo');
load('ParticipantID');

if TrialNum<=9
    load(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
elseif TrialNum>9
    load(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
end

Head.Yaw.Displacement = -Head.Yaw.Displacement; %#ok<*NODEF>
Thorax.Yaw.Displacement = -Thorax.Yaw.Displacement;
Pelvis.Yaw.Displacement = -Pelvis.Yaw.Displacement;

TF = strcmp(TrialCondition(1,1),'Left');

if TF==1
    TrialCondition(1,1)={'Right'}; %#ok<*NASGU>
else
    TrialCondition(1,1)={'Left'};
end

clearvars Answer Question
if TrialNum<=9
    save(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
elseif TrialNum>9
    save(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
end

Statement = strcat('Make sure to run Differentiate Displacement and Dependent Variables scripts again on Trial',{' '},num2str(TrialNum));
disp(Statement);

pause

clearvars -except TrialNum

load('ExpInfo')

TF = strcmp(TrialList(TrialNum,1),'Left');

if TF==1
    TrialList(TrialNum,1)={'Right'};
else
    TrialList(TrialNum,1)={'Left'};
end

clearvars TrialNum

save('ExpInfo')

clc
