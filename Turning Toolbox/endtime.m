function EndTime = endtime(DisplacementInput,VelocityInput,TrialNum)

B = length(VelocityInput)-1;

MeetEndCriteria = 0;
[MaxVel,MaxVelTime] = max(VelocityInput(1:B));
Vel_20 = 0.20*MaxVel;
Below_20 = 0;

for N = MaxVelTime:B
    if VelocityInput(N)<=Vel_20
        Below_20 = Below_20+1;
        Below_20Times(Below_20)= N; %#ok<*AGROW>
    end
end

A = Below_20Times(1,1);

for N = A:B
    if VelocityInput(N-1)>0&&VelocityInput(N)<=0;
        MeetEndCriteria = MeetEndCriteria+1;
        MeetEndCriteriaTimes(MeetEndCriteria) = N; %#ok<*SAGROW>
    end
end

MeetEndCriteriaTimes = MeetEndCriteriaTimes';

if MeetEndCriteriaTimes>1; %#ok<*BDSCI>
    Question = 0;
    for j = 1:length(MeetEndCriteriaTimes);
        if Question==0||Question==2
            scrsz = get(0,'ScreenSize');
            figure('Position',scrsz);
            DisplacementInputEnd_sec = (MeetEndCriteriaTimes(j,1)*5)/1000;
            MaxY = 250;
            MaxX = length(VelocityInput);
            axis([min(0) max(MaxX) min(-50) max(MaxY)]);
            Xaxes = ((1:MaxX)*5)/1000';
            y1 = [-50,MaxY];
            for x = 1:length(MeetEndCriteriaTimes);
                AllEnds = (MeetEndCriteriaTimes(x,1)*5)/1000;
                x2 = [AllEnds,AllEnds];
                plot(x2,y1,'k');
                hold on
            end
            x1 = [DisplacementInputEnd_sec,DisplacementInputEnd_sec];
            plot(x1,y1,'r');
            hold on
            plot(Xaxes,DisplacementInput(1:MaxX),'k');
            plot(Xaxes,VelocityInput,'b');
            TrialNumber = num2str(TrialNum);
            Title = strcat('Trial Number',{' '},TrialNumber);
            title(strcat('Displacement and Velocity -',Title));
            xlabel ('Time(s)');
            ylabel ('Displacement(°) and Velocity(°s^-1)');
            Question = input('Is this the correct end time?\n(1)Yes\n(2)No\n');
            if Question==2;
                close all
            elseif Question==1
                EndTime = MeetEndCriteriaTimes(j,1);
                close all
            else
                clc
                close all
                fprintf('Uh oh, something went wrong...\n\n');
                Statement = strcat('You will need to start Trial',{' '},num2str(TrialNum));
                disp(char(Statement));
                pause
                clr
                Determine_Axial_Rotation_Times
            end
        end
    end
end