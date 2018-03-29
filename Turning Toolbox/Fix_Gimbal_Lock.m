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
        
        Max = max(LeftFoot.LFootZ);
        Min = min(LeftFoot.LFootZ);
        if abs(Min)>Max
            LeftFoot.LFootZ = -LeftFoot.LFootZ;
        end
        
        [row,col] = size(TrialCondition);
        if col==1
            Condition = TrialCondition;
        elseif col==2
            Condition = strcat(TrialCondition(1,1),{' '},TrialCondition(1,2));
        elseif col==3
            Condition = strcat(TrialCondition(1,1),{' '},TrialCondition(1,2),{' '},TrialCondition(1,3));
        end
        
        FootZ = LeftFoot.LFootZ;
        
        Title = strcat(num2str(TrialNum),' - Left Foot -',{' '},Condition);
        plot(FootZ)
        title(Title);
        clc
        Question = input('Does data need to be processed?\n(0)No, the data looks perfect.\n(1)There is a gimbal lock issue.\n(2)Foot placements need to be cleaned up.\n');
        while Question~=0;
            while Question==1;
                FootZVel = diff(FootZ)*200;
                C = length(FootZ)-3;
                Peaks = 0;
                for N = 5:C
                    if FootZ(N-1)<FootZ(N) && FootZ(N+1)<FootZ(N)&&FootZVel(N-1)>0 &&FootZVel(N)<0;
                        Peaks = Peaks+1;
                        Times(Peaks) = N; %#ok<*SAGROW>
                    end
                end
                Time = Times' %#ok<*NASGU>
                Time = input('What time should it be flipped?\n');
                Check(:,1) = FootZ;
                Pos135 = (-1*FootZ)+135;
                Check(:,2) = Pos135;
                Diff = (FootZ(Time))-(Pos135(Time));
                Adjust = Pos135+Diff;
                Add1 = FootZ(1:Time);
                Add2 = Adjust(Time+1:end,:);
                FootZ = vertcat(Add1,Add2);
                FootPlot = plot(FootZ,'k');
                title(Title);
                clc
                Question = input('Does data need to be processed?\n(0)No, the data looks perfect.\n(1)There is a gimbal lock issue.\n(2)Foot placements need to be cleaned up.\n');
                clearvars Check Pos135 Diff Adjust Add1 Add2 Times
            end
            
            while Question==2
                clc
                disp('What time is foot placement?');
                [PlacementTime,Y1] = ginput(1);
                if PlacementTime<1
                    PlacementTime = 1;
                else
                    PlacementTime = round(PlacementTime);
                end
                clc
                disp('What time does the next step start?');
                [StepTime,Y2] = ginput(1);
                if StepTime>length(FootZ)
                    StepTime = length(FootZ);
                else
                    StepTime = round(StepTime);
                end
                StepAmplitude = FootZ(PlacementTime);
                PlacementDuration = (StepTime-PlacementTime)-1;
                PlacementFiller(1:PlacementDuration,:) = StepAmplitude;
                Diff = (FootZ(PlacementTime))-(FootZ(StepTime));
                Adjust = FootZ(StepTime:end,:)+Diff;
                FootZ = vertcat(FootZ(1:PlacementTime),PlacementFiller,Adjust);
                FootPlot = plot(FootZ,'k');
                title(Title);
                clc
                Question = input('Does data need to be processed?\n(0)No, the data looks perfect.\n(1)There is a gimbal lock issue.\n(2)Foot placements need to be cleaned up.\n');
                clearvars Check Pos135 Diff Adjust Add1 Add2 PlacementTime StepTime StepAmplitude PlacementDuration PlacementFiller
            end
            while Question>2
                clc
                Question = input('Does data need to be processed?\n(0)No, the data looks perfect.\n(1)There is a gimbal lock issue.\n(2)Foot placements need to be cleaned up.\n');
            end
        end
        
        LeftFoot.Yaw.Displacement = FootZ;
        
        Max = max(RightFoot.RFootZ);
        Min = min(RightFoot.RFootZ);
        if abs(Min)>Max
            RightFoot.RFootZ = -RightFoot.RFootZ;
        end
        
        FootZ = RightFoot.RFootZ;
        
        Title = strcat(num2str(TrialNum),' - Right Foot -',{' '},Condition);
        plot(FootZ)
        title(Title);
        clc
        Question = input('Does data need to be processed?\n(0)No, the data looks perfect.\n(1)There is a gimbal lock issue.\n(2)Foot placements need to be cleaned up.\n');
        while Question~=0;
            while Question==1;
                FootZVel = diff(FootZ)*200;
                C = length(FootZ)-3;
                Peaks = 0;
                for N = 5:C
                    if FootZ(N-1)<FootZ(N) && FootZ(N+1)<FootZ(N)&&FootZVel(N-1)>0 &&FootZVel(N)<0;
                        Peaks = Peaks+1;
                        Times(Peaks) = N; %#ok<*SAGROW>
                    end
                end
                Time = Times' %#ok<*NOPTS>
                Time = input('What time should it be flipped?\n');
                Check(:,1) = FootZ;
                Pos135 = (-1*FootZ)+135;
                Check(:,2) = Pos135;
                Diff = (FootZ(Time))-(Pos135(Time));
                Adjust = Pos135+Diff;
                Add1 = FootZ(1:Time);
                Add2 = Adjust(Time+1:end,:);
                FootZ = vertcat(Add1,Add2);
                FootPlot = plot(FootZ,'k');
                title(Title);
                clc
                Question = input('Does data need to be processed?\n(0)No, the data looks perfect.\n(1)There is a gimbal lock issue.\n(2)Foot placements need to be cleaned up.\n');
                clearvars Check Pos135 Diff Adjust Add1 Add2 Times
            end
            
            while Question==2
                clc
                disp('What time is foot placement?');
                [PlacementTime,Y1] = ginput(1);
                if PlacementTime<1
                    PlacementTime = 1;
                else
                    PlacementTime = round(PlacementTime);
                end
                clc
                disp('What time does the next step start?');
                [StepTime,Y2] = ginput(1);
                if StepTime>length(FootZ)
                    StepTime = length(FootZ);
                else
                    StepTime = round(StepTime);
                end
                StepAmplitude = FootZ(PlacementTime);
                PlacementDuration = (StepTime-PlacementTime)-1;
                PlacementFiller(1:PlacementDuration,:) = StepAmplitude;
                Diff = (FootZ(PlacementTime))-(FootZ(StepTime));
                Adjust = FootZ(StepTime:end,:)+Diff;
                FootZ = vertcat(FootZ(1:PlacementTime),PlacementFiller,Adjust);
                FootPlot = plot(FootZ,'k');
                title(Title);
                clc
                Question = input('Does data need to be processed?\n(0)No, the data looks perfect.\n(1)There is a gimbal lock issue.\n(2)Foot placements need to be cleaned up.\n');
                clearvars Check Pos135 Diff Adjust Add1 Add2 PlacementTime StepTime StepAmplitude PlacementDuration PlacementFiller
            end
            
            while Question>2
                clc
                Question = input('Does data need to be processed?\n(0)No, the data looks perfect.\n(1)There is a gimbal lock issue.\n(2)Foot placements need to be cleaned up.\n');
            end
        end
        clc
        RightFoot.Yaw.Displacement = FootZ;
        close all
        plot(LeftFoot.Yaw.Displacement,'b');
        hold
        plot(RightFoot.Yaw.Displacement,'r');
        Title = strcat(num2str(TrialNum),{' - '},Condition);
        title(Title);
        clc
        pause
        close all
        
        clearvars -except BlockNum EOG ExpName FastPhases FilteredData Head LED LeftFoot NormalizedData ParticipantID Pelvis RawData RightFoot SlowPhases SteppingData Thorax TrialCondition TrialNum
    end
    if TrialNum<=9
        save(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
    elseif TrialNum>9
        save(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
    end
    clear
    clc
end
clc
Question = input('Do have more trials to process?\n(0)No\n(1)Yes\n');
if Question==1;
    Fix_Gimbal_Lock
else
    beep
    clr
    disp('Fix Gimbal Lock script complete');
    Question = input('Would you like to continue analysing?\n(0)No\n(1)Yes\n');
    if Question==1
        clr
        Turning_Analysis
    else
        clr
    end
end