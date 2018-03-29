function OnsetLatency = onsetlatency(DisplacementInput,VelocityInput,TrialNum)

StartCriteria = 0;
Threshold = 10;
x = find((DisplacementInput)>=Threshold);
B = x(1,1);
A = 1;

for N = A:B;
    if DisplacementInput(N+1)>DisplacementInput(N) && VelocityInput(N+1)>VelocityInput(N)&& VelocityInput(N)>0;
        StartCriteria = StartCriteria+1;
        StartTimes(StartCriteria)= N; %#ok<*AGROW,*SAGROW>
    end
end

StartTimes = StartTimes';
StartTimes2 = diff(StartTimes);
StartTimes3 = diff(StartTimes2);

t = diff([false;StartTimes3==0;false]);
p = find(t==1);
OnsetTimes = StartTimes(p); %#ok<*FNDSB>

Question = 0;

for j = 1:length(OnsetTimes);
    if Question==0||Question==2
        scrsz = get(0,'ScreenSize');
        figure('Position',scrsz);
        Onset_sec = (OnsetTimes(j,1)*5)/1000;
        MaxY = 250;
        MaxX = length(VelocityInput);
        axis([min(0) max(MaxX) min(-50) max(MaxY)]);
        Xaxes = ((1:MaxX)*5)/1000';
        y1 = [-50,MaxY];
        for x = 1:length(OnsetTimes);
            AllOnsets = (OnsetTimes(x,1)*5)/1000;
            x2 = [AllOnsets,AllOnsets];
            plot(x2,y1,'k');
            hold on
        end
        x1 = [Onset_sec,Onset_sec];
        plot(x1,y1,'r');
        hold on
        plot(Xaxes,DisplacementInput(1:MaxX),'k');
        plot(Xaxes,VelocityInput,'b');
        TrialNumber = num2str(TrialNum);
        Title = strcat('Trial Number',{' '},TrialNumber);
        title(strcat('Displacement and Velocity -',Title));
        xlabel ('Time(s)');
        ylabel ('Displacement(°) and Velocity(°s^-1)');
        Question = input('Is this the correct onset?\n(1)Yes\n(2)No\n(3)Previous time is correct\n');
        if Question==2;
            close all
        elseif Question==1
            OnsetLatency = OnsetTimes(j,1);
            close all
        elseif Question==3
            OnsetLatency = OnsetTimes(j-1,1);
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
