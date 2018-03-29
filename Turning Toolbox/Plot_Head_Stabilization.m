function Plot_Head_Stabilization
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
        
        VelDiff = Head.Yaw.Velocity-Thorax.Yaw.Velocity;
        HeadFaster = zeros(length(VelDiff),1);
        ThoraxFaster = zeros(length(VelDiff),1);
        
        for N = 1:length(VelDiff)
            if VelDiff(N)>10
                HeadFaster(N,1) = N;
            elseif VelDiff(N)<-10
                ThoraxFaster(N,1) = N;
            end
        end
        
        scrsz = get(0,'ScreenSize');
        figure('Position',scrsz);
        
        plot(Head.Yaw.Velocity,'b')
        hold on
        plot(Thorax.Yaw.Velocity,'k:')
        y = get(gca,'YLim');
        hold off
        
        for j = 1:length(VelDiff)
            if HeadFaster(j)>0
                x = [j,j];
                plot(x,y,'Color',[0.85,0.85,0.85]);
                hold on
            end
            if ThoraxFaster(j)>0
                x = [j,j];
                plot(x,y,'Color',[0.75,0.75,0.75]);
                hold on
            end
        end
        
        plot(Head.Yaw.Velocity,'k')
        hold on
        plot(Thorax.Yaw.Velocity,'k:')
                TrialNumber = num2str(TrialNum);
        Title = strcat('Trial Number',{' '},TrialNumber);
        title(strcat('Head-on-Thorax Gain -',Title));
        set(gcf, 'Visible','off');
        
        %rez=1200; %resolution (dpi) of final graphic
        f=gcf; %f is the handle of the figure you want to export
        figpos=getpixelposition(f); %dont need to change anything here
        resolution=get(0,'ScreenPixelsPerInch'); %dont need to change anything here
        set(f,'paperunits','inches','papersize',figpos(3:4)/resolution,'paperposition',[0 0 figpos(3:4)/resolution]); %dont need to change anything here
        path= pwd; %the folder where you want to put the file
        
        if TrialNum<=9
            name = char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),{' '},'Head Stabilization','.tiff'));
        elseif TrialNum>9
            name = char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),{' '},'Head Stabilization','.tiff'));
        end %what you want the file to be called
        print(f,fullfile(path,name),'-dtiff','-r0','-opengl'); %save file
        close all
    else
    end
end

beep
msgbox('Plot Head Stabilization Script Complete');
clc

Source = pwd;
Destination = strrep(Source,'MATLAB','Figures');
movefile(strcat(Source,'/*.tiff'),Destination);