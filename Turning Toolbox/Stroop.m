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
            TF(:,j) = strcmp('Stroop', TrialCondition(:,j));
        end
        
        Sum = sum(TF);
        
        if Sum == 1
            k = {'Black'};
            b = {'Blue'};
            r = {'Red'};
            g = {'Green'};
            Trial = strcat('Trial Number',{' '},num2str(TrialNum)); %#ok<*NOPTS>
            disp(Trial)
            StroopWord(1,1) = input('What was the first Stroop word?\n');
            StroopWord(1,2) = input('What was the second Stroop word?\n');
            StroopWord (1,3) = input('What was the third Stroop word?\n');
            StroopColour(1,1) = input('What was the first Stroop colour?\n');
            StroopColour(1,2) = input('What was the second Stroop colour?\n');
            StroopColour(1,3) = input('What was the third Stroop colour?\n');
            StroopAnswer(1,1) = input('What was the first Stroop answer?\n');
            StroopAnswer(1,2) = input('What was the second Stroop answer?\n');
            StroopAnswer(1,3) = input('What was the third Stroop answer?\n');
            
            for k = 1:3
                TF(1,k) = strcmp(StroopColour(1,k), StroopAnswer(1,k));
            end
            
            NumCorrect = sum(TF);
            StroopAccuracy = (NumCorrect/3)*100;
            if StroopAccuracy == 100;
                StroopCorrectness = 'Correct';
            else if StroopAccuracy == 0
                    StroopCorrectness = 'Incorrect';
                else
                    StroopCorrectness = 'Partially Correct';
                end
            end
        else
            clearvars Stroop TF
        end
    else
    end
    clearvars -except EOG ExpName FastPhases FilteredData Head LeftFoot NormalizedData ParticipantID Pelvis RightFoot SteppingData StroopAccuracy StroopCorrectness SubtractionAccuracy Thorax TrialCondition TrialNum
    if TrialNum<=9
        save(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
    elseif TrialNum>9
        save(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
    end
    clear
end

beep
h = msgbox('Stroop Script Complete');
clear
clc