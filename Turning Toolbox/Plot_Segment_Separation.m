function Plot_Segment_Separation
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
        MaxX = length(NormalizedData.TimeNormalized.HeadonThorax.Yaw.Displacement);
        Xaxes = (((1:MaxX)/MaxX)*100)';
        plot(Xaxes,NormalizedData.TimeNormalized.HeadonThorax.Yaw.Displacement,'b');
        hold on
        plot(Xaxes,NormalizedData.TimeNormalized.HeadonPelvis.Yaw.Displacement,'r');
        plot(Xaxes,NormalizedData.TimeNormalized.ThoraxonPelvis.Yaw.Displacement,'g');
        TrialNumber = num2str(TrialNum);
        Title = strcat('Trial Number',{' '},TrialNumber);
        title(strcat('Segment Separation -',Title));
        legend('Head-on-Thorax','Head-on-Pelvis','Thorax-on-Pelvis','Location','NorthEast');
        xlabel ('Time(%)');
        ylabel ('Angular Separation(°)');
        set(gcf, 'Visible','off');
        
        %rez=1200; %resolution (dpi) of final graphic
        f=gcf; %f is the handle of the figure you want to export
        figpos=getpixelposition(f); %dont need to change anything here
        resolution=get(0,'ScreenPixelsPerInch'); %dont need to change anything here
        set(f,'paperunits','inches','papersize',figpos(3:4)/resolution,'paperposition',[0 0 figpos(3:4)/resolution]); %dont need to change anything here
        path= pwd; %the folder where you want to put the file
        
        if TrialNum<=9
            name = char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),{' '},'Angular Separation','.tiff'));
        elseif TrialNum>9
            name = char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),{' '},'Angular Separation','.tiff'));
        end %what you want the file to be called
        print(f,fullfile(path,name),'-dtiff','-r0','-opengl'); %save file
        close all
    else
    end
end

beep
msgbox('Plot Segment Separation Script Complete');
clc

Source = pwd;
Destination = strrep(Source,'MATLAB','Figures');
movefile(strcat(Source,'/*.tiff'),Destination);