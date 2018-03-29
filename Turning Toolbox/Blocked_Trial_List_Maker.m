function Blocked_Trial_List_Maker
load('ExpInfo');

NumConditions= prod(cell2mat(ExpConditions(:,2))); %#ok<*NODEF,*NASGU>
[X,Y] = size(ExpConditions); %#ok<*ASGLU>
for j = 1:X
    IndependentVariables(j,1) = {j}; %#ok<*AGROW>
    IndependentVariables(j,2) = ExpConditions(j,1);
end

disp(IndependentVariables)
k = input('Which condition is blocked?\n');

RandConditions = {};
for j = 1:X
    if j~=k
        RandConditions = vertcat(RandConditions,ExpConditions(j,:));
    end
end

ExpBlocks = cell2mat(ExpConditions(k,2));
TrialsPerExpBlock = NumTrials/ExpBlocks;

[X,Y] = size(RandConditions);

TrialConditions = {};
TrialConditions1 = {};
TrialConditions2 = {};
TrialConditions3 = {};

if X==1
    for h = 1:cell2mat(RandConditions(1,2))
        TrialConditions1(h,:) = RandConditions(1,h+2);
    end
    Condition = TrialConditions1;
    for j = 1:NumTrials/cell2mat(RandConditions(1,2));
        TrialConditions= vertcat(TrialConditions,Condition);
    end
end

if X==2
    ConditionTrials = NumTrials/cell2mat(RandConditions(1,2));
    for g = 1:cell2mat(RandConditions(1,2));
        for h = 1:ConditionTrials;
            TrialConditions1(h,:) = RandConditions(1,3);
            for i =(h+ConditionTrials):ConditionTrials*2;
                TrialConditions1(i,:) = RandConditions(1,4);
                if cell2mat(RandConditions(1,2))>=3
                    for j=(i+ConditionTrials):ConditionTrials*3;
                        TrialConditions1(j,:) = RandConditions(1,5);
                        if cell2mat(RandConditions(1,2))>=4
                            for k =(j+ConditionTrials):ConditionTrials*4;
                                TrialConditions1(k,:) = RandConditions(1,6);
                            end
                        end
                    end
                end
                
            end
        end
    end
    for h = 1:cell2mat(RandConditions(2,2))
        TrialConditions2(h,:) = RandConditions(2,h+2);
    end
    Condition = TrialConditions2;
    TrialConditions2 = {};
    for j = 1:NumTrials/cell2mat(RandConditions(2,2));
        TrialConditions2= vertcat(TrialConditions2,Condition);
    end
end

TrialConditions = horzcat(TrialConditions1,TrialConditions2,TrialConditions3);

Condition = TrialConditions;
TrialList = {};

for j = 1:TrialsPerExpBlock/(length(Condition));
    TrialList= vertcat(TrialList,Condition);
end

Block1 = {};
Block2 = {};
Block3 = {};
Block4 = {};

for j = 1:ExpBlocks
    u = strcat('Block',num2str(j));
    evalc([u ' = ExpConditions(k,j+2)']);
end

if ExpBlocks>1
    Block1(1:TrialsPerExpBlock,:) = Block1;
    Block2(1:TrialsPerExpBlock,:) = Block2;
    TrialList1 = horzcat(Block1,TrialList);
    TrialList2 = horzcat(Block2,TrialList);
end
if ExpBlocks>2
    Block3(1:TrialsPerExpBlock,:) = Block3;
    TrialList3 = horzcat(Block3,TrialList);
end
if ExpBlocks>3
    Block4(1:TrialsPerExpBlock,:) = Block4;
    TrialList4 = horzcat(Block4,TrialList);
end

BlockList1 = {};
BlockList2 = {};
BlockList3 = {};
BlockList4 = {};

for j = 1:ExpBlocks
    TrialList = eval(strcat('TrialList',num2str(j)));
    Rand = num2cell(rand(TrialsPerExpBlock,1));
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
    u = strcat('BlockList',num2str(j));
    evalc([u ' = TrialList']);
end

BlockArrangements = 1;

for j = 1:ExpBlocks
    BlockArrangements = BlockArrangements*j;
end

if BlockArrangements == 2
    Arrangements = [1,2;2,1];
elseif BlockArrangements == 6
    Arrangements = [1,2,3;1,3,2;2,1,3;2,3,1;3,1,2;3,2,1];
elseif BlockArrangements == 24
    Arrangements = [1,2,3,4;1,2,4,3;1,3,2,4;1,3,4,2;1,4,2,3;1,4,3,2;...
        2,1,3,4;2,1,4,3;2,3,1,4;2,3,4,1;2,4,1,3;2,4,3,1;...
        3,1,2,4;3,1,4,2;3,2,1,4;3,2,4,1;3,4,1,2;3,4,2,1;...
        4,1,2,3;4,1,3,2;4,2,1,3;4,2,3,1;4,3,1,2;4,3,2,1;];
end

NumParticipants = strcat('For this experiment you need to use',{' '},num2str(BlockArrangements),'x',' participants');
disp(NumParticipants)
pause

if ExpBlocks>1
Block1 = Block1(1,1);
Block2 = Block2(1,1);
end
if ExpBlocks>2
Block3 = Block3(1,1);
end
if ExpBlocks>3
Block4 = cBlock4(1,1);
end

clearvars -except Arrangements Block1 Block2 Block3 Block4 BlockArrangements BlockList1 BlockList2 BlockList3 BlockList4 Blocks EOGSampFreq ExpBlocks ExpConditions ExpDesign ExpName Filename MoCapSampFreq NumCal NumParticipants NumTrials PreTrialLength TrialsPerExpBlock
save('ExpInfo');

display('Open the main folder where you would like your data saved');
Destination = uigetdir;
copyfile('ExpInfo.mat',Destination,'f');
movefile(Filename,Destination);
clc