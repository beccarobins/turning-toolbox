CurrentFolder = pwd;
Directory = dir('*.txt');
for k = 1:length(Directory);
    FileNames(k,:) = {Directory(k,:).name}; %#ok<*SAGROW>
end
load('ExpInfo');
for CalNum = 1:NumCal
    A = find(strcmp(strcat('Cal',num2str(CalNum),'.txt'), FileNames));
    load('ParticipantID');
    load('ExpInfo');
    load(char(strcat(ExpName,{' '},ParticipantID,{' Cal '},num2str(CalNum),'.mat')));
    if A>=1
        TF = strcmp(TrialCondition,'Dummy Trial');
        if TF ==0
            data = importdata(['Cal',num2str(CalNum),'.txt']);
            clearvars Cal
            Mark = data(:,2);
            Start = find(Mark>0);
            EOG = data(:,3);
            RawEOG = EOG(Start:end,:);
            
            Step1 = 0;
            while Step1~=1;
                SubEOG = RawEOG(1:5:end,:);
                scrsz = get(0,'ScreenSize');
                figure('Position',scrsz);
                plot(SubEOG);
                [X1,Y1] = ginput(1);
                [X2,Y2] = ginput(1);
                T1 = round(X1);
                T2 = round(X2);
                Cal(:,1) = SubEOG(T1:T2,:);
                Cal(:,2) = HeadYaw(T1:T2,:);
                x = Cal(:,1);
                y = Cal(:,2);
                
                close all
                
                scatter(x,y,'bo');
                
                Step1 = input('Is Fit Line acceptable?\n(1)Yes\n(2)No\n');
                
                if Step1==1
                    fit = polyfit(x,y,1);
                    close all
                    HeadYaw = HeadYaw-HeadYaw(1,1);
                    EOGDeg = SubEOG*(fit(1,1))+fit(1,2);
                    EOGDeg = EOGDeg-EOGDeg(1,1);
                    plot(EOGDeg,'b');
                    hold
                    plot(HeadYaw,'r');
                    Step2 = input('Is Fit Variable acceptable?\n(1)Yes\n(2)No\n');
                    if Step2==2
                        clearvars Cal
                        hold off
                        Step1=0;
                    else
                    end
                else
                    clearvars Cal
                end
            end
            
            TrialCondition = {'Calibration'};
            
        else
            clearvars -except ExpName ParticipantID CalNum FileNames LED TrialCondition HeadYaw
            TrialCondition = ('Dummy Trial');
        end
        clearvars -except CalNum ExpName FileNames fit LED ParticipantID TrialCondition HeadYaw
        save(char(strcat(ExpName,{' '},ParticipantID,{' Cal '},num2str(CalNum),'.mat')));
    end
    close all
end

clearvars -except FileNames

%Determine if Separate or Block EOG Collection

A = find(strcmp('Block1.txt', FileNames));
TF = isempty(A);

if TF==0
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
                load(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
                data = importdata(['00',num2str(TrialNum),'.txt']);
            elseif TrialNum>9
                load(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
                data = importdata(['0',num2str(TrialNum),'.txt']);
            end
            TF = strcmp(TrialCondition,'Dummy Trial');
            if TF ==0
                Mark = data(:,2);
                Start = find(Mark>0);
                EOG = data(:,3);
                RawData.EOG = EOG(Start:end,:);
                
                TF = strcmp(TrialCondition(1,1),'Left');
                
                if TF==1
                    RawData.EOG = -RawData.EOG;
                end
                
                clearvars data BlockNum Start Mark EOG Right Left TF TS A k Question CurrentFolder Directory
                
                if TrialNum<=9
                    save(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
                elseif TrialNum>9
                    save(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
                end
                clearvars -except FileNames
            end
        end
    end
elseif TF==1
    load('ExpInfo');
    for BlockNum = 1:NumCal-1;
        load('ExpInfo');
        load('ParticipantID');
        EOGdatapool = importdata(['Block',num2str(BlockNum),'.txt']);
        index = find(EOGdatapool(1:end,2) >1);
        
        for j = 1:length(index);
            EOG(:,j) = EOGdatapool(index(j,1) : (index(j,1)+7999),3) ;
        end
        
        [r,c] = size(EOG);
        
        if c==10
            clearvars -except ExpName EOG ParticipantID BlockNum
            save(char(strcat(ExpName,{' '},ParticipantID,{' EOG Block '},num2str(BlockNum),'.mat')));
        elseif c>=10;
            for k = 1:10;
                BlockNum
                NumTrials(k,:) = input('Which Trials to use?\n') %#ok<*NOPTS>
            end
            clc
            for k = 1:10
                EOG(:,k) = EOG(:,NumTrials(k,1));
            end
            EOG = EOG(:,1:10);
            clearvars -except ExpName EOG ParticipantID BlockNum
            save(char(strcat(ExpName,{' '},ParticipantID,{' EOG Block '},num2str(BlockNum),'.mat')));
        end
        clear
    end
    load('ExpInfo');
    for TrialNum = 1:NumTrials
        load('ParticipantID');
        load('ExpInfo');
        if TrialNum<=9
            load(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
        elseif TrialNum>9
            load(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
        end
        load(char(strcat(ExpName,{' '},ParticipantID,{' EOG Block '},num2str(BlockNum),'.mat')));
        for j = 1:NumCal-1
            BlockedTrials(j,1) = (j*10)-9;
            BlockedTrials(j,2) = j*10;
        end
        if TrialNum<=10
            RawData.EOG = EOG(:,TrialNum);
            TF = strcmp(TrialCondition(1,1),'Left');
            if TF==1
                RawData.EOG = -RawData.EOG;
            else
            end
        elseif TrialNum>10;
            TrialLocation = TrialNum-((BlockNum-1)*10);
            RawData.EOG = EOG(:,TrialLocation);
            TF = strcmp(TrialCondition(1,1),'Left');
            if TF==1
                RawData.EOG = -RawData.EOG;
            else
            end
        end
        clearvars -except BlockNum ExpName FastPhases FilteredData Head LED LeftFoot NormalizedData ParticipantID Pelvis RawData RightFoot SlowPhases SteppingData Thorax TrialCondition TrialNum
        if TrialNum<=9
            save(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
        elseif TrialNum>9
            save(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
        end
    end
end

Question = input('Do have more trials to process?\n(0)No\n(1)Yes\n');
if Question==1;
    Import_EOG
else
    Source = pwd;
    Destination = strrep(Source,'EOG','MATLAB');
    copyfile(strcat(Source,'/*.mat'),Destination);
    cd(Destination)
    
    beep
    disp('Import Kinematics script complete');
    disp('You are now in the MAT file directory');
    
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