function Plot_Histograms
load('ExpInfo');
NumConditions= prod(cell2mat(ExpConditions(:,2))); %#ok<*NODEF>
warning('off','all');
load('ParticipantList');
ParticipantID = char(ParticipantList(1,1));
load(char(strcat(ExpName,{' '},ParticipantID,{' '},'Axial Segment Data.mat')));
[row,col] = size(Condition1); %#ok<*ASGLU>
for i = 1:NumConditions
    if col==1
    elseif col==2
        Condition = eval(strcat('Condition',num2str(i)));
        Condition = strcat(Condition(1,1),{' '},Condition(1,2)); %#ok<*NASGU>
        u = strcat('Condition',num2str(i));
        evalc([u ' = Condition']);
    elseif col==3
        Condition = eval(strcat('Condition',num2str(i)));
        Condition = strcat(Condition(1,1),{' '},Condition(1,2),{' '},Condition(1,3));
        u = strcat('Condition',num2str(i));
        evalc([u ' = Condition']);
    end
end

for j = 1:5
    FastPhaseVariables(j,1) = {j}; %#ok<*AGROW>
end
FastPhaseVariables(1,2) = {'Fast Phase Onset Position'};
FastPhaseVariables(2,2) = {'Fast Phase End Position'};
FastPhaseVariables(3,2) = {'Fast Phase Amplitude'};
FastPhaseVariables(4,2) = {'Fast Phase Velocity'};
FastPhaseVariables(5,2) = {'Fast Phase Acceleration'};

disp(FastPhaseVariables)
k = input('Which fast phase variable to graph?\n');

for j = 1:NumConditions
    Condition = char(eval(strcat('Condition',num2str(j))));
    Filename = sprintf(char(strcat(ExpName,{' '},'Individual Fast Phases.xlsx')));
    [a,b,c] = xlsread(Filename,Condition);
    NewData = a(:,k);
    if j>1
        Length = abs(length(VariableData)-length(NewData));
        if length(VariableData)>length(NewData)
            NewData = vertcat(NewData,nan(Length,1));
        elseif length(VariableData)<length(NewData);
            VariableData = vertcat(VariableData,nan(Length,j-1));
        end
    end
    VariableData(:,j) = NewData;
    clearvars NewData
end

Max = max(VariableData);
BinMax = 10*(ceil(max(Max/10)));
BinSize = BinMax/10;
Bins = [0:BinSize:BinMax]; %#ok<*NBRAK>

FreqCount = zeros(10,NumConditions);

for j = 1:NumConditions
    ConditionData = VariableData(:,j);
    for i = 1:10
        for N = 1:length(ConditionData)
            if ConditionData(N)<=Bins(1,i+1)&& ConditionData(N)>Bins(1,i)
                FreqCount(i,j)= FreqCount(i,j)+1;
            end
        end
    end
end

for j = 1:NumConditions
Sum(:,j) = sum(FreqCount(:,j));
CumFreq(:,j) = (FreqCount(:,j)/Sum(:,j))*100;
end

for j = 1:NumConditions
    Legend(:,j) = strcat(eval(strcat('Condition',num2str(j)))); %#ok<*SAGROW>
end

scrsz = get(0,'ScreenSize');
figure('Position',scrsz);
bar(CumFreq);
title(FastPhaseVariables(k,2),'FontSize',14);
BinLabel = Bins(2:11);
set(gca,'XTicklabel',BinLabel);
ylabel ('Cumulative Frequency (%)','FontSize',14);
lh = legend(Legend,'Location','EastOutside');

clc