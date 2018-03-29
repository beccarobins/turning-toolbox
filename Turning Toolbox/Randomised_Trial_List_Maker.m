function Randomised_Trial_List_Maker

load('ExpInfo');
NumConditions= prod(cell2mat(ExpConditions(:,2))); %#ok<*NODEF,*NASGU>
[X,Y] = size(ExpConditions); %#ok<*ASGLU>
TrialConditions = {};
TrialConditions1 = {};
TrialConditions2 = {};
TrialConditions3 = {};

if X==1
    for h = 1:cell2mat(ExpConditions(1,2))
        TrialConditions1(h,:) = ExpConditions(1,h+2); %#ok<*AGROW>
    end
    Condition = TrialConditions1;
    for j = 1:NumTrials/cell2mat(ExpConditions(1,2));
        TrialConditions= vertcat(TrialConditions,Condition);
    end
end

if X==2
    ConditionTrials = NumTrials/cell2mat(ExpConditions(1,2));
    for g = 1:cell2mat(ExpConditions(1,2));
        for h = 1:ConditionTrials;
            TrialConditions1(h,:) = ExpConditions(1,3);
            for i =(h+ConditionTrials):ConditionTrials*2;
                TrialConditions1(i,:) = ExpConditions(1,4);
                if cell2mat(ExpConditions(1,2))>=3
                    for j=(i+ConditionTrials):ConditionTrials*3;
                        TrialConditions1(j,:) = ExpConditions(1,5);
                        if cell2mat(ExpConditions(1,2))>=4
                            for k =(j+ConditionTrials):ConditionTrials*4;
                                TrialConditions1(k,:) = ExpConditions(1,6);
                            end
                        end
                    end
                end
                
            end
        end
    end
    for h = 1:cell2mat(ExpConditions(2,2))
        TrialConditions2(h,:) = ExpConditions(2,h+2);
    end
    Condition = TrialConditions2;
    TrialConditions2 = {};
    for j = 1:NumTrials/cell2mat(ExpConditions(2,2));
        TrialConditions2= vertcat(TrialConditions2,Condition);
    end
end

if X ==3
    ConditionTrials = NumTrials/cell2mat(ExpConditions(1,2));
    for g = 1:cell2mat(ExpConditions(1,2));
        for h = 1:ConditionTrials;
            TrialConditions1(h,:) = ExpConditions(1,3);
            for i =(h+ConditionTrials):ConditionTrials*2;
                TrialConditions1(i,:) = ExpConditions(1,4);
                if cell2mat(ExpConditions(1,2))>=3
                    for j=(i+ConditionTrials):ConditionTrials*3;
                        TrialConditions1(j,:) = ExpConditions(1,5);
                        if cell2mat(ExpConditions(1,2))>=4
                            for k =(j+ConditionTrials):ConditionTrials*4;
                                TrialConditions1(k,:) = ExpConditions(1,6);
                            end
                        end
                    end
                end
                
            end
        end
    end
    ConditionTrials = ConditionTrials/cell2mat(ExpConditions(2,2));
    for g = 1:cell2mat(ExpConditions(2,2));
        for h = 1:ConditionTrials;
            TrialConditions2(h,:) = ExpConditions(2,3);
            for i =(h+ConditionTrials):ConditionTrials*2;
                TrialConditions2(i,:) = ExpConditions(2,4);
                if cell2mat(ExpConditions(2,2))>=3
                    for j=(i+ConditionTrials):ConditionTrials*3;
                        TrialConditions2(j,:) = ExpConditions(2,5);
                        if cell2mat(ExpConditions(2,2))>=4
                            for k =(j+ConditionTrials):ConditionTrials*4;
                                TrialConditions2(k,:) = ExpConditions(2,6);
                            end
                        end
                    end
                end
                
            end
        end
    end
    Condition = TrialConditions2;
    TrialConditions2 = {};
    for j = 1:NumTrials/length(Condition);
        TrialConditions2= vertcat(TrialConditions2,Condition);
    end
    
    for h = 1:cell2mat(ExpConditions(3,2))
        TrialConditions3(h,:) = ExpConditions(3,h+2);
    end
    Condition = TrialConditions3;
    TrialConditions3 = {};
    for j = 1:NumTrials/cell2mat(ExpConditions(3,2));
        TrialConditions3= vertcat(TrialConditions3,Condition);
    end
end

TrialConditions = horzcat(TrialConditions1,TrialConditions2,TrialConditions3);

Condition = TrialConditions;
TrialList = {};

for j = 1:NumTrials/(length(Condition));
    TrialList= vertcat(TrialList,Condition);
end

Rand = num2cell(rand(NumTrials,1));
TrialList(:,end+1) = Rand;
[row,col] = size(TrialList);
TrialList = sortrows(TrialList,col);
TrialList = TrialList(:,1:end-1);

if X==1
    TF = strcmpi(TrialList(j,1),TrialList(j+1,1));
    if TF == 1
        TrialList([j+1 j+2],:) = TrialList([j+2 j+1],:);
    elseif TF==0
    end
end
if X==2
    TF = strcmpi(TrialList(j,1),TrialList(j+1,1));
    if TF == 1;
        TF = strcmpi(TrialList(j,2),TrialList(j+1,2));
        if TF == 1
            TrialList([j+1 j+2],:) = TrialList([j+2 j+1],:);
        elseif TF == 0;
        end
    end
end
if X==3
    TF = strcmpi(TrialList(j,1),TrialList(j+1,1));
    if TF == 1;
        TF = strcmpi(TrialList(j,2),TrialList(j+1,2));
        if TF == 1;
            TF = strcmpi(TrialList(j,3),TrialList(j+1,3));
            if TF == 1;
                TrialList([j+1 j+2],:) = TrialList([j+2 j+1],:);
            elseif TF == 0;
            end
        end
    end
end
[row,col] = size(TrialList);
for j = 1:row;
    if col==1
        ExportTrialList = TrialList;
    elseif col==2
        ExportTrialList(j,1) = strcat(TrialList(j,1),{' '},TrialList(j,2));
    elseif col==3
        ExportTrialList(j,1) = strcat(TrialList(j,1),{' '},TrialList(j,2),{' '},TrialList(j,3));
    end
end

Filename = sprintf(strcat(ExpName,' Trial List.xlsx'));
xlswrite(Filename,{ExpName},'Sheet1','A1');
if NumTrials<=40
    xlswrite(Filename,ExportTrialList(:,1),'Sheet1','C6');
elseif NumTrials>40
    Rows = NumTrials/2;
    TrialList_1 = ExportTrialList(1:Rows,1);
    TrialList_2 = ExportTrialList(Rows+1:end,1);
    xlswrite(Filename,TrialList_1,'Sheet1','C6');
    xlswrite(Filename,TrialList_2,'Sheet1','F6');
end

%add other variables as necessary
clearvars -except Filename Blocks EOGSampFreq ExpConditions ExpDesign ExpName MoCapSampFreq NumCal NumTrials PreTrialLength TrialConditions TrialLength TrialList
save('ExpInfo');

display('Open the main folder where you would like your data saved');
Destination = uigetdir;
copyfile('ExpInfo.mat',Destination,'f');
movefile(Filename,Destination);
clear