Directory = dir('*.txt');
for k = 1:length(Directory);
    FileNames(k,:) = {Directory(k,:).name}; %#ok<*SAGROW>
end
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
    
    if TrialNum<=9
        A = find(strcmp(strcat('00',num2str(TrialNum),'.txt'), FileNames));
    elseif TrialNum>9
        A = find(strcmp(strcat('0',num2str(TrialNum),'.txt'), FileNames));
    end
    
    load('ParticipantID');
    load('ExpInfo');
    
    if A>=1
        if TrialNum<=9
            data = importdata(['00',num2str(TrialNum),'.txt']);
        elseif TrialNum>9
            data = importdata(['0',num2str(TrialNum),'.txt']);
        end
        
        if TrialNum<=10
            BlockNum = 1;
        elseif TrialNum>10
            Remainder = rem(TrialNum,10);
            if Remainder == 0;
                BlockNum = TrialNum/10;
            elseif Remainder>0;
                BlockNum = floor(TrialNum/10)+1;
            end
        end
        
        LED = data.data;
        LED = LED(:,3);
        TrialCondition = TrialList(TrialNum,:);
        
        clearvars -except BlockNum EOG ExpName FastPhases FileNames FilteredData Head LED LeftFoot NormalizedData ParticipantID Pelvis RawData RightFoot SlowPhases SteppingData Thorax TrialCondition TrialNum
    else
        TrialCondition = ('Dummy Trial');
    end
    
    if TrialNum<=9
        save(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
    elseif TrialNum>9
        save(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
    end
    
    clearvars -except FileNames
end
load('ExpInfo');
for CalNum = 1:NumCal;
    
    load('ParticipantID');
    load('ExpInfo');
    A = find(strcmp(strcat('Cal',num2str(CalNum),'.txt'), FileNames));
    
    if A>=1
        data = importdata(['Cal',num2str(CalNum),'.txt']);
        LED = data.data;
        LED = LED(:,3);
        TrialCondition = 'Calibration';
        clearvars -except ExpName FileNames LED ParticipantID TrialCondition CalNum
    else
        TrialCondition = ('Dummy Trial');
        clearvars -except ExpName FileNames LED ParticipantID TrialCondition CalNum
    end
    
    clearvars data A
    save(char(strcat(ExpName,{' '},ParticipantID,{' Cal '},num2str(CalNum),'.mat')));
    
end

Question = input('Do have more trials to process?\n(0)No\n(1)Yes\n');
if Question==1;
    Import_LED
else
    Source = pwd;
    Destination = strrep(Source,'LED','Kinematics');
    copyfile(strcat(Source,'/*.mat'),Destination);
    cd(Destination)
    
    beep
    disp('Import LED script complete');
    disp('You are now in the Kinematics directory');
    
    Question = input('Would you like to continue analysing?\n(0)No\n(1)Yes\n');
    if Question==1
        clear
        clc
        Turning_Analysis
    else
        clear
        clc
    end
end