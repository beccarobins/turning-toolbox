function dummytrial
%
Answer = 2;

while Answer==2
    TrialNum = input('Which trial to dummy out?\n');
    Question = strcat('Are you sure you want to dummy out Trial',{' '},num2str(TrialNum));
    disp(Question)
    Answer = input('(1) yes (2) no\n');
end

load('ParticipantID');
load('ExpInfo');
if TrialNum<=9
    load(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
elseif TrialNum>9
    load(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
end

clearvars -except ParticipantID TrialNum ExpName

TrialCondition = {'Dummy Trial'}; %#ok<*NASGU>

if TrialNum<=9
    save(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
elseif TrialNum>9
    save(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
end

clc