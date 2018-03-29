function Plot_Segment_Position_Bargraphs
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

for j = 1:2
    PositionVariables(j,1) = {j}; %#ok<*AGROW>
end
PositionVariables(1,2) = {'Segments Positions at Step Onset'};
PositionVariables(2,2) = {'Segments Positions at Step End'};

disp(PositionVariables)
k = input('Which positions to graph?\n');

for j = 1:NumConditions
    Condition = char(eval(strcat('Condition',num2str(j))));
    Filename = sprintf(char(strcat(ExpName,{' '},'Segment Positions.xlsx')));
[a,b,c] = xlsread(Filename,Condition);
if k==1
    NewData = nanmean(a(:,2:5));
elseif k==2
     NewData = nanmean(a(:,7:10));
end
    VariableData(j,:) = NewData;
    clearvars NewData
end

VariableData = VariableData';

for j = 1:NumConditions
    Legend(:,j) = strcat(eval(strcat('Condition',num2str(j)))); %#ok<*SAGROW>
end

scrsz = get(0,'ScreenSize');
figure('Position',scrsz);
bar(VariableData);
title(PositionVariables(k,2),'FontSize',14);
set(gca,'XTickLabel',{'Gaze','Head','Thorax','Pelvis'})
ylabel ('Displacement (deg)','FontSize',14);
lh = legend(Legend,'Location','NorthEast');

clc