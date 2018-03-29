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
        Head.Pitch.DisplacementVariables.OnsetLatency_sec = nan;
        Head.Pitch.DisplacementVariables.EndTime_sec = nan;
        Head.Pitch.DisplacementVariables.Mean = mean(Head.Pitch.Displacement);
        Head.Pitch.DisplacementVariables.Median = median(Head.Pitch.Displacement);
        Head.Pitch.DisplacementVariables.Mode = mode(Head.Pitch.Displacement);
        [Head.Pitch.DisplacementVariables.Min,Head.Pitch.DisplacementVariables.MinTime] = min(Head.Pitch.Displacement);
        [Head.Pitch.DisplacementVariables.Max,Head.Pitch.DisplacementVariables.MaxTime] = max(Head.Pitch.Displacement);
        Head.Pitch.DisplacementVariables.Range = Head.Pitch.DisplacementVariables.Max-Head.Pitch.DisplacementVariables.Min;
        Head.Pitch.DisplacementVariables.SD = std(Head.Pitch.Displacement);
        Head.Pitch.DisplacementVariables.SE = ste(Head.Pitch.Displacement);
        Head.Pitch.DisplacementVariables.CI = ci(Head.Pitch.Displacement);
        Head.Pitch.DisplacementVariables.CV = cv(Head.Pitch.Displacement);
        Head.Pitch.DisplacementVariables.IQR = iqr(Head.Pitch.Displacement);
        Head.Pitch.DisplacementVariables.Variance = var(Head.Pitch.Displacement);
        Head.Pitch.DisplacementVariables.RMS= rms(Head.Pitch.Displacement);
        if abs(Head.Pitch.DisplacementVariables.Min)>Head.Pitch.DisplacementVariables.Max
            Head.Pitch.DisplacementVariables.Direction = {'Down'};
        else
            Head.Pitch.DisplacementVariables.Direction = {'Up'};
        end
        
        Head.Pitch.VelocityVariables.Mean = mean(Head.Pitch.Velocity);
        Head.Pitch.VelocityVariables.Median = median(Head.Pitch.Velocity);
        Head.Pitch.VelocityVariables.Mode = mode(Head.Pitch.Velocity);
        [Head.Pitch.VelocityVariables.Min,Head.Pitch.VelocityVariables.MinTime] = min(Head.Pitch.Velocity);
        [Head.Pitch.VelocityVariables.Max,Head.Pitch.VelocityVariables.MaxTime] = max(Head.Pitch.Velocity);
        Head.Pitch.VelocityVariables.Range = Head.Pitch.VelocityVariables.Max-Head.Pitch.VelocityVariables.Min;
        Head.Pitch.VelocityVariables.SD = std(Head.Pitch.Velocity);
        Head.Pitch.VelocityVariables.SE = ste(Head.Pitch.Velocity);
        Head.Pitch.VelocityVariables.CI = ci(Head.Pitch.Velocity);
        Head.Pitch.VelocityVariables.CV = cv(Head.Pitch.Velocity);
        Head.Pitch.VelocityVariables.IQR = iqr(Head.Pitch.Velocity);
        Head.Pitch.VelocityVariables.Variance = var(Head.Pitch.Velocity);
        Head.Pitch.VelocityVariables.RMS = rms(Head.Pitch.Velocity);
        Head.Pitch.VelocityVariables.Oscillation = Head.Pitch.VelocityVariables.Max/Head.Pitch.VelocityVariables.Min;
        
        Head.Pitch.AccelerationVariables.Mean = mean(Head.Pitch.Acceleration);
        Head.Pitch.AccelerationVariables.Median = median(Head.Pitch.Acceleration);
        Head.Pitch.AccelerationVariables.Mode = mode(Head.Pitch.Acceleration);
        [Head.Pitch.AccelerationVariables.Min,Head.Pitch.AccelerationVariables.MinTime] = min(Head.Pitch.Acceleration);
        [Head.Pitch.AccelerationVariables.Max,Head.Pitch.AccelerationVariables.MaxTime] = max(Head.Pitch.Acceleration);
        Head.Pitch.AccelerationVariables.Range = Head.Pitch.AccelerationVariables.Max-Head.Pitch.AccelerationVariables.Min;
        Head.Pitch.AccelerationVariables.SD = std(Head.Pitch.Acceleration);
        Head.Pitch.AccelerationVariables.SE = ste(Head.Pitch.Acceleration);
        Head.Pitch.AccelerationVariables.CI = ci(Head.Pitch.Acceleration);
        Head.Pitch.AccelerationVariables.CV = cv(Head.Pitch.Acceleration);
        Head.Pitch.AccelerationVariables.IQR = iqr(Head.Pitch.Acceleration);
        Head.Pitch.AccelerationVariables.Variance = var(Head.Pitch.Acceleration);
        Head.Pitch.AccelerationVariables.RMS = rms(Head.Pitch.Acceleration);
        
        Head.Roll.DisplacementVariables.OnsetLatency_sec = nan;
        Head.Roll.DisplacementVariables.EndTime_sec = nan;
        Head.Roll.DisplacementVariables.Mean = mean(Head.Roll.Displacement);
        Head.Roll.DisplacementVariables.Median = median(Head.Roll.Displacement);
        Head.Roll.DisplacementVariables.Mode = mode(Head.Roll.Displacement);
        [Head.Roll.DisplacementVariables.Min,Head.Roll.DisplacementVariables.MinTime] = min(Head.Roll.Displacement);
        [Head.Roll.DisplacementVariables.Max,Head.Roll.DisplacementVariables.MaxTime] = max(Head.Roll.Displacement);
        Head.Roll.DisplacementVariables.Range = Head.Roll.DisplacementVariables.Max-Head.Roll.DisplacementVariables.Min;
        Head.Roll.DisplacementVariables.SD = std(Head.Roll.Displacement);
        Head.Roll.DisplacementVariables.SE = ste(Head.Roll.Displacement);
        Head.Roll.DisplacementVariables.CI = ci(Head.Roll.Displacement);
        Head.Roll.DisplacementVariables.CV = cv(Head.Roll.Displacement);
        Head.Roll.DisplacementVariables.IQR = iqr(Head.Roll.Displacement);
        Head.Roll.DisplacementVariables.Variance = var(Head.Roll.Displacement);
        Head.Roll.DisplacementVariables.RMS = rms(Head.Roll.Displacement);
        if abs(Head.Roll.DisplacementVariables.Min)>Head.Roll.DisplacementVariables.Max
            Head.Roll.DisplacementVariables.Direction = {'Left'};
        else
            Head.Roll.DisplacementVariables.Direction = {'Right'};
        end
        
        Head.Roll.VelocityVariables.Mean = mean(Head.Roll.Velocity);
        Head.Roll.VelocityVariables.Median = median(Head.Roll.Velocity);
        Head.Roll.VelocityVariables.Mode = mode(Head.Roll.Velocity);
        [Head.Roll.VelocityVariables.Min,Head.Roll.VelocityVariables.MinTime] = min(Head.Roll.Velocity);
        [Head.Roll.VelocityVariables.Max,Head.Roll.VelocityVariables.MaxTime] = max(Head.Roll.Velocity);
        Head.Roll.VelocityVariables.Range = Head.Roll.VelocityVariables.Max-Head.Roll.VelocityVariables.Min;
        Head.Roll.VelocityVariables.SD = std(Head.Roll.Velocity);
        Head.Roll.VelocityVariables.SE = ste(Head.Roll.Velocity);
        Head.Roll.VelocityVariables.CI = ci(Head.Roll.Velocity);
        Head.Roll.VelocityVariables.CV = cv(Head.Roll.Velocity);
        Head.Roll.VelocityVariables.IQR = iqr(Head.Roll.Velocity);
        Head.Roll.VelocityVariables.Variance = var(Head.Roll.Velocity);
        Head.Roll.VelocityVariables.RMS = rms(Head.Roll.Velocity);
        Head.Roll.VelocityVariables.Oscillation = Head.Roll.VelocityVariables.Max/Head.Roll.VelocityVariables.Min;
        
        Head.Roll.AccelerationVariables.Mean = mean(Head.Roll.Acceleration);
        Head.Roll.AccelerationVariables.Median = median(Head.Roll.Acceleration);
        Head.Roll.AccelerationVariables.Mode = mode(Head.Roll.Acceleration);
        [Head.Roll.AccelerationVariables.Min,Head.Roll.AccelerationVariables.MinTime] = min(Head.Roll.Acceleration);
        [Head.Roll.AccelerationVariables.Max,Head.Roll.AccelerationVariables.MaxTime] = max(Head.Roll.Acceleration);
        Head.Roll.AccelerationVariables.Range = Head.Roll.AccelerationVariables.Max-Head.Roll.AccelerationVariables.Min;
        Head.Roll.AccelerationVariables.SD = std(Head.Roll.Acceleration);
        Head.Roll.AccelerationVariables.SE = ste(Head.Roll.Acceleration);
        Head.Roll.AccelerationVariables.CI = ci(Head.Roll.Acceleration);
        Head.Roll.AccelerationVariables.CV = cv(Head.Roll.Acceleration);
        Head.Roll.AccelerationVariables.IQR = iqr(Head.Roll.Acceleration);
        Head.Roll.AccelerationVariables.Variance = var(Head.Roll.Acceleration);
        Head.Roll.AccelerationVariables.RMS = rms(Head.Roll.Acceleration);
        
        Head.Yaw.DisplacementVariables.Mean = mean(Head.Yaw.Displacement);
        Head.Yaw.DisplacementVariables.Median = median(Head.Yaw.Displacement);
        Head.Yaw.DisplacementVariables.Mode = mode(Head.Yaw.Displacement);
        [Head.Yaw.DisplacementVariables.Min,Head.Yaw.DisplacementVariables.MinTime] = min(Head.Yaw.Displacement);
        [Head.Yaw.DisplacementVariables.Max,Head.Yaw.DisplacementVariables.MaxTime] = max(Head.Yaw.Displacement);
        Head.Yaw.DisplacementVariables.Range = Head.Yaw.DisplacementVariables.Max-Head.Yaw.DisplacementVariables.Min;
        Head.Yaw.DisplacementVariables.SD = std(Head.Yaw.Displacement);
        Head.Yaw.DisplacementVariables.SE = ste(Head.Yaw.Displacement);
        Head.Yaw.DisplacementVariables.CI = ci(Head.Yaw.Displacement);
        Head.Yaw.DisplacementVariables.CV = cv(Head.Yaw.Displacement);
        Head.Yaw.DisplacementVariables.IQR = iqr(Head.Yaw.Displacement);
        Head.Yaw.DisplacementVariables.Variance = var(Head.Yaw.Displacement);
        Head.Yaw.DisplacementVariables.RMS = rms(Head.Yaw.Displacement);
        Head.Yaw.DisplacementVariables.Direction = TrialCondition(1,1);
        
        Head.Yaw.VelocityVariables.Mean = mean(Head.Yaw.Velocity);
        Head.Yaw.VelocityVariables.Median = median(Head.Yaw.Velocity);
        Head.Yaw.VelocityVariables.Mode = mode(Head.Yaw.Velocity);
        [Head.Yaw.VelocityVariables.Min,Head.Yaw.VelocityVariables.MinTime] = min(Head.Yaw.Velocity);
        [Head.Yaw.VelocityVariables.Max,Head.Yaw.VelocityVariables.MaxTime] = max(Head.Yaw.Velocity);
        Head.Yaw.VelocityVariables.Range = Head.Yaw.VelocityVariables.Max-Head.Yaw.VelocityVariables.Min;
        Head.Yaw.VelocityVariables.SD = std(Head.Yaw.Velocity);
        Head.Yaw.VelocityVariables.SE = ste(Head.Yaw.Velocity);
        Head.Yaw.VelocityVariables.CI = ci(Head.Yaw.Velocity);
        Head.Yaw.VelocityVariables.CV = cv(Head.Yaw.Velocity);
        Head.Yaw.VelocityVariables.IQR = iqr(Head.Yaw.Velocity);
        Head.Yaw.VelocityVariables.Variance = var(Head.Yaw.Velocity);
        Head.Yaw.VelocityVariables.RMS = rms(Head.Yaw.Velocity);
        Head.Yaw.VelocityVariables.Oscillation = Head.Yaw.VelocityVariables.Max/Head.Yaw.VelocityVariables.Min;
        
        Head.Yaw.AccelerationVariables.Mean = mean(Head.Yaw.Acceleration);
        Head.Yaw.AccelerationVariables.Median = median(Head.Yaw.Acceleration);
        Head.Yaw.AccelerationVariables.Mode = mode(Head.Yaw.Acceleration);
        [Head.Yaw.AccelerationVariables.Min,Head.Yaw.AccelerationVariables.MinTime] = min(Head.Yaw.Acceleration);
        [Head.Yaw.AccelerationVariables.Max,Head.Yaw.AccelerationVariables.MaxTime] = max(Head.Yaw.Acceleration);
        Head.Yaw.AccelerationVariables.Range = Head.Yaw.AccelerationVariables.Max-Head.Yaw.AccelerationVariables.Min;
        Head.Yaw.AccelerationVariables.SD = std(Head.Yaw.Acceleration);
        Head.Yaw.AccelerationVariables.SE = ste(Head.Yaw.Acceleration);
        Head.Yaw.AccelerationVariables.CI = ci(Head.Yaw.Acceleration);
        Head.Yaw.AccelerationVariables.CV = cv(Head.Yaw.Acceleration);
        Head.Yaw.AccelerationVariables.IQR = iqr(Head.Yaw.Acceleration);
        Head.Yaw.AccelerationVariables.Variance = var(Head.Yaw.Acceleration);
        Head.Yaw.AccelerationVariables.RMS = rms(Head.Yaw.Acceleration);
        
        Thorax.Pitch.DisplacementVariables.OnsetLatency_sec = nan;
        Thorax.Pitch.DisplacementVariables.EndTime_sec = nan;
        Thorax.Pitch.DisplacementVariables.Mean = mean(Thorax.Pitch.Displacement);
        Thorax.Pitch.DisplacementVariables.Median = median(Thorax.Pitch.Displacement);
        Thorax.Pitch.DisplacementVariables.Mode = mode(Thorax.Pitch.Displacement);
        [Thorax.Pitch.DisplacementVariables.Min,Thorax.Pitch.DisplacementVariables.MinTime] = min(Thorax.Pitch.Displacement);
        [Thorax.Pitch.DisplacementVariables.Max,Thorax.Pitch.DisplacementVariables.MaxTime] = max(Thorax.Pitch.Displacement);
        Thorax.Pitch.DisplacementVariables.Range = Thorax.Pitch.DisplacementVariables.Max-Thorax.Pitch.DisplacementVariables.Min;
        Thorax.Pitch.DisplacementVariables.SD = std(Thorax.Pitch.Displacement);
        Thorax.Pitch.DisplacementVariables.SE = ste(Thorax.Pitch.Displacement);
        Thorax.Pitch.DisplacementVariables.CI = ci(Thorax.Pitch.Displacement);
        Thorax.Pitch.DisplacementVariables.CV = cv(Thorax.Pitch.Displacement);
        Thorax.Pitch.DisplacementVariables.IQR = iqr(Thorax.Pitch.Displacement);
        Thorax.Pitch.DisplacementVariables.Variance = var(Thorax.Pitch.Displacement);
        Thorax.Pitch.DisplacementVariables.RMS= rms(Thorax.Pitch.Displacement);
        if abs(Thorax.Pitch.DisplacementVariables.Min)>Thorax.Pitch.DisplacementVariables.Max
            Thorax.Pitch.DisplacementVariables.Direction = {'Down'};
        else
            Thorax.Pitch.DisplacementVariables.Direction = {'Up'};
        end
        
        Thorax.Pitch.VelocityVariables.Mean = mean(Thorax.Pitch.Velocity);
        Thorax.Pitch.VelocityVariables.Median = median(Thorax.Pitch.Velocity);
        Thorax.Pitch.VelocityVariables.Mode = mode(Thorax.Pitch.Velocity);
        [Thorax.Pitch.VelocityVariables.Min,Thorax.Pitch.VelocityVariables.MinTime] = min(Thorax.Pitch.Velocity);
        [Thorax.Pitch.VelocityVariables.Max,Thorax.Pitch.VelocityVariables.MaxTime] = max(Thorax.Pitch.Velocity);
        Thorax.Pitch.VelocityVariables.Range = Thorax.Pitch.VelocityVariables.Max-Thorax.Pitch.VelocityVariables.Min;
        Thorax.Pitch.VelocityVariables.SD = std(Thorax.Pitch.Velocity);
        Thorax.Pitch.VelocityVariables.SE = ste(Thorax.Pitch.Velocity);
        Thorax.Pitch.VelocityVariables.CI = ci(Thorax.Pitch.Velocity);
        Thorax.Pitch.VelocityVariables.CV = cv(Thorax.Pitch.Velocity);
        Thorax.Pitch.VelocityVariables.IQR = iqr(Thorax.Pitch.Velocity);
        Thorax.Pitch.VelocityVariables.Variance = var(Thorax.Pitch.Velocity);
        Thorax.Pitch.VelocityVariables.RMS = rms(Thorax.Pitch.Velocity);
        Thorax.Pitch.VelocityVariables.Oscillation = Thorax.Pitch.VelocityVariables.Max/Thorax.Pitch.VelocityVariables.Min;
        
        Thorax.Pitch.AccelerationVariables.Mean = mean(Thorax.Pitch.Acceleration);
        Thorax.Pitch.AccelerationVariables.Median = median(Thorax.Pitch.Acceleration);
        Thorax.Pitch.AccelerationVariables.Mode = mode(Thorax.Pitch.Acceleration);
        [Thorax.Pitch.AccelerationVariables.Min,Thorax.Pitch.AccelerationVariables.MinTime] = min(Thorax.Pitch.Acceleration);
        [Thorax.Pitch.AccelerationVariables.Max,Thorax.Pitch.AccelerationVariables.MaxTime] = max(Thorax.Pitch.Acceleration);
        Thorax.Pitch.AccelerationVariables.Range = Thorax.Pitch.AccelerationVariables.Max-Thorax.Pitch.AccelerationVariables.Min;
        Thorax.Pitch.AccelerationVariables.SD = std(Thorax.Pitch.Acceleration);
        Thorax.Pitch.AccelerationVariables.SE = ste(Thorax.Pitch.Acceleration);
        Thorax.Pitch.AccelerationVariables.CI = ci(Thorax.Pitch.Acceleration);
        Thorax.Pitch.AccelerationVariables.CV = cv(Thorax.Pitch.Acceleration);
        Thorax.Pitch.AccelerationVariables.IQR = iqr(Thorax.Pitch.Acceleration);
        Thorax.Pitch.AccelerationVariables.Variance = var(Thorax.Pitch.Acceleration);
        Thorax.Pitch.AccelerationVariables.RMS = rms(Thorax.Pitch.Acceleration);
        
        Thorax.Roll.DisplacementVariables.OnsetLatency_sec = nan;
        Thorax.Roll.DisplacementVariables.EndTime_sec = nan;
        Thorax.Roll.DisplacementVariables.Mean = mean(Thorax.Roll.Displacement);
        Thorax.Roll.DisplacementVariables.Median = median(Thorax.Roll.Displacement);
        Thorax.Roll.DisplacementVariables.Mode = mode(Thorax.Roll.Displacement);
        [Thorax.Roll.DisplacementVariables.Min,Thorax.Roll.DisplacementVariables.MinTime] = min(Thorax.Roll.Displacement);
        [Thorax.Roll.DisplacementVariables.Max,Thorax.Roll.DisplacementVariables.MaxTime] = max(Thorax.Roll.Displacement);
        Thorax.Roll.DisplacementVariables.Range = Thorax.Roll.DisplacementVariables.Max-Thorax.Roll.DisplacementVariables.Min;
        Thorax.Roll.DisplacementVariables.SD = std(Thorax.Roll.Displacement);
        Thorax.Roll.DisplacementVariables.SE = ste(Thorax.Roll.Displacement);
        Thorax.Roll.DisplacementVariables.CI = ci(Thorax.Roll.Displacement);
        Thorax.Roll.DisplacementVariables.CV = cv(Thorax.Roll.Displacement);
        Thorax.Roll.DisplacementVariables.IQR = iqr(Thorax.Roll.Displacement);
        Thorax.Roll.DisplacementVariables.Variance = var(Thorax.Roll.Displacement);
        Thorax.Roll.DisplacementVariables.RMS = rms(Thorax.Roll.Displacement);
        if abs(Thorax.Roll.DisplacementVariables.Min)>Thorax.Roll.DisplacementVariables.Max
            Thorax.Roll.DisplacementVariables.Direction = {'Left'};
        else
            Thorax.Roll.DisplacementVariables.Direction = {'Right'};
        end
        
        Thorax.Roll.VelocityVariables.Mean = mean(Thorax.Roll.Velocity);
        Thorax.Roll.VelocityVariables.Median = median(Thorax.Roll.Velocity);
        Thorax.Roll.VelocityVariables.Mode = mode(Thorax.Roll.Velocity);
        [Thorax.Roll.VelocityVariables.Min,Thorax.Roll.VelocityVariables.MinTime] = min(Thorax.Roll.Velocity);
        [Thorax.Roll.VelocityVariables.Max,Thorax.Roll.VelocityVariables.MaxTime] = max(Thorax.Roll.Velocity);
        Thorax.Roll.VelocityVariables.Range = Thorax.Roll.VelocityVariables.Max-Thorax.Roll.VelocityVariables.Min;
        Thorax.Roll.VelocityVariables.SD = std(Thorax.Roll.Velocity);
        Thorax.Roll.VelocityVariables.SE = ste(Thorax.Roll.Velocity);
        Thorax.Roll.VelocityVariables.CI = ci(Thorax.Roll.Velocity);
        Thorax.Roll.VelocityVariables.CV = cv(Thorax.Roll.Velocity);
        Thorax.Roll.VelocityVariables.IQR = iqr(Thorax.Roll.Velocity);
        Thorax.Roll.VelocityVariables.Variance = var(Thorax.Roll.Velocity);
        Thorax.Roll.VelocityVariables.RMS = rms(Thorax.Roll.Velocity);
        Thorax.Roll.VelocityVariables.Oscillation = Thorax.Roll.VelocityVariables.Max/Thorax.Roll.VelocityVariables.Min;
        
        Thorax.Roll.AccelerationVariables.Mean = mean(Thorax.Roll.Acceleration);
        Thorax.Roll.AccelerationVariables.Median = median(Thorax.Roll.Acceleration);
        Thorax.Roll.AccelerationVariables.Mode = mode(Thorax.Roll.Acceleration);
        [Thorax.Roll.AccelerationVariables.Min,Thorax.Roll.AccelerationVariables.MinTime] = min(Thorax.Roll.Acceleration);
        [Thorax.Roll.AccelerationVariables.Max,Thorax.Roll.AccelerationVariables.MaxTime] = max(Thorax.Roll.Acceleration);
        Thorax.Roll.AccelerationVariables.Range = Thorax.Roll.AccelerationVariables.Max-Thorax.Roll.AccelerationVariables.Min;
        Thorax.Roll.AccelerationVariables.SD = std(Thorax.Roll.Acceleration);
        Thorax.Roll.AccelerationVariables.SE = ste(Thorax.Roll.Acceleration);
        Thorax.Roll.AccelerationVariables.CI = ci(Thorax.Roll.Acceleration);
        Thorax.Roll.AccelerationVariables.CV = cv(Thorax.Roll.Acceleration);
        Thorax.Roll.AccelerationVariables.IQR = iqr(Thorax.Roll.Acceleration);
        Thorax.Roll.AccelerationVariables.Variance = var(Thorax.Roll.Acceleration);
        Thorax.Roll.AccelerationVariables.RMS = rms(Thorax.Roll.Acceleration);
        
        Thorax.Yaw.DisplacementVariables.Mean = mean(Thorax.Yaw.Displacement);
        Thorax.Yaw.DisplacementVariables.Median = median(Thorax.Yaw.Displacement);
        Thorax.Yaw.DisplacementVariables.Mode = mode(Thorax.Yaw.Displacement);
        [Thorax.Yaw.DisplacementVariables.Min,Thorax.Yaw.DisplacementVariables.MinTime] = min(Thorax.Yaw.Displacement);
        [Thorax.Yaw.DisplacementVariables.Max,Thorax.Yaw.DisplacementVariables.MaxTime] = max(Thorax.Yaw.Displacement);
        Thorax.Yaw.DisplacementVariables.Range = Thorax.Yaw.DisplacementVariables.Max-Thorax.Yaw.DisplacementVariables.Min;
        Thorax.Yaw.DisplacementVariables.SD = std(Thorax.Yaw.Displacement);
        Thorax.Yaw.DisplacementVariables.SE = ste(Thorax.Yaw.Displacement);
        Thorax.Yaw.DisplacementVariables.CI = ci(Thorax.Yaw.Displacement);
        Thorax.Yaw.DisplacementVariables.CV = cv(Thorax.Yaw.Displacement);
        Thorax.Yaw.DisplacementVariables.IQR = iqr(Thorax.Yaw.Displacement);
        Thorax.Yaw.DisplacementVariables.Variance = var(Thorax.Yaw.Displacement);
        Thorax.Yaw.DisplacementVariables.RMS = rms(Thorax.Yaw.Displacement);
        Thorax.Yaw.DisplacementVariables.Direction = TrialCondition(1,1);
        
        Thorax.Yaw.VelocityVariables.Mean = mean(Thorax.Yaw.Velocity);
        Thorax.Yaw.VelocityVariables.Median = median(Thorax.Yaw.Velocity);
        Thorax.Yaw.VelocityVariables.Mode = mode(Thorax.Yaw.Velocity);
        [Thorax.Yaw.VelocityVariables.Min,Thorax.Yaw.VelocityVariables.MinTime] = min(Thorax.Yaw.Velocity);
        [Thorax.Yaw.VelocityVariables.Max,Thorax.Yaw.VelocityVariables.MaxTime] = max(Thorax.Yaw.Velocity);
        Thorax.Yaw.VelocityVariables.Range = Thorax.Yaw.VelocityVariables.Max-Thorax.Yaw.VelocityVariables.Min;
        Thorax.Yaw.VelocityVariables.SD = std(Thorax.Yaw.Velocity);
        Thorax.Yaw.VelocityVariables.SE = ste(Thorax.Yaw.Velocity);
        Thorax.Yaw.VelocityVariables.CI = ci(Thorax.Yaw.Velocity);
        Thorax.Yaw.VelocityVariables.CV = cv(Thorax.Yaw.Velocity);
        Thorax.Yaw.VelocityVariables.IQR = iqr(Thorax.Yaw.Velocity);
        Thorax.Yaw.VelocityVariables.Variance = var(Thorax.Yaw.Velocity);
        Thorax.Yaw.VelocityVariables.RMS = rms(Thorax.Yaw.Velocity);
        Thorax.Yaw.VelocityVariables.Oscillation = Thorax.Yaw.VelocityVariables.Max/Thorax.Yaw.VelocityVariables.Min;
        
        Thorax.Yaw.AccelerationVariables.Mean = mean(Thorax.Yaw.Acceleration);
        Thorax.Yaw.AccelerationVariables.Median = median(Thorax.Yaw.Acceleration);
        Thorax.Yaw.AccelerationVariables.Mode = mode(Thorax.Yaw.Acceleration);
        [Thorax.Yaw.AccelerationVariables.Min,Thorax.Yaw.AccelerationVariables.MinTime] = min(Thorax.Yaw.Acceleration);
        [Thorax.Yaw.AccelerationVariables.Max,Thorax.Yaw.AccelerationVariables.MaxTime] = max(Thorax.Yaw.Acceleration);
        Thorax.Yaw.AccelerationVariables.Range = Thorax.Yaw.AccelerationVariables.Max-Thorax.Yaw.AccelerationVariables.Min;
        Thorax.Yaw.AccelerationVariables.SD = std(Thorax.Yaw.Acceleration);
        Thorax.Yaw.AccelerationVariables.SE = ste(Thorax.Yaw.Acceleration);
        Thorax.Yaw.AccelerationVariables.CI = ci(Thorax.Yaw.Acceleration);
        Thorax.Yaw.AccelerationVariables.CV = cv(Thorax.Yaw.Acceleration);
        Thorax.Yaw.AccelerationVariables.IQR = iqr(Thorax.Yaw.Acceleration);
        Thorax.Yaw.AccelerationVariables.Variance = var(Thorax.Yaw.Acceleration);
        Thorax.Yaw.AccelerationVariables.RMS = rms(Thorax.Yaw.Acceleration);
        
        Pelvis.Pitch.DisplacementVariables.OnsetLatency_sec = nan;
        Pelvis.Pitch.DisplacementVariables.EndTime_sec = nan;
        Pelvis.Pitch.DisplacementVariables.Mean = mean(Pelvis.Pitch.Displacement);
        Pelvis.Pitch.DisplacementVariables.Median = median(Pelvis.Pitch.Displacement);
        Pelvis.Pitch.DisplacementVariables.Mode = mode(Pelvis.Pitch.Displacement);
        [Pelvis.Pitch.DisplacementVariables.Min,Pelvis.Pitch.DisplacementVariables.MinTime] = min(Pelvis.Pitch.Displacement);
        [Pelvis.Pitch.DisplacementVariables.Max,Pelvis.Pitch.DisplacementVariables.MaxTime] = max(Pelvis.Pitch.Displacement);
        Pelvis.Pitch.DisplacementVariables.Range = Pelvis.Pitch.DisplacementVariables.Max-Pelvis.Pitch.DisplacementVariables.Min;
        Pelvis.Pitch.DisplacementVariables.SD = std(Pelvis.Pitch.Displacement);
        Pelvis.Pitch.DisplacementVariables.SE = ste(Pelvis.Pitch.Displacement);
        Pelvis.Pitch.DisplacementVariables.CI = ci(Pelvis.Pitch.Displacement);
        Pelvis.Pitch.DisplacementVariables.CV = cv(Pelvis.Pitch.Displacement);
        Pelvis.Pitch.DisplacementVariables.IQR = iqr(Pelvis.Pitch.Displacement);
        Pelvis.Pitch.DisplacementVariables.Variance = var(Pelvis.Pitch.Displacement);
        Pelvis.Pitch.DisplacementVariables.RMS= rms(Pelvis.Pitch.Displacement);
        if abs(Pelvis.Pitch.DisplacementVariables.Min)>Pelvis.Pitch.DisplacementVariables.Max
            Pelvis.Pitch.DisplacementVariables.Direction = {'Down'};
        else
            Pelvis.Pitch.DisplacementVariables.Direction = {'Up'};
        end
        
        Pelvis.Pitch.VelocityVariables.Mean = mean(Pelvis.Pitch.Velocity);
        Pelvis.Pitch.VelocityVariables.Median = median(Pelvis.Pitch.Velocity);
        Pelvis.Pitch.VelocityVariables.Mode = mode(Pelvis.Pitch.Velocity);
        [Pelvis.Pitch.VelocityVariables.Min,Pelvis.Pitch.VelocityVariables.MinTime] = min(Pelvis.Pitch.Velocity);
        [Pelvis.Pitch.VelocityVariables.Max,Pelvis.Pitch.VelocityVariables.MaxTime] = max(Pelvis.Pitch.Velocity);
        Pelvis.Pitch.VelocityVariables.Range = Pelvis.Pitch.VelocityVariables.Max-Pelvis.Pitch.VelocityVariables.Min;
        Pelvis.Pitch.VelocityVariables.SD = std(Pelvis.Pitch.Velocity);
        Pelvis.Pitch.VelocityVariables.SE = ste(Pelvis.Pitch.Velocity);
        Pelvis.Pitch.VelocityVariables.CI = ci(Pelvis.Pitch.Velocity);
        Pelvis.Pitch.VelocityVariables.CV = cv(Pelvis.Pitch.Velocity);
        Pelvis.Pitch.VelocityVariables.IQR = iqr(Pelvis.Pitch.Velocity);
        Pelvis.Pitch.VelocityVariables.Variance = var(Pelvis.Pitch.Velocity);
        Pelvis.Pitch.VelocityVariables.RMS = rms(Pelvis.Pitch.Velocity);
        Pelvis.Pitch.VelocityVariables.Oscillation = Pelvis.Pitch.VelocityVariables.Max/Pelvis.Pitch.VelocityVariables.Min;
        
        Pelvis.Pitch.AccelerationVariables.Mean = mean(Pelvis.Pitch.Acceleration);
        Pelvis.Pitch.AccelerationVariables.Median = median(Pelvis.Pitch.Acceleration);
        Pelvis.Pitch.AccelerationVariables.Mode = mode(Pelvis.Pitch.Acceleration);
        [Pelvis.Pitch.AccelerationVariables.Min,Pelvis.Pitch.AccelerationVariables.MinTime] = min(Pelvis.Pitch.Acceleration);
        [Pelvis.Pitch.AccelerationVariables.Max,Pelvis.Pitch.AccelerationVariables.MaxTime] = max(Pelvis.Pitch.Acceleration);
        Pelvis.Pitch.AccelerationVariables.Range = Pelvis.Pitch.AccelerationVariables.Max-Pelvis.Pitch.AccelerationVariables.Min;
        Pelvis.Pitch.AccelerationVariables.SD = std(Pelvis.Pitch.Acceleration);
        Pelvis.Pitch.AccelerationVariables.SE = ste(Pelvis.Pitch.Acceleration);
        Pelvis.Pitch.AccelerationVariables.CI = ci(Pelvis.Pitch.Acceleration);
        Pelvis.Pitch.AccelerationVariables.CV = cv(Pelvis.Pitch.Acceleration);
        Pelvis.Pitch.AccelerationVariables.IQR = iqr(Pelvis.Pitch.Acceleration);
        Pelvis.Pitch.AccelerationVariables.Variance = var(Pelvis.Pitch.Acceleration);
        Pelvis.Pitch.AccelerationVariables.RMS = rms(Pelvis.Pitch.Acceleration);
        
        Pelvis.Roll.DisplacementVariables.OnsetLatency_sec = nan;
        Pelvis.Roll.DisplacementVariables.EndTime_sec = nan;
        Pelvis.Roll.DisplacementVariables.Mean = mean(Pelvis.Roll.Displacement);
        Pelvis.Roll.DisplacementVariables.Median = median(Pelvis.Roll.Displacement);
        Pelvis.Roll.DisplacementVariables.Mode = mode(Pelvis.Roll.Displacement);
        [Pelvis.Roll.DisplacementVariables.Min,Pelvis.Roll.DisplacementVariables.MinTime] = min(Pelvis.Roll.Displacement);
        [Pelvis.Roll.DisplacementVariables.Max,Pelvis.Roll.DisplacementVariables.MaxTime] = max(Pelvis.Roll.Displacement);
        Pelvis.Roll.DisplacementVariables.Range = Pelvis.Roll.DisplacementVariables.Max-Pelvis.Roll.DisplacementVariables.Min;
        Pelvis.Roll.DisplacementVariables.SD = std(Pelvis.Roll.Displacement);
        Pelvis.Roll.DisplacementVariables.SE = ste(Pelvis.Roll.Displacement);
        Pelvis.Roll.DisplacementVariables.CI = ci(Pelvis.Roll.Displacement);
        Pelvis.Roll.DisplacementVariables.CV = cv(Pelvis.Roll.Displacement);
        Pelvis.Roll.DisplacementVariables.IQR = iqr(Pelvis.Roll.Displacement);
        Pelvis.Roll.DisplacementVariables.Variance = var(Pelvis.Roll.Displacement);
        Pelvis.Roll.DisplacementVariables.RMS = rms(Pelvis.Roll.Displacement);
        if abs(Pelvis.Roll.DisplacementVariables.Min)>Pelvis.Roll.DisplacementVariables.Max
            Pelvis.Roll.DisplacementVariables.Direction = {'Left'};
        else
            Pelvis.Roll.DisplacementVariables.Direction = {'Right'};
        end
        
        Pelvis.Roll.VelocityVariables.Mean = mean(Pelvis.Roll.Velocity);
        Pelvis.Roll.VelocityVariables.Median = median(Pelvis.Roll.Velocity);
        Pelvis.Roll.VelocityVariables.Mode = mode(Pelvis.Roll.Velocity);
        [Pelvis.Roll.VelocityVariables.Min,Pelvis.Roll.VelocityVariables.MinTime] = min(Pelvis.Roll.Velocity);
        [Pelvis.Roll.VelocityVariables.Max,Pelvis.Roll.VelocityVariables.MaxTime] = max(Pelvis.Roll.Velocity);
        Pelvis.Roll.VelocityVariables.Range = Pelvis.Roll.VelocityVariables.Max-Pelvis.Roll.VelocityVariables.Min;
        Pelvis.Roll.VelocityVariables.SD = std(Pelvis.Roll.Velocity);
        Pelvis.Roll.VelocityVariables.SE = ste(Pelvis.Roll.Velocity);
        Pelvis.Roll.VelocityVariables.CI = ci(Pelvis.Roll.Velocity);
        Pelvis.Roll.VelocityVariables.CV = cv(Pelvis.Roll.Velocity);
        Pelvis.Roll.VelocityVariables.IQR = iqr(Pelvis.Roll.Velocity);
        Pelvis.Roll.VelocityVariables.Variance = var(Pelvis.Roll.Velocity);
        Pelvis.Roll.VelocityVariables.RMS = rms(Pelvis.Roll.Velocity);
        Pelvis.Roll.VelocityVariables.Oscillation = Pelvis.Roll.VelocityVariables.Max/Pelvis.Roll.VelocityVariables.Min;
        
        Pelvis.Roll.AccelerationVariables.Mean = mean(Pelvis.Roll.Acceleration);
        Pelvis.Roll.AccelerationVariables.Median = median(Pelvis.Roll.Acceleration);
        Pelvis.Roll.AccelerationVariables.Mode = mode(Pelvis.Roll.Acceleration);
        [Pelvis.Roll.AccelerationVariables.Min,Pelvis.Roll.AccelerationVariables.MinTime] = min(Pelvis.Roll.Acceleration);
        [Pelvis.Roll.AccelerationVariables.Max,Pelvis.Roll.AccelerationVariables.MaxTime] = max(Pelvis.Roll.Acceleration);
        Pelvis.Roll.AccelerationVariables.Range = Pelvis.Roll.AccelerationVariables.Max-Pelvis.Roll.AccelerationVariables.Min;
        Pelvis.Roll.AccelerationVariables.SD = std(Pelvis.Roll.Acceleration);
        Pelvis.Roll.AccelerationVariables.SE = ste(Pelvis.Roll.Acceleration);
        Pelvis.Roll.AccelerationVariables.CI = ci(Pelvis.Roll.Acceleration);
        Pelvis.Roll.AccelerationVariables.CV = cv(Pelvis.Roll.Acceleration);
        Pelvis.Roll.AccelerationVariables.IQR = iqr(Pelvis.Roll.Acceleration);
        Pelvis.Roll.AccelerationVariables.Variance = var(Pelvis.Roll.Acceleration);
        Pelvis.Roll.AccelerationVariables.RMS = rms(Pelvis.Roll.Acceleration);
        
        Pelvis.Yaw.DisplacementVariables.Mean = mean(Pelvis.Yaw.Displacement);
        Pelvis.Yaw.DisplacementVariables.Median = median(Pelvis.Yaw.Displacement);
        Pelvis.Yaw.DisplacementVariables.Mode = mode(Pelvis.Yaw.Displacement);
        [Pelvis.Yaw.DisplacementVariables.Min,Pelvis.Yaw.DisplacementVariables.MinTime] = min(Pelvis.Yaw.Displacement);
        [Pelvis.Yaw.DisplacementVariables.Max,Pelvis.Yaw.DisplacementVariables.MaxTime] = max(Pelvis.Yaw.Displacement);
        Pelvis.Yaw.DisplacementVariables.Range = Pelvis.Yaw.DisplacementVariables.Max-Pelvis.Yaw.DisplacementVariables.Min;
        Pelvis.Yaw.DisplacementVariables.SD = std(Pelvis.Yaw.Displacement);
        Pelvis.Yaw.DisplacementVariables.SE = ste(Pelvis.Yaw.Displacement);
        Pelvis.Yaw.DisplacementVariables.CI = ci(Pelvis.Yaw.Displacement);
        Pelvis.Yaw.DisplacementVariables.CV = cv(Pelvis.Yaw.Displacement);
        Pelvis.Yaw.DisplacementVariables.IQR = iqr(Pelvis.Yaw.Displacement);
        Pelvis.Yaw.DisplacementVariables.Variance = var(Pelvis.Yaw.Displacement);
        Pelvis.Yaw.DisplacementVariables.RMS = rms(Pelvis.Yaw.Displacement);
        Pelvis.Yaw.DisplacementVariables.Direction = TrialCondition(1,1);
        
        Pelvis.Yaw.VelocityVariables.Mean = mean(Pelvis.Yaw.Velocity);
        Pelvis.Yaw.VelocityVariables.Median = median(Pelvis.Yaw.Velocity);
        Pelvis.Yaw.VelocityVariables.Mode = mode(Pelvis.Yaw.Velocity);
        [Pelvis.Yaw.VelocityVariables.Min,Pelvis.Yaw.VelocityVariables.MinTime] = min(Pelvis.Yaw.Velocity);
        [Pelvis.Yaw.VelocityVariables.Max,Pelvis.Yaw.VelocityVariables.MaxTime] = max(Pelvis.Yaw.Velocity);
        Pelvis.Yaw.VelocityVariables.Range = Pelvis.Yaw.VelocityVariables.Max-Pelvis.Yaw.VelocityVariables.Min;
        Pelvis.Yaw.VelocityVariables.SD = std(Pelvis.Yaw.Velocity);
        Pelvis.Yaw.VelocityVariables.SE = ste(Pelvis.Yaw.Velocity);
        Pelvis.Yaw.VelocityVariables.CI = ci(Pelvis.Yaw.Velocity);
        Pelvis.Yaw.VelocityVariables.CV = cv(Pelvis.Yaw.Velocity);
        Pelvis.Yaw.VelocityVariables.IQR = iqr(Pelvis.Yaw.Velocity);
        Pelvis.Yaw.VelocityVariables.Variance = var(Pelvis.Yaw.Velocity);
        Pelvis.Yaw.VelocityVariables.RMS = rms(Pelvis.Yaw.Velocity);
        Pelvis.Yaw.VelocityVariables.Oscillation = Pelvis.Yaw.VelocityVariables.Max/Pelvis.Yaw.VelocityVariables.Min;
        
        Pelvis.Yaw.AccelerationVariables.Mean = mean(Pelvis.Yaw.Acceleration);
        Pelvis.Yaw.AccelerationVariables.Median = median(Pelvis.Yaw.Acceleration);
        Pelvis.Yaw.AccelerationVariables.Mode = mode(Pelvis.Yaw.Acceleration);
        [Pelvis.Yaw.AccelerationVariables.Min,Pelvis.Yaw.AccelerationVariables.MinTime] = min(Pelvis.Yaw.Acceleration);
        [Pelvis.Yaw.AccelerationVariables.Max,Pelvis.Yaw.AccelerationVariables.MaxTime] = max(Pelvis.Yaw.Acceleration);
        Pelvis.Yaw.AccelerationVariables.Range = Pelvis.Yaw.AccelerationVariables.Max-Pelvis.Yaw.AccelerationVariables.Min;
        Pelvis.Yaw.AccelerationVariables.SD = std(Pelvis.Yaw.Acceleration);
        Pelvis.Yaw.AccelerationVariables.SE = ste(Pelvis.Yaw.Acceleration);
        Pelvis.Yaw.AccelerationVariables.CI = ci(Pelvis.Yaw.Acceleration);
        Pelvis.Yaw.AccelerationVariables.CV = cv(Pelvis.Yaw.Acceleration);
        Pelvis.Yaw.AccelerationVariables.IQR = iqr(Pelvis.Yaw.Acceleration);
        Pelvis.Yaw.AccelerationVariables.Variance = var(Pelvis.Yaw.Acceleration);
        Pelvis.Yaw.AccelerationVariables.RMS = rms(Pelvis.Yaw.Acceleration);
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
    Dependent_Variables
else
    beep
    clr
    disp('Dependent Variables script complete');
    Question = input('Would you like to continue analysing?\n(0)No\n(1)Yes\n');
    if Question==1
        clr
        Turning_Analysis
    else
        clr
    end
end