function Plot_Onset_Latencies

RunStep = input('(1)Plot all conditions\n(2)Plot direction collapsed conditions\n ');

if RunStep==1;
    
    Exp = {'Participant'};
    load('ExpInfo');
    [j,k] = size(ExpConditions); %#ok<*NODEF,*ASGLU>
    for c = 1:j
        Exp = horzcat(Exp,ExpConditions(c,1)); %#ok<*AGROW>
    end
    Exp = horzcat(Exp,'Trial Number');
    Filename1 = sprintf(char(strcat(ExpName,{' '},'Axial Segment Data.xlsx'))); %#ok<*NASGU>
    Filename2 = sprintf(char(strcat(ExpName,{' '},'Eye Data.xlsx')));
    Filename3 = sprintf(char(strcat(ExpName,{' '},'Stepping Data.xlsx')));
    NumConditions = prod(cell2mat(ExpConditions(:,2)));
    %TrialsPerCondition = NumTrials/NumConditions;
    %[row,col] = size(ExpConditions);
    load('ParticipantList');
    ParticipantID = char(ParticipantList(1,1));
    load(char(strcat(ExpName,{' '},ParticipantID,{' '},'Axial Segment Data.mat')));
    [row,col] = size(Condition1);
    for i = 1:NumConditions
        if col==1
        elseif col==2
            Condition = eval(strcat('Condition',num2str(i)));
            Condition = strcat(Condition(1,1),{' '},Condition(1,2));
            u = strcat('Condition',num2str(i));
            evalc([u ' = Condition']);
        elseif col==3
            Condition = eval(strcat('Condition',num2str(i)));
            Condition = strcat(Condition(1,1),{' '},Condition(1,2),{' '},Condition(1,3));
            u = strcat('Condition',num2str(i));
            evalc([u ' = Condition']);
        end
    end
    
    for j = 1:NumConditions
        VariableData = [];
        VariableHeading = [];
        Condition = char(eval(strcat('Condition',num2str(j))));
        ConditionTrials = char(strcat(Condition,{' - '},'Trials'));
        for k = 1:3
            Filename = eval(strcat('Filename',num2str(k)));
            [a,b,c] = xlsread(Filename,ConditionTrials);
            VariableData = horzcat(VariableData,a(:,length(Exp)+1:end));
            VariableHeading = horzcat(VariableHeading,b(1,length(Exp)+1:end));
        end
        v = strcat('Condition',num2str(j),'Data');
        evalc([v ' = VariableData']);
    end
    
    [x,HeadOnset] = find(strcmp(('Head Yaw Onset'), VariableHeading));
    [x,ThoraxOnset] = find(strcmp(('Thorax Yaw Onset'), VariableHeading));
    [x,PelvisOnset] = find(strcmp(('Pelvis Yaw Onset'), VariableHeading));
    [x,EyeOnset] =find(strcmp(('Fast Phase 1 Onset'), VariableHeading));
    [x,LeadStepOnset] = find(strcmp(('Step 1 Onset Latency'), VariableHeading));
    [x,TrailStepOnset] = find(strcmp(('Step 2 Onset Latency'), VariableHeading));
    
    for j = 1:NumConditions
        u = eval(strcat('Condition',num2str(j),'Data'));
        Mean(j,1) = nanmean(u(:,HeadOnset));
        Mean(j,2) = nanmean(u(:,ThoraxOnset));
        Mean(j,3) = nanmean(u(:,PelvisOnset));
        Mean(j,4) = nanmean(u(:,EyeOnset));
        Mean(j,5) = nanmean(u(:,LeadStepOnset));
        Mean(j,6) = nanmean(u(:,TrailStepOnset));
        SD(j,1) = nanstd(u(:,HeadOnset));
        SD(j,2) = nanstd(u(:,ThoraxOnset));
        SD(j,3) = nanstd(u(:,PelvisOnset));
        SD(j,4) = nanstd(u(:,EyeOnset));
        SD(j,5) = nanstd(u(:,LeadStepOnset));
        SD(j,6) = nanstd(u(:,TrailStepOnset));
        SE(j,1) = ste(u(:,HeadOnset));
        SE(j,2) = ste(u(:,ThoraxOnset));
        SE(j,3) = ste(u(:,PelvisOnset));
        SE(j,4) = ste(u(:,EyeOnset));
        SE(j,5) = ste(u(:,LeadStepOnset));
        SE(j,6) = ste(u(:,TrailStepOnset));
        CI(j,1) = diff(ci(u(:,HeadOnset)));
        CI(j,2) = diff(ci(u(:,ThoraxOnset)));
        CI(j,3) = diff(ci(u(:,PelvisOnset)));
        CI(j,4) = diff(ci(u(:,EyeOnset)));
        CI(j,5) = diff(ci(u(:,LeadStepOnset)));
        CI(j,6) = diff(ci(u(:,TrailStepOnset)));
    end
    
    Mean = Mean';
    SD = SD';
    SE = SE';
    CI = CI';
    
    ErrorBar = input('Which value to use for error bars?\n(1)SD\n(2)SE\n(3)CI\n ');
    
    scrsz = get(0,'ScreenSize');
    figure('Position',scrsz);
    
    h = bar(Mean);
    hold on
    bar(Mean);
    set(h,'BarWidth',1);
    colormap(bone);
    
    for j = 1:NumConditions
        Legend(:,j) = strcat(eval(strcat('Condition',num2str(j)))); %#ok<*SAGROW>
    end
    
    set(gca,'XTickLabel',{'Head','Thorax','Pelvis','Eye','Lead Foot','Trail Foot'})
    lh = legend(Legend,'Location','NorthWest');
    hold on;
    numgroups = size(Mean, 1);
    numbars = size(Mean, 2);
    
    groupwidth = min(0.8, numbars/(numbars+1.5));
    %%text(0,1,'*')
    for i = 1:numbars
        % Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
        x = (1:numgroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*numbars);  % Aligning error bar with individual bar
        if ErrorBar==1
            errorbar(x, Mean(:,i), SD(:,i), 'k', 'linestyle', 'none');
        elseif ErrorBar==2
            errorbar(x, Mean(:,i), SE(:,i), 'k', 'linestyle', 'none');
        elseif ErrorBar==3
            errorbar(x, Mean(:,i), CI(:,i), 'k', 'linestyle', 'none');
        end
    end
    
elseif RunStep==2
    
    Exp = {'Participant'};
    load('ExpInfo');
    [j,k] = size(ExpConditions); %#ok<*NODEF,*ASGLU>
    for c = 1:j
        Exp = horzcat(Exp,ExpConditions(c,1)); %#ok<*AGROW>
    end
    Exp = horzcat(Exp,'Trial Number');
    Filename1 = sprintf(char(strcat(ExpName,{' '},'Axial Segment Data - Direction Collapsed.xlsx'))); %#ok<*NASGU>
    Filename2 = sprintf(char(strcat(ExpName,{' '},'Eye Data - Direction Collapsed.xlsx')));
    Filename3 = sprintf(char(strcat(ExpName,{' '},'Stepping Data - Direction Collapsed.xlsx')));
    NumConditions = (prod(cell2mat(ExpConditions(:,2))))/2;
    %TrialsPerCondition = NumTrials/NumConditions;
    %[row,col] = size(ExpConditions);
    load('ParticipantList');
    ParticipantID = char(ParticipantList(1,1));
    load(char(strcat(ExpName,{' '},ParticipantID,{' '},'Axial Segment Data.mat')));
    [row,col] = size(Condition1);
    for i = 1:NumConditions
        if col==1
        elseif col==2
            CollapsedCondition = eval(strcat('Condition',num2str((i*2)-1)));
            CollapsedCondition = CollapsedCondition(1,2);
            u = strcat('CollapsedCondition',num2str(i));
            evalc([u ' = CollapsedCondition']);
        elseif col==3
            CollapsedCondition = eval(strcat('Condition',num2str((i*2)-1)));
            CollapsedCondition = strcat(CollapsedCondition(1,2),{' '},CollapsedCondition(1,3));
            u = strcat('CollapsedCondition',num2str(i));
            evalc([u ' = CollapsedCondition']);
        end
    end
    
    for j = 1:NumConditions
        VariableData = [];
        VariableHeading = [];
        CollapsedCondition = char(eval(strcat('CollapsedCondition',num2str(j))));
        CollapsedConditionTrials = char(strcat(CollapsedCondition,{' - '},'Trials'));
        for k = 1:3
            Filename = eval(strcat('Filename',num2str(k)));
            [a,b,c] = xlsread(Filename,CollapsedConditionTrials);
            VariableData = horzcat(VariableData,a(:,length(Exp)+1:end));
            VariableHeading = horzcat(VariableHeading,b(1,length(Exp)+1:end));
        end
        v = strcat('CollapsedCondition',num2str(j),'Data');
        evalc([v ' = VariableData']);
    end
    
    [x,HeadOnset] = find(strcmp(('Head Yaw Onset'), VariableHeading));
    [x,ThoraxOnset] = find(strcmp(('Thorax Yaw Onset'), VariableHeading));
    [x,PelvisOnset] = find(strcmp(('Pelvis Yaw Onset'), VariableHeading));
    [x,EyeOnset] =find(strcmp(('Fast Phase 1 Onset'), VariableHeading));
    [x,LeadStepOnset] = find(strcmp(('Step 1 Onset Latency'), VariableHeading));
    [x,TrailStepOnset] = find(strcmp(('Step 2 Onset Latency'), VariableHeading));
    
    for j = 1:NumConditions
        u = eval(strcat('CollapsedCondition',num2str(j),'Data'));
        Mean(j,1) = nanmean(u(:,HeadOnset));
        Mean(j,2) = nanmean(u(:,ThoraxOnset));
        Mean(j,3) = nanmean(u(:,PelvisOnset));
        Mean(j,4) = nanmean(u(:,EyeOnset));
        Mean(j,5) = nanmean(u(:,LeadStepOnset));
        Mean(j,6) = nanmean(u(:,TrailStepOnset));
        SD(j,1) = nanstd(u(:,HeadOnset));
        SD(j,2) = nanstd(u(:,ThoraxOnset));
        SD(j,3) = nanstd(u(:,PelvisOnset));
        SD(j,4) = nanstd(u(:,EyeOnset));
        SD(j,5) = nanstd(u(:,LeadStepOnset));
        SD(j,6) = nanstd(u(:,TrailStepOnset));
        SE(j,1) = ste(u(:,HeadOnset));
        SE(j,2) = ste(u(:,ThoraxOnset));
        SE(j,3) = ste(u(:,PelvisOnset));
        SE(j,4) = ste(u(:,EyeOnset));
        SE(j,5) = ste(u(:,LeadStepOnset));
        SE(j,6) = ste(u(:,TrailStepOnset));
        CI(j,1) = diff(ci(u(:,HeadOnset)));
        CI(j,2) = diff(ci(u(:,ThoraxOnset)));
        CI(j,3) = diff(ci(u(:,PelvisOnset)));
        CI(j,4) = diff(ci(u(:,EyeOnset)));
        CI(j,5) = diff(ci(u(:,LeadStepOnset)));
        CI(j,6) = diff(ci(u(:,TrailStepOnset)));
    end
    
    Mean = Mean';
    SD = SD';
    SE = SE';
    CI = CI';
    
    ErrorBar = input('Which value to use for error bars?\n(1)SD\n(2)SE\n(3)CI\n ');
    
    scrsz = get(0,'ScreenSize');
    figure('Position',scrsz);
    
    h = bar(Mean);
    hold on
    bar(Mean);
    set(h,'BarWidth',1);
    colormap(bone);
    
    for j = 1:NumConditions
        Legend(:,j) = strcat(eval(strcat('CollapsedCondition',num2str(j)))); %#ok<*SAGROW>
    end
    
    set(gca,'XTickLabel',{'Head','Thorax','Pelvis','Eye','Lead Foot','Trail Foot'})
    lh = legend(Legend,'Location','NorthWest');
    hold on;
    numgroups = size(Mean, 1);
    numbars = size(Mean, 2);
    
    groupwidth = min(0.8, numbars/(numbars+1.5));
    %%text(0,1,'*')
    for i = 1:numbars
        % Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
        x = (1:numgroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*numbars);  % Aligning error bar with individual bar
        if ErrorBar==1
            errorbar(x, Mean(:,i), SD(:,i), 'k', 'linestyle', 'none');
        elseif ErrorBar==2
            errorbar(x, Mean(:,i), SE(:,i), 'k', 'linestyle', 'none');
        elseif ErrorBar==3
            errorbar(x, Mean(:,i), CI(:,i), 'k', 'linestyle', 'none');
        end
    end
end

clear
clc