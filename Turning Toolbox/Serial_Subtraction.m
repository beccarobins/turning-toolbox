Question = input('Process:\n(1)All trials\n(2)Multiple trials\n(3)One trial\n ');
if Question==1;
    TS = 1;
    load('ExpInfo');
elseif Question==2;
    TS = input('Which trial to start with?\n');
    NumTrials = input('Which trial to end with?\n');
elseif Question==3
    TS = input('Which trial to process?\n');
    NumTrials = TS;
end
for TrialNum = TS:NumTrials;
    load('ParticipantID');
    load('ExpInfo');
    if TrialNum<=9
        load(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
    elseif TrialNum>9
        load(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
    end
    
    TF = strcmp(TrialCondition,'Dummy Trial');
    
    if TF == 0;
        
        for j = 1:length(TrialCondition)
            TF(:,j) = strcmp('Subtraction', TrialCondition(:,j));
        end
        
        Sum = sum(TF);
        [Max,MaxRow] = max(Sum);
        
        if Sum == 1
            Trial = strcat('Trial Number',{' '},num2str(TrialNum)); %#ok<*NOPTS>
            disp(Trial)
            SubtractionNum = input('What was the Subtraction number?\n');
            SubtractionAnswer = input('What was the Subtraction answer?\n');
            MaxSub = SubtractionNum/3;
            for k = 1:MaxSub
                CorrectAnswers(k,:) = SubtractionNum-3; %#ok<*SAGROW>
                SubtractionNum = CorrectAnswers(k,:);
            end
            NumSubtractions = find(CorrectAnswers==SubtractionAnswer);
            A = isempty(NumSubtractions);
            if A == 0;
                SubtractionAccuracy = 'Correct';
            else
                SubtractionAccuracy = 'Incorrect';
            end
        else
            clearvars Subtraction TF
        end
    else
    end
    clearvars -except EOG ExpName FastPhases FilteredData Head LeftFoot NormalizedData ParticipantID Pelvis RightFoot SteppingData SubtractionAccuracy Thorax TrialCondition TrialNum
    if TrialNum<=9
        save(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
    elseif TrialNum>9
        save(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
    end
    clear
end

beep
h = msgbox('Serial Subtraction Script Complete');
clear
clc