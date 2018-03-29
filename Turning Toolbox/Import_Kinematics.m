CurrentFolder = pwd;
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
    
    if A>=1
        load('ParticipantID');
        load('ExpInfo');
        if TrialNum<=9
            load(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
            data = importdata(['00',num2str(TrialNum),'.txt']);
        elseif TrialNum>9
            load(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
            data = importdata(['0',num2str(TrialNum),'.txt']);
        end
        
        TF = strcmp(TrialCondition,'Dummy Trial');
        
        if TF==0
            
            A = exist('RawData','var');
            B = exist('FilteredData','var');
            C = exist('Head','var');
            D = exist('Thorax','var');
            E = exist('Pelvis','var');
            F = exist('LeftFoot','var');
            G = exist('RightFoot','var');
            
            if A == 0 && B == 0 && C == 0 && D == 0 && E == 0 && F == 0 && G == 0;
                RawData = struct;
                FilteredData = struct;
                Head = struct;
                Thorax = struct;
                Pelvis = struct;
                LeftFoot = struct;
                RightFoot = struct;
            end
            
            Kin = data.data;
            Headings = data.textdata;
            
            A = find(ismember(Headings,'LHeadAngles:X'));
            B = find(ismember(Headings,(strcat(ParticipantID,'LHeadAngles:X'))));
            C = isempty(A);
            D = isempty(B);
            
            if C>=D;
                TF = 0;
            else
                TF = 1;
            end
            
            if TF == 1;
                HeadColumn(:,1) = find(strcmp(('LHeadAngles:X'), Headings));
                HeadColumn(:,2) = find(strcmp(('LHeadAngles:Y'), Headings));
                HeadColumn(:,3) = find(strcmp(('LHeadAngles:Z'), Headings));
                ThoraxColumn(:,1) =find(strcmp(('LThoraxAngles:X'), Headings));
                ThoraxColumn(:,2) = find(strcmp(('LThoraxAngles:Y'), Headings));
                ThoraxColumn(:,3) = find(strcmp(('LThoraxAngles:Z'), Headings));
                PelvisColumn(:,1) = find(strcmp(('LPelvisAngles:X'), Headings));
                PelvisColumn(:,2) = find(strcmp(('LPelvisAngles:Y'), Headings));
                PelvisColumn(:,3) = find(strcmp(('LPelvisAngles:Z'), Headings));
                LFootColumn(:,1) = find(strcmp(('LFootProgressAngles:X'), Headings));
                LFootColumn(:,2) = find(strcmp(('LFootProgressAngles:Y'), Headings));
                LFootColumn(:,3) = find(strcmp(('LFootProgressAngles:Z'), Headings));
                RFootColumn(:,1) = find(strcmp(('RFootProgressAngles:X'), Headings));
                RFootColumn(:,2) = find(strcmp(('RFootProgressAngles:Y'), Headings));
                RFootColumn(:,3) = find(strcmp(('RFootProgressAngles:Z'), Headings));
            else
                HeadColumn(:,1) = find(strcmp(strcat(ParticipantID,':LHeadAngles:X'), Headings));
                HeadColumn(:,2) = find(strcmp(strcat(ParticipantID,':LHeadAngles:Y'), Headings));
                HeadColumn(:,3) = find(strcmp(strcat(ParticipantID,':LHeadAngles:Z'), Headings));
                ThoraxColumn(:,1) = find(strcmp(strcat(ParticipantID,':LThoraxAngles:X'), Headings));
                ThoraxColumn(:,2) = find(strcmp(strcat(ParticipantID,':LThoraxAngles:Y'), Headings));
                ThoraxColumn(:,3) = find(strcmp(strcat(ParticipantID,':LThoraxAngles:Z'), Headings));
                PelvisColumn(:,1) = find(strcmp(strcat(ParticipantID,':LPelvisAngles:X'), Headings));
                PelvisColumn(:,2) = find(strcmp(strcat(ParticipantID,':LPelvisAngles:Y'), Headings));
                PelvisColumn(:,3) = find(strcmp(strcat(ParticipantID,':LPelvisAngles:Z'), Headings));
                LFootColumn(:,1) = find(strcmp(strcat(ParticipantID,':LFootProgressAngles:X'), Headings));
                LFootColumn(:,2) = find(strcmp(strcat(ParticipantID,':LFootProgressAngles:Y'), Headings));
                LFootColumn(:,3) = find(strcmp(strcat(ParticipantID,':LFootProgressAngles:Z'), Headings));
                RFootColumn(:,1) = find(strcmp(strcat(ParticipantID,':RFootProgressAngles:X'), Headings));
                RFootColumn(:,2) = find(strcmp(strcat(ParticipantID,':RFootProgressAngles:Y'), Headings));
                RFootColumn(:,3) = find(strcmp(strcat(ParticipantID,':RFootProgressAngles:Z'), Headings));
            end
            
            Trial(:,1) = Kin(:,HeadColumn(:,1));
            Trial(:,2) = Kin(:,HeadColumn(:,2));
            Trial(:,3) = Kin(:,HeadColumn(:,3));
            Trial(:,4) = Kin(:,ThoraxColumn(:,1));
            Trial(:,5) = Kin(:,ThoraxColumn(:,2));
            Trial(:,6) = Kin(:,ThoraxColumn(:,3));
            Trial(:,7) = Kin(:,PelvisColumn(:,1));
            Trial(:,8) = Kin(:,PelvisColumn(:,2));
            Trial(:,9) = Kin(:,PelvisColumn(:,3));
            Trial(:,10) = Kin(:,LFootColumn(:,1));
            Trial(:,11) = Kin(:,LFootColumn(:,2));
            Trial(:,12) = Kin(:,LFootColumn(:,3));
            Trial(:,13) = Kin(:,RFootColumn(:,1));
            Trial(:,14) = Kin(:,RFootColumn(:,2));
            Trial(:,15) = Kin(:,RFootColumn(:,3));
            
            [X,Y] = find(LED~=0);
            SyncTime = X(1,1);
            PreTrialFrames = (PreTrialLength*MoCapSampFreq)-1;
            TrialFrames = TrialLength*MoCapSampFreq;
            RawData.Kinematics = Trial(SyncTime:SyncTime+TrialFrames,:);
            if SyncTime<1000;
                RawData.Sway = Trial(1:SyncTime-1,:);
            else
                RawData.Sway = Trial(SyncTime-1000:SyncTime-1,:);
            end
            [d,c] = butter(2,6/100,'low');
            FilteredData.Kinematics = filtfilt(d,c,RawData.Kinematics); %#ok<*NASGU>
            FilteredData.Sway = filtfilt(d,c,RawData.Sway);
            
            for j = 1:15
                FilteredData.Kinematics(:,j) = FilteredData.Kinematics(:,j)-FilteredData.Kinematics(1,j);
                FilteredData.Sway(:,j) = FilteredData.Sway(:,j)-FilteredData.Sway(1,j);
            end
            
            Head.Roll.Displacement = FilteredData.Kinematics(:,1);
            Head.Pitch.Displacement = FilteredData.Kinematics(:,2);
            Head.Yaw.Displacement = FilteredData.Kinematics(:,3);
            Thorax.Roll.Displacement = FilteredData.Kinematics(:,4);
            Thorax.Pitch.Displacement = FilteredData.Kinematics(:,5);
            Thorax.Yaw.Displacement = FilteredData.Kinematics(:,6);
            Pelvis.Roll.Displacement = FilteredData.Kinematics(:,7);
            Pelvis.Pitch.Displacement = FilteredData.Kinematics(:,8);
            Pelvis.Yaw.Displacement = FilteredData.Kinematics(:,9);
            LeftFoot.LFootX = FilteredData.Kinematics(:,10);
            LeftFoot.LFootY = FilteredData.Kinematics(:,11);
            LeftFoot.LFootZ = FilteredData.Kinematics(:,12);
            RightFoot.RFootX = FilteredData.Kinematics(:,13);
            RightFoot.RFootY = FilteredData.Kinematics(:,14);
            RightFoot.RFootZ = FilteredData.Kinematics(:,15);
            
            TF = strcmp(TrialCondition(1,1),'Left');
            if TF==1
                Head.Yaw.Displacement = -Head.Yaw.Displacement;
                Thorax.Yaw.Displacement = -Thorax.Yaw.Displacement;
                Pelvis.Yaw.Displacement = -Pelvis.Yaw.Displacement;
            else
            end
        end
        
        clearvars -except BlockNum EOG ExpName FastPhases FileNames FilteredData Head LED LeftFoot NormalizedData ParticipantID Pelvis RawData RightFoot SlowPhases SteppingData Thorax TrialCondition TrialNum
        
    else
        clearvars -except FileNames ExpName ParticipantID TrialCondition TrialNum
        TrialCondition = 'Dummy Trial';
    end
    
    if TrialNum<=9
        save(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
    elseif TrialNum>9
        save(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
    end
end
load('ExpInfo');
for CalNum = 1:NumCal;
    
    A = find(strcmp(strcat('Cal',num2str(CalNum),'.txt'), FileNames));
    load('ParticipantID');
    load('ExpInfo');
    if A>=1
        
        load(char(strcat(ExpName,{' '},ParticipantID,{' Cal '},num2str(CalNum),'.mat')));
        data = importdata(['Cal',num2str(CalNum),'.txt'],'\t',1);
        
        TF = strcmp(TrialCondition,'Dummy Trial');
        
        if TF==0
            
            Kin = data.data;
            Headings = data.textdata;
            
            A = find(ismember(Headings,'LHeadAngles:X'));
            B = find(ismember(Headings,(strcat(ParticipantID,'LHeadAngles:X'))));
            C = isempty(A);
            D = isempty(B);
            
            if C>=D;
                TF = 0;
            else
                TF = 1;
            end
            
            if TF == 1;
                HeadColumn = find(strcmp(('LHeadAngles:Z'), Headings));
            else
                HeadColumn = find(strcmp(strcat(ParticipantID,':LHeadAngles:Z'), Headings));
            end
            
            [X,Y] = find(LED~=0);
            SyncTime = X(1,1);
            Trial = Kin(:,HeadColumn);
            HeadYaw = Trial(SyncTime:end,:);
            
            clearvars -except ExpName HeadYaw CalNum ParticipantID FileNames TrialCondition LED
        else
        end
        save(char(strcat(ExpName,{' '},ParticipantID,{' Cal '},num2str(CalNum),'.mat')));
    end
    clearvars -except FileNames
end

Question = input('Do have more trials to process?\n(0)No\n(1)Yes\n');
if Question==1;
    Import_Kinematics
else
    Source = pwd;
    Destination = strrep(Source,'Kinematics','EOG');
    copyfile(strcat(Source,'/*.mat'),Destination);
    cd(Destination)
    
    beep
    disp('Import Kinematics script complete');
    disp('You are now in the EOG directory');
    
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