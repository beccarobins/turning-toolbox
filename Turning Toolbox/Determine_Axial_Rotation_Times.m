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
clearvars Question
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
        
        Head.Yaw.DisplacementVariables.OnsetLatency = onsetlatency(Head.Yaw.Displacement,Head.Yaw.Velocity,TrialNum);
        Head.Yaw.DisplacementVariables.OnsetLatency_ms = Head.Yaw.DisplacementVariables.OnsetLatency*5;
        Head.Yaw.DisplacementVariables.OnsetLatency_sec = Head.Yaw.DisplacementVariables.OnsetLatency_ms/1000;
        
        Thorax.Yaw.DisplacementVariables.OnsetLatency = onsetlatency(Thorax.Yaw.Displacement,Thorax.Yaw.Velocity,TrialNum);
        Thorax.Yaw.DisplacementVariables.OnsetLatency_ms = Thorax.Yaw.DisplacementVariables.OnsetLatency*5;
        Thorax.Yaw.DisplacementVariables.OnsetLatency_sec = Thorax.Yaw.DisplacementVariables.OnsetLatency_ms/1000;
        
        Pelvis.Yaw.DisplacementVariables.OnsetLatency = onsetlatency(Pelvis.Yaw.Displacement,Pelvis.Yaw.Velocity,TrialNum);
        Pelvis.Yaw.DisplacementVariables.OnsetLatency_ms = Pelvis.Yaw.DisplacementVariables.OnsetLatency*5;
        Pelvis.Yaw.DisplacementVariables.OnsetLatency_sec = Pelvis.Yaw.DisplacementVariables.OnsetLatency_ms/1000;
        
        Head.Yaw.DisplacementVariables.EndTime = endtime(Head.Yaw.Displacement,Head.Yaw.Velocity,TrialNum);
        Head.Yaw.DisplacementVariables.EndTime_ms = Head.Yaw.DisplacementVariables.EndTime*5;
        Head.Yaw.DisplacementVariables.EndTime_sec = Head.Yaw.DisplacementVariables.EndTime_ms/1000;
        
        Thorax.Yaw.DisplacementVariables.EndTime = endtime(Thorax.Yaw.Displacement,Thorax.Yaw.Velocity,TrialNum);
        Thorax.Yaw.DisplacementVariables.EndTime_ms = Thorax.Yaw.DisplacementVariables.EndTime*5;
        Thorax.Yaw.DisplacementVariables.EndTime_sec = Thorax.Yaw.DisplacementVariables.EndTime_ms/1000;
        
        Pelvis.Yaw.DisplacementVariables.EndTime = endtime(Pelvis.Yaw.Displacement,Pelvis.Yaw.Velocity,TrialNum);
        Pelvis.Yaw.DisplacementVariables.EndTime_ms = Pelvis.Yaw.DisplacementVariables.EndTime*5;
        Pelvis.Yaw.DisplacementVariables.EndTime_sec = Pelvis.Yaw.DisplacementVariables.EndTime_ms/1000;
    else
    end
    clearvars -except BlockNum EOG ExpName FastPhases FilteredData Head LED LeftFoot NormalizedData ParticipantID Pelvis RawData RightFoot SlowPhases SteppingData Thorax TrialCondition TrialNum
    if TrialNum<=9
        save(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
    elseif TrialNum>9
        save(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
    end
    clear
end

Question = input('Do have more trials to process?\n(0)No\n(1)Yes\n');
if Question==1;
    Determine_Axial_Rotation_Times
else
    beep
    clr
    disp('Determine Axial Rotation Times script complete');
    Question = input('Would you like to continue analysing?\n(0)No\n(1)Yes\n');
    if Question==1
        clr
        Turning_Analysis
    else
        clr
    end
end