function Plot_Displacement_Subplots
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
    
    TF = strcmp(TrialCondition,'Dummy Trial'); %#ok<*NODEF>
    
    if TF==0
        
        RECT = [20, 50, 450, 875];
        figure('Position',RECT);
        set (gcf, 'Color', [1 1 1]);
        
        Zeros = zeros(500,1);
        
        HeadFig = (vertcat(Zeros,Head.Yaw.Displacement))+125;
        ThoraxFig = (vertcat(Zeros,Thorax.Yaw.Displacement))+100;
        PelvisFig = (vertcat(Zeros,Pelvis.Yaw.Displacement))+75;
        LeftFootFig = (vertcat(Zeros,LeftFoot.Yaw.Displacement))+15;
        RightFootFig = vertcat(Zeros,RightFoot.Yaw.Displacement);
        
        SubSampledEye = EOG.Displacement.Filt10(1:5:end,:);
        
        FastPhaseOnsets_sub = round(FastPhases.Onsets_ms/5);
        Onsets = [Head.Yaw.DisplacementVariables.OnsetLatency_sec,Thorax.Yaw.DisplacementVariables.OnsetLatency_sec,Pelvis.Yaw.DisplacementVariables.OnsetLatency_sec];
        TurnOnset = (min(Onsets))+500;
        Length = length(Head.Yaw.Displacement);
        %AmpTextX = Length-475;
        
        X = [501,501];
        X2 = [TurnOnset,TurnOnset];
        %X3 = [Length-500,Length-500];
        X4 = [Head.Yaw.DisplacementVariables.OnsetLatency+500,Head.Yaw.DisplacementVariables.OnsetLatency+500];
        X5 = [FastPhaseOnsets_sub(1,1)+500,FastPhaseOnsets_sub(1,1)+500];
        %Y3 = [0,(str2double(TrialCondition(2,1)))];
        
        %plot(X3,Y3,'k','LineWidth',2);
        plot(HeadFig(1:Length),'k','LineWidth',1);
        text(0,130,'Head','FontWeight','bold');
        grid off
        axis off
        hold on
        plot(ThoraxFig(1:Length),'k','LineWidth',1);
        text(0,105,'Thorax','FontWeight','bold');
        plot(PelvisFig(1:Length),'k','LineWidth',1);
        text(0,80,'Pelvis','FontWeight','bold');
        plot(LeftFootFig(1:Length),'k','LineWidth',1);
        text(0,20,'Left Foot','FontWeight','bold');
        plot(RightFootFig(1:Length),'k','LineWidth',1);
        text(0,5,'Right Foot','FontWeight','bold');
        %AmpLabelText = strcat(num2str(cell2mat(TrialCondition(2,1))),'°');
        %text(AmpTextX,(str2double(TrialCondition(2,1))/2),AmpLabelText,'FontWeight','bold');
        
        for j = 1:length(TrialCondition)
            TF(:,j) = strcmp('45', TrialCondition(:,j));
        end
        
        Sum = sum(TF);
        
        if Sum == 1
            EyeFig = (vertcat(Zeros,SubSampledEye))+190;
            plot(EyeFig(1:Length),'k','LineWidth',1);
            text(0,185,'Eye','FontWeight','bold');
            Y = [-10,230];
            plot(X,Y,'k','LineWidth',2);
            plot(X2,Y,'k:','LineWidth',1);
            plot(X4,Y,'r:','LineWidth',2);
            plot(X5,Y,'b:','LineWidth',2);
        else
            for j = 1:length(TrialCondition)
                TF(:,j) = strcmp('90', TrialCondition(:,j));
            end
            Sum = sum(TF);
            if Sum == 1
                EyeFig = (vertcat(Zeros,SubSampledEye))+230;
                plot(EyeFig(1:Length),'k','LineWidth',1);
                text(0,225,'Eye','FontWeight','bold');
                Y = [-10,270];
                plot(X,Y,'k','LineWidth',2);
                plot(X2,Y,'k:','LineWidth',2);
                plot(X4,Y,'r:','LineWidth',2);
                plot(X5,Y,'b:','LineWidth',2);
            else
                for j = 1:length(TrialCondition)
                    TF(:,j) = strcmp('135', TrialCondition(:,j));
                end
                Sum = sum(TF);
                if Sum == 1
                    EyeFig = (vertcat(Zeros,SubSampledEye))+270;
                    plot(EyeFig(1:Length),'k','LineWidth',1);
                    text(0,275,'Eye','FontWeight','bold');
                    Y = [-10,310];
                    plot(X,Y,'k','LineWidth',2);
                    plot(X2,Y,'k:','LineWidth',2);
                    plot(X4,Y,'r:','LineWidth',2);
                    plot(X5,Y,'b:','LineWidth',2);
                else
                    EyeFig = (vertcat(Zeros,SubSampledEye))+320;
                    plot(EyeFig(1:Length),'k','LineWidth',1);
                    text(0,325,'Eye','FontWeight','bold');
                    Y = [-10,350];
                    plot(X,Y,'k','LineWidth',2);
                    plot(X2,Y,'k:','LineWidth',2);
                    plot(X4,Y,'r:','LineWidth',2);
                    plot(X5,Y,'b:','LineWidth',2);
                end
            end
        end
        
        set(gcf,'visible','off')
        
        %rez=1200; %resolution (dpi) of final graphic
        f=gcf; %f is the handle of the figure you want to export
        figpos=getpixelposition(f); %dont need to change anything here
        resolution=get(0,'ScreenPixelsPerInch'); %dont need to change anything here
        set(f,'paperunits','inches','papersize',figpos(3:4)/resolution,'paperposition',[0 0 figpos(3:4)/resolution]); %dont need to change anything here
        path= pwd; %the folder where you want to put the file
        
        if TrialNum<=9
            name = char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),{' '},'Segment Subplots','.tiff'));
        elseif TrialNum>9
            name = char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),{' '},'Segment Subplots','.tiff'));
        end %what you want the file to be called
        print(f,fullfile(path,name),'-dtiff','-r0','-opengl'); %save file
        close 1
        
    else
    end
end

beep
msgbox('Plot Displacement Subplots Script Complete');
clc

Source = pwd;
Destination = strrep(Source,'MATLAB','Figures');
movefile(strcat(Source,'/*.tiff'),Destination);
