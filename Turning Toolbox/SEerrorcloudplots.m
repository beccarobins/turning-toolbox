close all;clear all;clc

cd('F:\Exp 1 - Behaviour\');

Amplitude = {'Deg45' 'Deg90' 'Deg135' 'Deg180'};
Speed = {'Moderate' 'Fast'};

load('ParticipantList.mat');

for ii = 1:2
    
    for j = 1:4
        headMean = [];
        thoraxMean = [];
        pelvisMean = [];
                
        for subjectID = 1:length(ParticipantList);
            
            cd(char(strcat('F:\Exp 1 - Behaviour\',ParticipantList(subjectID,:),'\',ParticipantList(subjectID,:),{' '},'MATLAB')));
            
            for TrialNum = 1:80;
                load('ParticipantID');
                load('ExpInfo');
                if TrialNum<=9
                    load(char(strcat(ExpName,{' '},ParticipantID,{' 0'},num2str(TrialNum),'.mat')));
                elseif TrialNum>9
                    load(char(strcat(ExpName,{' '},ParticipantID,{' '},num2str(TrialNum),'.mat')));
                end
                
                TF = strcmp(TrialCondition,'Dummy Trial');
                
                if TF ==0
                    TF = strcmp(TrialCondition(1,2),Amplitude(:,j));
                    if TF ==1
                        TF = strcmp(TrialCondition(1,3),Speed(:,ii));
                        if TF ==1
                            headMean = vertcat(headMean,NormalizedData.TimeNormalized.Head.Yaw.Displacement');
                            thoraxMean = vertcat(thoraxMean,NormalizedData.TimeNormalized.Thorax.Yaw.Displacement');
                            pelvisMean = vertcat(pelvisMean,NormalizedData.TimeNormalized.Pelvis.Yaw.Displacement');
                        end
                    end
                end
            end
            %(1) Plot:
            close all
            [h00,h01] = spm1d_plot_meanSE(headMean);
            hold on
            [h10,h11] = spm1d_plot_meanSE(thoraxMean);
            [h20,h21] = spm1d_plot_meanSE(pelvisMean);
            set(h00, 'color','b');   set(h01, 'facecolor','b');
            set(h10, 'color','k');   set(h11, 'facecolor',0.7*[1 1 1]);
            set(h20, 'color','r');   set(h21, 'facecolor','r');
            axis([0 2000 -20 200])
            xlabel('Time (%)')
            ylabel('\theta')
            legend([h00,h10,h20], {'Head','Thorax','Pelvis'},'Location','SouthEast')
            legend('boxoff');
            Title = strcat(Amplitude(:,j),{' '},Speed(:,ii));
            title(Title);
            set(gcf, 'Visible','off');
            
            %rez=1200; %resolution (dpi) of final graphic
            f=gcf; %f is the handle of the figure you want to export
            figpos=getpixelposition(f); %dont need to change anything here
            resolution=get(0,'ScreenPixelsPerInch'); %dont need to change anything here
            set(f,'paperunits','inches','papersize',figpos(3:4)/resolution,'paperposition',[0 0 figpos(3:4)/resolution]); %dont need to change anything here
            cd('F:\Exp 1 - Behaviour\');
            path= pwd; %the folder where you want to put the file
            
            name = char(strcat(ExpName,{' '},'Axial Segment Mean+SE cloud -',Amplitude(:,j),{' '},Speed(:,ii),'.tiff'));
            print(f,fullfile(path,name),'-dtiff','-r0','-opengl'); %save file
            close all
            load('ParticipantList.mat');
        end
    end
end

tts('S E cloud plots complete');
