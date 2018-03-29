close all;clear all;clc

cd('E:\Exp 2 - Vision\');

Amplitude = {'Deg90' 'Deg180'};
%Speed = {'Moderate' 'Fast'};
Vision = {'Vision' 'No Vision' 'Fixation'};

load('ParticipantList.mat');

for ii = 1:3;
    
    for jj = 1:2;
        gazeMean = [];
        headMean = [];
        thoraxMean = [];
        pelvisMean = [];
        
        for subjectID = 1:length(ParticipantList);
            
            currentFolder = char(strcat('E:\Exp 2 - Vision\',ParticipantList(subjectID,:),'\',ParticipantList(subjectID,:),{' '},'MATLAB'));
            
            cd(currentFolder);
            
            for TrialNum = 1:60;
                load('ParticipantID');
                load('ExpInfo');
                if TrialNum<=9
                    load(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
                elseif TrialNum>9
                    load(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
                end
                
                TF = strcmp(TrialCondition,'Dummy Trial');
                
                if TF ==0
                    TF = strcmp(TrialCondition(1,2),Amplitude(:,jj));
                    if TF ==1
                        TF = strcmp(TrialCondition(1,3),Vision(:,ii));
                        if TF ==1
                            if length(Head.Yaw.Displacement)>length(EOG.Subsampled.Displacement.Filt10)
                                Max = length(EOG.Subsampled.Displacement.Filt10);
                            else
                                Max = length(Head.Yaw.Displacement);
                            end
                            
                            Gaze.Yaw.Displacement = Head.Yaw.Displacement(1:Max)+EOG.Subsampled.Displacement.Filt10(1:Max);
                            
                            AxialSegmentOnsets = [Head.Yaw.DisplacementVariables.OnsetLatency,Thorax.Yaw.DisplacementVariables.OnsetLatency,Pelvis.Yaw.DisplacementVariables.OnsetLatency];
                            Min = min(AxialSegmentOnsets);
                            AxialSegmentEnds = [Head.Yaw.DisplacementVariables.EndTime,Thorax.Yaw.DisplacementVariables.EndTime,Pelvis.Yaw.DisplacementVariables.EndTime];
                            Max = max(AxialSegmentEnds);
                            NormalizedData.TimeNormalized.Gaze.Yaw.Displacement = timenorm(Gaze.Yaw.Displacement,Min,Max);
                            
                            
                            gazeMean = vertcat(gazeMean,NormalizedData.TimeNormalized.Gaze.Yaw.Displacement');
                            headMean = vertcat(headMean,NormalizedData.TimeNormalized.Head.Yaw.Displacement');
                            thoraxMean = vertcat(thoraxMean,NormalizedData.TimeNormalized.Thorax.Yaw.Displacement');
                            pelvisMean = vertcat(pelvisMean,NormalizedData.TimeNormalized.Pelvis.Yaw.Displacement');
                        end
                    end
                end

            end
            %(1) Plot
            close all
            [t00,t01] = spm1d_plot_meanSD(gazeMean);
            hold on
            [h00,h01] = spm1d_plot_meanSD(headMean);
            [h10,h11] = spm1d_plot_meanSD(thoraxMean);
            [h20,h21] = spm1d_plot_meanSD(pelvisMean);
            set(t00, 'color',[0,0.4,0.5]);   set(t01, 'facecolor',[0,1,0.5]);
            set(h00, 'color','b');   set(h01, 'facecolor','b');
            set(h10, 'color','k');   set(h11, 'facecolor',0.7*[1 1 1]);
            set(h20, 'color','r');   set(h21, 'facecolor','r');
            axis([0 2000 -20 200])
            xlabel('Time (%)')
            ylabel('\theta')
            legend([t00,h00,h10,h20], {'Gaze','Head','Thorax','Pelvis'},'Location','SouthEast')
            legend('boxoff');
            Title = strcat(Amplitude(:,jj),{' '},Vision(:,ii));
            title(Title);
            set(gcf, 'Visible','off');
            
            %rez=1200; %resolution (dpi) of final graphic
            f=gcf; %f is the handle of the figure you want to export
            figpos=getpixelposition(f); %dont need to change anything here
            resolution=get(0,'ScreenPixelsPerInch'); %dont need to change anything here
            set(f,'paperunits','inches','papersize',figpos(3:4)/resolution,'paperposition',[0 0 figpos(3:4)/resolution]); %dont need to change anything here
            cd('E:\Exp 2 - Vision\');
            path= pwd; %the folder where you want to put the file
            
            name = char(strcat(ExpName,{' '},'Axial Segment Mean+SD cloud -',Amplitude(:,jj),{' '},Vision(:,ii),'.tiff'));
            print(f,fullfile(path,name),'-dtiff','-r0','-opengl'); %save file
            close all
            load('ParticipantList.mat');
        end
    end
end

tts('S D cloud plots complete');
