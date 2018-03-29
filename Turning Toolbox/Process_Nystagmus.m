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
clc
for TrialNum =TS:NumTrials;
    if TrialNum<=10
        CalNum = 1;
    elseif TrialNum>10
        Remainder = rem(TrialNum,10);
        if Remainder == 0;
            CalNum = TrialNum/10;
        elseif Remainder>0;
            CalNum = floor(TrialNum/10)+1;
        end
    end
    load('ParticipantID');
    load('ExpInfo');
    load(char(strcat(ExpName,{' '},ParticipantID,{' Cal '},num2str(CalNum),'.mat')));
    TF = strcmp(TrialCondition,'Dummy Trial');
    if TF == 1;
        load(char(strcat(ExpName,{' '},ParticipantID,{' Cal '},num2str(CalNum+1),'.mat')));
    end
    if TrialNum<=9
        load(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
    elseif TrialNum>9
        load(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
    end
    
    TF = strcmp(TrialCondition,'Dummy Trial');
    
    if TF == 0;
        
        %Apply fit variables to raw eog data to convert from mV to degrees
        %Filter calibrated eog data
        %set start to zero
        clearvars -except BlockNum EOG ExpName FilteredData fit Head LED LeftFoot NormalizedData ParticipantID Pelvis RawData RightFoot SteppingData Thorax TrialCondition TrialNum
        
        EOG.Calibrated = RawData.EOG*abs(fit(1,1))+fit(1,2);
        [b,a] = butter(2,10/500,'low');
        [d,c] = butter(2,30/500,'low');
        [f,e] = butter(2,20/500,'low');
        [h,g] = butter(2,25/500,'low');
        EOG.Displacement.Filt10 = filtfilt(b,a,EOG.Calibrated );
        EOG.Displacement.Filt30 = filtfilt(d,c,EOG.Calibrated );
        EOG.Displacement.Filt20 = filtfilt(f,e,EOG.Calibrated );
        EOG.Displacement.Filt25 = filtfilt(h,g,EOG.Calibrated );
        EOG.Displacement.Filt10 = EOG.Displacement.Filt10-EOG.Displacement.Filt10(1,1);
        EOG.Displacement.Filt30 = EOG.Displacement.Filt30-EOG.Displacement.Filt30(1,1);
        EOG.Displacement.Filt25 = EOG.Displacement.Filt25-EOG.Displacement.Filt25(1,1);
        EOG.Displacement.Filt20 = EOG.Displacement.Filt20-EOG.Displacement.Filt20(1,1);
        
        %Isolate vestibular nystagmus portion of eye movement
        %Eliminate saccade/fixation combinations
        
        scrsz = get(0,'ScreenSize');
        figure('Position',scrsz);
        Title = 'Pick nystagmus portion of movement';
        plot(EOG.Displacement.Filt30);
        title(Title);
        disp('Pick a point prior to the nystagmus');
        [X1,Y1] = ginput(1);
        clc
        disp('Pick a point after the nystagmus');
        [X2,Y2] = ginput(1);
        clc
        EOG.Processing.Start = round(X1);
        EOG.Processing.End = round(X2);
        close all
        
        %Differentiate eog data into velocity and acceleration
        %subsample for comparison with kinematic data
        
        EOG.Velocity.Filt10 = (diff(EOG.Displacement.Filt10))*1000;
        EOG.Velocity.Filt30 = (diff(EOG.Displacement.Filt30))*1000;
        EOG.Velocity.Filt20 = (diff(EOG.Displacement.Filt20))*1000;
        EOG.Velocity.Filt25 = (diff(EOG.Displacement.Filt25))*1000;
        EOG.Acceleration.Filt10 = (diff(EOG.Velocity.Filt10))*1000;
        EOG.Acceleration.Filt30 = (diff(EOG.Velocity.Filt30))*1000;
        EOG.Acceleration.Filt20 = (diff(EOG.Velocity.Filt20))*1000;
        EOG.Acceleration.Filt25 = (diff(EOG.Velocity.Filt25))*1000;
        EOG.Subsampled.Displacement.Filt10 = EOG.Displacement.Filt10(1:5:end,:);
        EOG.Subsampled.Displacement.Filt30 = EOG.Displacement.Filt30(1:5:end,:);
        EOG.Subsampled.Displacement.Filt20 = EOG.Displacement.Filt20(1:5:end,:);
        EOG.Subsampled.Displacement.Filt25 = EOG.Displacement.Filt25(1:5:end,:);
        EOG.Subsampled.Velocity.Filt10 = (diff(EOG.Subsampled.Displacement.Filt10))*200;
        EOG.Subsampled.Velocity.Filt30 = (diff(EOG.Subsampled.Displacement.Filt30))*200;
        EOG.Subsampled.Velocity.Filt20 = (diff(EOG.Subsampled.Displacement.Filt20))*200;
        EOG.Subsampled.Velocity.Filt25 = (diff(EOG.Subsampled.Displacement.Filt20))*200;
        EOG.Subsampled.Acceleration.Filt10 = (diff(EOG.Subsampled.Velocity.Filt10))*200;
        EOG.Subsampled.Acceleration.Filt30 = (diff(EOG.Subsampled.Velocity.Filt30))*200;
        EOG.Subsampled.Acceleration.Filt20 = (diff(EOG.Subsampled.Velocity.Filt20))*200;
        EOG.Subsampled.Acceleration.Filt25 = (diff(EOG.Subsampled.Velocity.Filt25))*200;
        
        %set the processing 'end time' to reflect either the end of head movement or the input end point
        
        if EOG.Processing.End>Head.Yaw.DisplacementVariables.EndTime_ms
            EOG.Processing.End=Head.Yaw.DisplacementVariables.EndTime_ms;
        end
        
        %finds all peaks during nystagmus portion of movement
        %finds the time of all peaks during nystagmus portion of movement
        
        PositiveZeroCrossing = 0;
        
        for N = EOG.Processing.Start:EOG.Processing.End;
            if EOG.Velocity.Filt10(N-1)<0 && EOG.Velocity.Filt10(N)>=0
                PositiveZeroCrossing = PositiveZeroCrossing+1;
                PositiveZeroCrossingTimes(PositiveZeroCrossing) = N; %#ok<*SAGROW>
            end
            
        end
        
        %finds all troughs for nystagmus portion of movement
        
        NegativeZeroCrossing = 0;
        
        for N = EOG.Processing.Start:EOG.Processing.End;
            if EOG.Velocity.Filt10(N-1)>=0 && EOG.Velocity.Filt10(N)<0
                NegativeZeroCrossing = NegativeZeroCrossing+1;
                NegativeZeroCrossingTimes(NegativeZeroCrossing) = N;
            end
            
        end
        
        PositiveZeroCrossingTimes = PositiveZeroCrossingTimes';
        NegativeZeroCrossingTimes = NegativeZeroCrossingTimes';
        
        EOG.Processing.Time = EOG.Displacement.Filt30(EOG.Processing.Start:EOG.Processing.End);
        PositiveEyePosition = find(EOG.Processing.Time>0);
        FastPhases.GazeLeadingTime = (length(PositiveEyePosition)/length(EOG.Processing.Time))*100; %#ok<*STRNU>
        
        %Determines the order of the peaks and troughs
        %Puts peak times and trough times together for comparison
        %Troughs are in column 1 and peaks in column 2
        
        Start = 1;
        
        if length(PositiveZeroCrossingTimes)==length(NegativeZeroCrossingTimes);
            if PositiveZeroCrossingTimes(1,1)<NegativeZeroCrossingTimes; %#ok<*BDSCI>
                Times(:,1) = PositiveZeroCrossingTimes;
                Times(:,2) = NegativeZeroCrossingTimes;
            else
                Times(:,1) = NegativeZeroCrossingTimes;
                Times(:,2) = PositiveZeroCrossingTimes;
            end
        else
            if PositiveZeroCrossingTimes(1,1)>NegativeZeroCrossingTimes(1,1)
                PositiveZeroCrossingTimes = vertcat(Start,PositiveZeroCrossingTimes); %#ok<*AGROW>
            else
                NegativeZeroCrossingTimes = vertcat(Start,NegativeZeroCrossingTimes);
            end
            if PositiveZeroCrossingTimes(1,1)==1;
                Times(:,1) = PositiveZeroCrossingTimes;
                Times(:,2) = NegativeZeroCrossingTimes;
            else
                Times(:,1) = NegativeZeroCrossingTimes;
                Times(:,2) = PositiveZeroCrossingTimes;
            end
        end
        
        %finds the time between a peak and the following trough
        
        BetweenTimes = Times((2:end),1);
        BetweenTimes = vertcat(BetweenTimes,EOG.Processing.End);
        Times(:,3) = BetweenTimes;
        clearvars BetweenTimes
        BetweenTimes = Times((2:end),2);BetweenTimes = vertcat(BetweenTimes,EOG.Processing.End+100);
        Times(:,4) = BetweenTimes;
        
        [r,c] = size(Times); %#ok<*ASGLU,*NASGU>
        
        for j = 1:r;
            Negative_to_Positive(j,1) = EOG.Displacement.Filt30(Times(j,2))-EOG.Displacement.Filt30(Times(j,1));
            Negative_to_Positive(j,2) = EOG.Displacement.Filt30(Times(j,3))-EOG.Displacement.Filt30(Times(j,2));
        end
        
        %determines which set of times represents fast movements and which represents slow
        %movement
        %determines beginning and end times for fast and slow movements
        
        if sum(Negative_to_Positive(:,1))>0;
            FastComponent = Negative_to_Positive(:,1);
            SlowComponent = Negative_to_Positive(:,2);
            FastTimes(:,1) = Times(:,1);
            FastTimes(:,2) = Times(:,2);
            SlowTimes(:,1) = Times(:,2);
            SlowTimes(:,2) = Times(:,3);
        else
            FastComponent = Negative_to_Positive(:,2);
            SlowComponent = Negative_to_Positive(:,1);
            FastTimes(:,1) = Times(:,2);
            FastTimes(:,2) = Times(:,3);
            SlowTimes(:,1) = Times(:,3);
            SlowTimes(:,2) = Times(:,4);
        end
        
        %determines the maximum velocity reached during each fast and slow
        %movement
        
        [r,c] = size(FastTimes);
        
        for j = 1:r;
            FastComponent_Vel(j,1) = max(EOG.Velocity.Filt30(FastTimes(j,1):FastTimes(j,2)));
            SlowComponent_Vel(j,1) = min(EOG.Velocity.Filt30(SlowTimes(j,1):SlowTimes(j,2)));
        end
        
        %tallies which fast movements are considered fast phases
        %uses a velocity threshold and an amplitude threshold
        
        FastPhases = struct;
        
        FastPhases.Total = 0;
        
        for N = 1:length(FastComponent_Vel);
            if FastComponent_Vel(N)>=30&& FastComponent(N)>=1.5;
                FastPhases.Total = FastPhases.Total+1;
                FastPhaseTimes(FastPhases.Total) = N;
            end
        end
        
        %determines the onset latency and end time of each fast phase
        if FastPhases.Total>0
            
            FastPhaseTimes = FastPhaseTimes';
            
            for j = 1:FastPhases.Total;
                Time(j,1) = FastTimes(FastPhaseTimes(j,1),1);
                Time(j,2) = FastTimes(FastPhaseTimes(j,1),2);
            end
            
            %might be able to get rid of this
            
            E = find(Time(:,1)>EOG.Processing.Start);
            PostProcessingStartTimes = Time(E(1,1):end,:);
            FastPhases.Total = length(E);
            clearvars Time
            Time = PostProcessingStartTimes;
            
            %determines onset latencies, end time, amplitude, velocities,
            %and accelerations for each individual fast phase
            %determines mean fast phase amplitude, velocity and
            %acceleration
            %determines peak fast phase amplitude, velocity and
            %acceleration
            
            for j = 1:FastPhases.Total;
                FastPhases.Onsets_ms(j,1) = Time(j,1);
                FastPhases.Onsets_sec(j,1) = FastPhases.Onsets_ms(j,1)/1000;
                FastPhases.Ends_ms(j,1) = Time(j,2);
                FastPhases.Ends_sec(j,1) = FastPhases.Ends_ms(j,1)/1000;
                FastPhases.Onset_Position(j,1) = EOG.Displacement.Filt30(FastPhases.Onsets_ms(j,1));
                FastPhases.End_Position(j,1) = EOG.Displacement.Filt30(FastPhases.Ends_ms(j,1));
                FastPhases.Amplitudes(j,1)  = EOG.Displacement.Filt30(Time(j,2))-EOG.Displacement.Filt30(Time(j,1));
                FastPhases.Velocities(j,1) = max(EOG.Velocity.Filt30(Time(j,1):Time(j,2)));
                FastPhases.Accelerations(j,1) = max(EOG.Acceleration.Filt30(Time(j,1):Time(j,2)));
                FastPhases.MaxAmp = max(FastPhases.Amplitudes);
                FastPhases.PeakVel = max(FastPhases.Velocities);
                FastPhases.PeakAcc = max(FastPhases.Accelerations);
                FastPhases.MeanAmp = mean(FastPhases.Amplitudes);
                FastPhases.SDAmp = std(FastPhases.Amplitudes);
                FastPhases.MeanVel = mean(FastPhases.Velocities);
                FastPhases.SDVel = std(FastPhases.Velocities);
                FastPhases.MeanAcc = mean(FastPhases.Accelerations);
                FastPhases.SDAcc = std(FastPhases.Accelerations);
            end
            
            %determines onset and end times for slow phases
            %determines amplitudes, velocities and accelerations for each
            %individual slow phase
            
            for j = 1:FastPhases.Total
                SlowPhases.Onsets_ms = FastPhases.Ends_ms;
                if FastPhases.Total>1
                    SlowPhases.Ends_ms = FastPhases.Onsets_ms(2:end,:);
                    SlowPhases.Ends_ms(FastPhases.Total,:) = EOG.Processing.End;
                else
                    SlowPhases.Ends_ms = EOG.Processing.End;
                end
            end
            
            for j = 1:FastPhases.Total;
                SlowPhases.Amplitudes(j,1) = EOG.Displacement.Filt30(SlowPhases.Onsets_ms(j,1))-EOG.Displacement.Filt30(SlowPhases.Ends_ms(j,1));
                SlowPhases.Velocities(j,1) = min(EOG.Velocity.Filt30(SlowPhases.Onsets_ms(j,1):SlowPhases.Ends_ms(j,1)));
                SlowPhases.Accelerations(j,1) = min(EOG.Acceleration.Filt30(SlowPhases.Onsets_ms(j,1):SlowPhases.Ends_ms(j,1)));
            end
        else
            Max = max(Negative_to_Positive);
            FastPhases.MaxAmp = max(Max);
            AllMovement = vertcat(Negative_to_Positive(:,1),Negative_to_Positive(:,2));
            AllMovement = abs(AllMovement);
            FastPhases.MeanAmp = mean(AllMovement);
            FastPhases.SDAmp = std(AllMovement);
            FastPhases.Onsets_ms = nan;
            FastPhases.Ends_ms = nan;
            FastPhases.Amplitudes = nan;
            FastPhases.Velocities = nan;
            FastPhases.Accelerations = nan;
            FastPhases.PeakVel = nan;
            FastPhases.SDVel = nan;
            FastPhases.PeakAcc = nan;
            FastPhases.SDAcc = nan;
        end
        
        FastPhases.NFPF = FastPhases.Total/((Head.Yaw.DisplacementVariables.EndTime_ms-FastPhases.Onsets_ms(1,1))/1000);
        
        clearvars -except BlockNum EOG ExpName FastPhases FilteredData Head LED LeftFoot NormalizedData ParticipantID Pelvis RawData RightFoot SlowPhases SteppingData Thorax TrialCondition TrialNum
        
        if TrialNum<=9
            save(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
        elseif TrialNum>9
            save(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
        end
        clear
    end
end

Question = input('Do have more trials to process?\n(0)No\n(1)Yes\n');
if Question==1;
    Process_Nystagmus
else
    beep
    clr
    disp('Process Nystagmus script complete');
    Question = input('Would you like to continue analysing?\n(0)No\n(1)Yes\n');
    if Question==1
        clr
        Turning_Analysis
    else
        clr
    end
end