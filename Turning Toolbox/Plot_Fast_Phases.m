function Plot_Fast_Phases
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
        MaxY = (20*(ceil(max(EOG.Displacement.Filt30/20.))))+20;
        MaxX = 1000*(floor(length(EOG.Displacement.Filt30)/1000.));
        if MaxX>length(EOG.Displacement.Filt30)
            MaxX = MaxX-500;
        end
        axis([min(0) max(MaxX) min(-30) max(MaxY)]);
        y1 = [-30,MaxY];
        for j = 1:FastPhases.Total;
            x = [FastPhases.Onsets_ms(j,:),FastPhases.Onsets_ms(j,:)];
            plot(x,y1,'g');
            hold on
        end
        x2 = [Head.Yaw.DisplacementVariables.EndTime_ms,Head.Yaw.DisplacementVariables.EndTime_ms];
        plot(x2,y1,'r');
        plot(EOG.Displacement.Filt30,'k');
%         FastPhaseAmpsText = strcat('Fast Phase Amplitudes =',{' '},num2str(FastPhases.Amplitudes),'°');
%         text(MaxX-1500,MaxY-50,FastPhaseAmpsText);
%         MaxFastPhaseAmpText = strcat('Maximum Fast Phase Amplitude =',{' '},num2str(FastPhases.MaxAmp),'°');
%         text(100,MaxY-5,MaxFastPhaseAmpText);
%         MaxHeadVelText = strcat('Peak Fast Phase Velocity =',{' '},num2str(FastPhases.PeakVel),'°s^-^1');
%         text(100,MaxY-10,MaxHeadVelText);
%         MaxFastPhaseAccText = strcat('Peak Fast Phase Acceleration =',{' '},num2str(FastPhases.PeakAcc),'°s^-^2');
%         text(100,MaxY-15,MaxFastPhaseAccText);
        FastPhaseText = strcat('Number of Fast Phases =',{' '},num2str(FastPhases.Total));
        text(100,MaxY-20,FastPhaseText);
        TrialNumber = num2str(TrialNum);
        Title = strcat('Trial Number',{' '},TrialNumber);
        title(strcat('Eye Displacement -',Title));
        legend('Fast Phase Onset Latencies','Location','SouthEast');
        xlabel ('Time(ms)');
        ylabel ('Displacement(°)');
        set(gcf, 'Visible','off');
        
        %rez=1200; %resolution (dpi) of final graphic
        f=gcf; %f is the handle of the figure you want to export
        figpos=getpixelposition(f); %dont need to change anything here
        resolution=get(0,'ScreenPixelsPerInch'); %dont need to change anything here
        set(f,'paperunits','inches','papersize',figpos(3:4)/resolution,'paperposition',[0 0 figpos(3:4)/resolution]); %dont need to change anything here
        path= pwd; %the folder where you want to put the file
        
        if TrialNum<=9
            name = char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),{' '},'Fast Phases','.tiff'));
        elseif TrialNum>9
            name = char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),{' '},'Fast Phases','.tiff'));
        end %what you want the file to be called
        print(f,fullfile(path,name),'-dtiff','-r0','-opengl'); %save file
        close all 
    else
    end
end

beep
msgbox('Plot Fast Phases Script Complete');
clc

Source = pwd;
Destination = strrep(Source,'MATLAB','Figures');
movefile(strcat(Source,'/*.tiff'),Destination);