function Plot_Steps
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
    load('ParticipantID');
    load('ExpInfo');
    if TrialNum<=9
        load(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
    elseif TrialNum>9
        load(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
    end
    
    TF = strcmp(TrialCondition,'Dummy Trial');
    
    if TF == 0;

        
        scrsz = get(0,'ScreenSize');
        figure('Position',scrsz);
        MaxX = length(Head.Yaw.Displacement);
        Xaxes = (((1:MaxX)*5)/1000)';
        axis([min(0) max(MaxX) min(-50) max(250)]);
        y1 = [-50,250];
        StepOnsets = cell2mat(SteppingData.SortedSteps(:,2));
        for j = 1:SteppingData.Total;
            x = [StepOnsets(j,1),StepOnsets(j,1)];
            plot(x,y1,'g');
            hold on
        end
        clearvars StepOnsets
        plot(Xaxes,LeftFoot.Yaw.Displacement,'b');
        plot(Xaxes,RightFoot.Yaw.Displacement,'r');
        TotalStepsText = strcat('Total Steps =',{' '},num2str(SteppingData.Total));
        text(0.10,210,TotalStepsText);
        TrialNumber = num2str(TrialNum);
        Title = strcat('Trial Number',{' '},TrialNumber);
        title(strcat('Step Displacement -',Title));
        legend('Step Onset Latencies', 'Location','SouthEast');
        xlabel ('Time(s)');
        ylabel ('Displacement(�)');
        set(gcf,'visible','off')
        
        %rez=1200; %resolution (dpi) of final graphic
        f=gcf; %f is the handle of the figure you want to export
        figpos=getpixelposition(f); %dont need to change anything here
        resolution=get(0,'ScreenPixelsPerInch'); %dont need to change anything here
        set(f,'paperunits','inches','papersize',figpos(3:4)/resolution,'paperposition',[0 0 figpos(3:4)/resolution]); %dont need to change anything here
        path= pwd; %the folder where you want to put the file
        
        if TrialNum<=9
            name = char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),{' '},'Steps','.tiff'));
        elseif TrialNum>9
            name = char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),{' '},'Steps','.tiff'));
        end %what you want the file to be called
        print(f,fullfile(path,name),'-dtiff','-r0','-opengl'); %save file
        close 1
    else
    end
end

beep
msgbox('Plot Steps Script Complete');
clc

Source = pwd;
Destination = strrep(Source,'MATLAB','Figures');
movefile(strcat(Source,'/*.tiff'),Destination);