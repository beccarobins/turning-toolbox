clear
Question = input('Process:\n(1)All trials\n(2)Multiple trials\n(3)One trial\n ');
if Question==1;
    TS = 1;
    load('ExpInfo');
elseif Question==2;
    TS = input('Which trial to start with?\n');
    NumTrials = input('Which trial to end with?\n');
elseif Question==3;
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
        
        %differentiate foot displacement data
        
        LeftFoot.Yaw.Velocity = 200*(diff(LeftFoot.Yaw.Displacement));
        RightFoot.Yaw.Velocity = 200*(diff(RightFoot.Yaw.Displacement));
        LeftFoot.Yaw.Acceleration = 200*(diff(LeftFoot.Yaw.Velocity));
        RightFoot.Yaw.Acceleration = 200*(diff(RightFoot.Yaw.Velocity));
        
        %find peaks in foot displacement
        
        PositiveZeroCrossings = 0;
        E = length(LeftFoot.Yaw.Velocity);
        T = E-2;
        
        for N = 2:T;
            if LeftFoot.Yaw.Velocity(N+1)>0 && LeftFoot.Yaw.Velocity(N)<=0;
                PositiveZeroCrossings = PositiveZeroCrossings+1;
                PositiveZeroCrossingTimes(PositiveZeroCrossings) = N; %#ok<*SAGROW>
            end
        end
        
        PositiveZeroCrossingTimes = PositiveZeroCrossingTimes';
        
        NegativeZeroCrossings = 0;
        
        for N = 2:T;
            if LeftFoot.Yaw.Velocity(N-1)>0 && LeftFoot.Yaw.Velocity(N)<=0;
                NegativeZeroCrossings = NegativeZeroCrossings+1;
                NegativeZeroCrossingTimes(NegativeZeroCrossings) = N;
            end
        end
        
        NegativeZeroCrossingTimes = NegativeZeroCrossingTimes';
        
        Start = 1;
        
        if length(PositiveZeroCrossingTimes)==length(NegativeZeroCrossingTimes);
            if PositiveZeroCrossingTimes(1,1)<NegativeZeroCrossingTimes(1,1);
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
        
        BetweenTimes = Times(:,2);
        
        BetweenTimes(:,2) = vertcat(Times((2:end),1),T);
        
        Times = vertcat(Times,BetweenTimes);
        Times = sort(Times);
        
        PeakVel = max(LeftFoot.Yaw.Velocity);
        Above_10 = .10*PeakVel;
        
        for j = 1:length(Times);
            MaxFootVel(j,1) = max(LeftFoot.Yaw.Velocity(Times(j,1):Times(j,2)));
        end
        
        A = find(MaxFootVel>=Above_10);
        B = .5*Above_10;
        
        NewTimes = Times(A);
        NewTimes(:,2) = Times(A,2);
        
        [LeftFoot.Steps.Total,c] = size(A); %#ok<*ASGLU,*NASGU>
        
        [r,c] = size(NewTimes);
        
        D = max(NewTimes(:,2)-NewTimes(:,1));
        
        StepOnsetTimes = nan(D,r);
        
        for j = 1:r;
            StepOnsets = 0;
            for N = NewTimes(j,1):NewTimes(j,2)
                if LeftFoot.Yaw.Displacement(N+1)>LeftFoot.Yaw.Displacement(N) && LeftFoot.Yaw.Velocity(N+1)>LeftFoot.Yaw.Velocity(N)&& LeftFoot.Yaw.Velocity(N)>=B;
                    StepOnsets = StepOnsets+1;
                    StepOnsetTimes(StepOnsets,j) = N;
                end
                LeftFoot.Steps.Onsets(j,1) = StepOnsetTimes(1,j);
            end
        end
        
        LeftFoot.Steps.Ends = NewTimes(:,2);
        
        for j = 1:LeftFoot.Steps.Total;
            LeftFoot.Steps.Onsets_sec(j,1) = (LeftFoot.Steps.Onsets(j,1)*5)/1000;
            LeftFoot.Steps.Ends_sec(j,1) = (LeftFoot.Steps.Ends(j,1)*5)/1000;
            LeftFoot.Steps.Duration_sec(j,1) = LeftFoot.Steps.Ends_sec(j,1)-LeftFoot.Steps.Onsets_sec(j,1);
            LeftFoot.Steps.Amplitude(j,1) = LeftFoot.Yaw.Displacement(LeftFoot.Steps.Ends(j,1));
            LeftFoot.Steps.Size(j,1) = LeftFoot.Yaw.Displacement(LeftFoot.Steps.Ends(j,1))-LeftFoot.Yaw.Displacement(LeftFoot.Steps.Onsets(j,1));
            LeftFoot.Steps.Velocity(j,1) =max(LeftFoot.Yaw.Velocity(LeftFoot.Steps.Onsets(j,1):LeftFoot.Steps.Ends(j,1)));
            LeftFoot.Steps.Acceleration(j,1) =max(LeftFoot.Yaw.Acceleration(LeftFoot.Steps.Onsets(j,1):LeftFoot.Steps.Ends(j,1)));
            LeftFoot.Steps.MaxAmp(j,1) = max(LeftFoot.Steps.Amplitude);
            LeftFoot.Steps.MaxVel(j,1) = max(LeftFoot.Steps.Velocity);
            LeftFoot.Steps.MaxAcc(j,1) = max(LeftFoot.Steps.Acceleration);
        end
        
        clearvars -except SteppingData EOG FastPhases FilteredData Head LED LeftFoot NormalizedData Participant Pelvis RawData RightFoot SlowPhases Thorax TrialCondition TrialNum
        
        PositiveZeroCrossings = 0;
        E = length(RightFoot.Yaw.Velocity);
        T = E-2;
        
        for N = 2:T;
            if RightFoot.Yaw.Velocity(N+1)>0 && RightFoot.Yaw.Velocity(N)<=0;
                PositiveZeroCrossings = PositiveZeroCrossings+1;
                PositiveZeroCrossingTimes(PositiveZeroCrossings) = N;
            end
        end
        
        PositiveZeroCrossingTimes = PositiveZeroCrossingTimes';
        
        NegativeZeroCrossings = 0;
        
        for N = 2:T;
            if RightFoot.Yaw.Velocity(N-1)>0 && RightFoot.Yaw.Velocity(N)<=0;
                NegativeZeroCrossings = NegativeZeroCrossings+1;
                NegativeZeroCrossingTimes(NegativeZeroCrossings) = N;
            end
        end
        
        NegativeZeroCrossingTimes = NegativeZeroCrossingTimes';
        
        Start = 1;
        
        if length(PositiveZeroCrossingTimes)==length(NegativeZeroCrossingTimes);
            if PositiveZeroCrossingTimes(1,1)<NegativeZeroCrossingTimes(1,1);
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
        
        BetweenTimes = Times(:,2);
        
        BetweenTimes(:,2) = vertcat(Times((2:end),1),T);
        
        Times = vertcat(Times,BetweenTimes);
        Times = sort(Times);
        
        PeakVel = max(RightFoot.Yaw.Velocity);
        Above_10 = .10*PeakVel;
        
        for j = 1:length(Times);
            MaxFootVel(j,1) = max(RightFoot.Yaw.Velocity(Times(j,1):Times(j,2)));
        end
        
        A = find(MaxFootVel>=Above_10);
        B = .5*Above_10;
        
        NewTimes = Times(A);
        NewTimes(:,2) = Times(A,2);
        
        [RightFoot.Steps.Total,c] = size(A); %#ok<*NASGU>
        
        [r,c] = size(NewTimes);
        
        D = max(NewTimes(:,2)-NewTimes(:,1));
        
        StepOnsetTimes = nan(D,r);
        
        for j = 1:r;
            StepOnsets = 0;
            for N = NewTimes(j,1):NewTimes(j,2)
                if RightFoot.Yaw.Displacement(N+1)>RightFoot.Yaw.Displacement(N) && RightFoot.Yaw.Velocity(N+1)>RightFoot.Yaw.Velocity(N)&& RightFoot.Yaw.Velocity(N)>=B;
                    StepOnsets = StepOnsets+1;
                    StepOnsetTimes(StepOnsets,j) = N;
                end
                RightFoot.Steps.Onsets(j,1) = StepOnsetTimes(1,j);
            end
        end
        
        RightFoot.Steps.Ends = NewTimes(:,2);
        
        for j = 1:RightFoot.Steps.Total;
            RightFoot.Steps.Onsets_sec(j,1) = (RightFoot.Steps.Onsets(j,1)*5)/1000;
            RightFoot.Steps.Ends_sec(j,1) = (RightFoot.Steps.Ends(j,1)*5)/1000;
            RightFoot.Steps.Duration_sec(j,1) = RightFoot.Steps.Ends_sec(j,1)-RightFoot.Steps.Onsets_sec(j,1);
            RightFoot.Steps.Amplitude(j,1) = RightFoot.Yaw.Displacement(RightFoot.Steps.Ends(j,1));
            RightFoot.Steps.Size(j,1) = RightFoot.Yaw.Displacement(RightFoot.Steps.Ends(j,1))-RightFoot.Yaw.Displacement(RightFoot.Steps.Onsets(j,1));
            RightFoot.Steps.Velocity(j,1) =max(RightFoot.Yaw.Velocity(RightFoot.Steps.Onsets(j,1):RightFoot.Steps.Ends(j,1)));
            RightFoot.Steps.Acceleration(j,1) =max(RightFoot.Yaw.Acceleration(RightFoot.Steps.Onsets(j,1):RightFoot.Steps.Ends(j,1)));
            RightFoot.Steps.MaxAmp(j,1) = max(RightFoot.Steps.Amplitude);
            RightFoot.Steps.MaxVel(j,1) = max(RightFoot.Steps.Velocity);
            RightFoot.Steps.MaxAcc(j,1) = max(RightFoot.Steps.Acceleration);
        end
        
        clearvars -except SteppingData EOG FastPhases FilteredData Head LED LeftFoot NormalizedData Participant Pelvis RawData RightFoot SlowPhases Thorax TrialCondition TrialNum
        
        SteppingData.Total = LeftFoot.Steps.Total+RightFoot.Steps.Total;
        
        for j = 1:LeftFoot.Steps.Total
            LeftSteps(j,1) = {'Left'};
        end
        
        LeftSteps = horzcat(LeftSteps,num2cell(LeftFoot.Steps.Onsets_sec));
        LeftSteps = horzcat(LeftSteps,num2cell(LeftFoot.Steps.Ends_sec));
        LeftSteps = horzcat(LeftSteps,num2cell(LeftFoot.Steps.Duration_sec));
        LeftSteps = horzcat(LeftSteps,num2cell(LeftFoot.Steps.Amplitude));
        LeftSteps = horzcat(LeftSteps,num2cell(LeftFoot.Steps.Size));
        LeftSteps = horzcat(LeftSteps,num2cell(LeftFoot.Steps.Velocity));
        LeftSteps = horzcat(LeftSteps,num2cell(LeftFoot.Steps.Acceleration));
        
        for j = 1:RightFoot.Steps.Total
            RightSteps(j,1) = {'Right'};
        end
        RightSteps = horzcat(RightSteps,num2cell(RightFoot.Steps.Onsets_sec));
        RightSteps = horzcat(RightSteps,num2cell(RightFoot.Steps.Ends_sec));
        RightSteps = horzcat(RightSteps,num2cell(RightFoot.Steps.Duration_sec));
        RightSteps = horzcat(RightSteps,num2cell(RightFoot.Steps.Amplitude));
        RightSteps = horzcat(RightSteps,num2cell(RightFoot.Steps.Size));
        RightSteps = horzcat(RightSteps,num2cell(RightFoot.Steps.Velocity));
        RightSteps = horzcat(RightSteps,num2cell(RightFoot.Steps.Acceleration));
        
        StackedSteps = vertcat(LeftSteps,RightSteps);
        SteppingData.SortedSteps = sortrows(StackedSteps,2);
        
        SteppingData.StepDuration = cell2mat(SteppingData.SortedSteps(end,3))-cell2mat(SteppingData.SortedSteps(1,2));
        SteppingData.SteppingFrequency = SteppingData.Total/SteppingData.StepDuration;
        
        TF = strcmp(SteppingData.SortedSteps(1,1),TrialCondition(1,1));
        
        if TF==1
            SteppingData.Strategy = {'Matched'};
            TF = strcmp(TrialCondition(1,1),'Left');
            if TF==1;
                SteppingData.LeadingFoot.Foot = {'Left'};
                SteppingData.LeadingFoot.OnsetLatency_sec = LeftFoot.Steps.Onsets_sec(1,1);
                SteppingData.LeadingFoot.Displacement = LeftFoot.Yaw.Displacement;
                SteppingData.TrailingFoot.Foot = {'Right'};
                SteppingData.TrailingFoot.OnsetLatency_sec = RightFoot.Steps.Onsets_sec(1,1);
                SteppingData.TrailingFoot.Displacement = RightFoot.Yaw.Displacement;
            else
                SteppingData.LeadingFoot.Foot = {'Right'};
                SteppingData.LeadingFoot.OnsetLatency_sec = RightFoot.Steps.Onsets_sec(1,1);
                SteppingData.LeadingFoot.Displacement = RightFoot.Yaw.Displacement;
                SteppingData.TrailingFoot.Foot = {'Left'};
                SteppingData.TrailingFoot.OnsetLatency_sec = LeftFoot.Steps.Onsets_sec(1,1);
                SteppingData.TrailingFoot.Displacement = LeftFoot.Yaw.Displacement;
            end
        else
            SteppingData.Strategy = {'Unmatched'};
            TF = strcmp(TrialCondition(1,1),'Left');
            if TF==1
                SteppingData.LeadingFoot.Foot = {'Right'};
                SteppingData.LeadingFoot.OnsetLatency_sec = RightFoot.Steps.Onsets_sec(1,1);
                SteppingData.LeadingFoot.Displacement = RightFoot.Yaw.Displacement;
                SteppingData.TrailingFoot.Foot = {'Left'};
                SteppingData.TrailingFoot.OnsetLatency_sec = LeftFoot.Steps.Onsets_sec(1,1);
                SteppingData.TrailingFoot.Displacement = LeftFoot.Yaw.Displacement;
            else
                SteppingData.LeadingFoot.Foot = {'Left'};
                SteppingData.LeadingFoot.OnsetLatency_sec = LeftFoot.Steps.Onsets_sec(1,1);
                SteppingData.LeadingFoot.Displacement = LeftFoot.Yaw.Displacement;
                SteppingData.TrailingFoot.Foot = {'Right'};
                SteppingData.TrailingFoot.OnsetLatency_sec = RightFoot.Steps.Onsets_sec(1,1);
                SteppingData.TrailingFoot.Displacement = RightFoot.Yaw.Displacement;
            end
        end
        
        load('ExpInfo');
        load('ParticipantID');
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
    Process_Steps
else
    beep
    disp('Process Steps complete');
    
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