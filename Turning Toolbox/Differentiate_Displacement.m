clear
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
for TrialNum =TS:NumTrials;
    load('ParticipantID');
    load('ExpInfo');
    if TrialNum<=9
        load(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
    elseif TrialNum>9
        load(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
    end
    
    TF = strcmp(TrialCondition,'Dummy Trial');
    
    if TF == 0;
        Head.Pitch.Velocity = MoCapSampFreq*(diff(Head.Pitch.Displacement));
        Head.Roll.Velocity = MoCapSampFreq*(diff(Head.Roll.Displacement));
        Head.Yaw.Velocity = MoCapSampFreq*(diff(Head.Yaw.Displacement));
        Thorax.Pitch.Velocity = MoCapSampFreq*(diff(Thorax.Pitch.Displacement));
        Thorax.Roll.Velocity = MoCapSampFreq*(diff(Thorax.Roll.Displacement));
        Thorax.Yaw.Velocity = MoCapSampFreq*(diff(Thorax.Yaw.Displacement));
        Pelvis.Pitch.Velocity = MoCapSampFreq*(diff(Pelvis.Pitch.Displacement));
        Pelvis.Roll.Velocity = MoCapSampFreq*(diff(Pelvis.Roll.Displacement));
        Pelvis.Yaw.Velocity = MoCapSampFreq*(diff(Pelvis.Yaw.Displacement));
        
        Head.Pitch.Acceleration = MoCapSampFreq*(diff(Head.Pitch.Velocity));
        Head.Roll.Acceleration = MoCapSampFreq*(diff(Head.Roll.Velocity));
        Head.Yaw.Acceleration = MoCapSampFreq*(diff(Head.Yaw.Velocity));
        Thorax.Pitch.Acceleration = MoCapSampFreq*(diff(Thorax.Pitch.Velocity));
        Thorax.Roll.Acceleration = MoCapSampFreq*(diff(Thorax.Roll.Velocity));
        Thorax.Yaw.Acceleration = MoCapSampFreq*(diff(Thorax.Yaw.Velocity));
        Pelvis.Pitch.Acceleration = MoCapSampFreq*(diff(Pelvis.Pitch.Velocity));
        Pelvis.Roll.Acceleration = MoCapSampFreq*(diff(Pelvis.Roll.Velocity));
        Pelvis.Yaw.Acceleration = MoCapSampFreq*(diff(Pelvis.Yaw.Velocity));
        
        Head.Pitch.Jerk = MoCapSampFreq*(diff(Head.Pitch.Acceleration));
        Head.Roll.Jerk = MoCapSampFreq*(diff(Head.Roll.Acceleration));
        Head.Yaw.Jerk = MoCapSampFreq*(diff(Head.Yaw.Acceleration));
        Thorax.Pitch.Jerk = MoCapSampFreq*(diff(Thorax.Pitch.Acceleration));
        Thorax.Roll.Jerk = MoCapSampFreq*(diff(Thorax.Roll.Acceleration));
        Thorax.Yaw.Jerk = MoCapSampFreq*(diff(Thorax.Yaw.Acceleration));
        Pelvis.Pitch.Jerk = MoCapSampFreq*(diff(Pelvis.Pitch.Acceleration));
        Pelvis.Roll.Jerk = MoCapSampFreq*(diff(Pelvis.Roll.Acceleration));
        Pelvis.Yaw.Jerk = MoCapSampFreq*(diff(Pelvis.Yaw.Acceleration));
    else
    end
    clearvars -except EOG ExpName FastPhases FilteredData Head LED LeftFoot NormalizedData ParticipantID Pelvis RawData RightFoot SlowPhases SteppingData Thorax TrialCondition TrialNum
    if TrialNum<=9
        save(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
    elseif TrialNum>9
        save(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
    end
    clear
end

Question = input('Do have more trials to process?\n(0)No\n(1)Yes\n');
if Question==1;
    Differentiate_Displacement
else
    beep
    clr
    disp('Differentiate Displacement complete');
    Question = input('Would you like to continue analysing?\n(0)No\n(1)Yes\n');
    if Question==1
        clr
        Turning_Analysis
    else
        clr
    end
end