function Create_New_Participant

ParticipantID = input('What is the ID of the new participant?\n','s');
save('ParticipantID','ParticipantID');

ExpBlocks = [];

load('ExpInfo')

TF = strcmp(ExpDesign,'Blocked');

if TF==1
    for j = 1:BlockArrangements
        BlockOrder(j,1) = {j}; %#ok<*AGROW>
        for k = 1:ExpBlocks %#ok<*BDSCI>
            BlockOrder(j,k+1) = eval(strcat('Block',num2str(Arrangements(j,k))));
        end
    end
    disp(BlockOrder)
    i = input('Which block order to use for this participant?\n');
    BlockOrder = i;
    
    Filename = sprintf(strcat(ExpName,' Trial List.xlsx'));
end

if ExpBlocks==2
    TrialConditions = vertcat(eval(strcat('BlockList',num2str(Arrangements(i,1)))),eval(strcat('BlockList',num2str(Arrangements(i,2))))); %#ok<*NASGU>
    FirstBlock = eval(strcat('BlockList',num2str(Arrangements(i,1))));
    SecondBlock = eval(strcat('BlockList',num2str(Arrangements(i,2))));
    [row,col] = size(BlockList1);
    for j = 1:row;
        if col==1
        elseif col==2
            FirstBlock(j,1) = strcat(FirstBlock(j,1),{' '},FirstBlock(j,2));
            SecondBlock(j,1) = strcat(SecondBlock(j,1),{' '},SecondBlock(j,2));
        elseif col==3
            FirstBlock(j,1) = strcat(FirstBlock(j,1),{' '},FirstBlock(j,2),FirstBlock(j,3));
            SecondBlock(j,1) = strcat(SecondBlock(j,1),{' '},SecondBlock(j,2),SecondBlock(j,3));
        end
    end
    FirstBlock = FirstBlock(:,1);
    SecondBlock = SecondBlock(:,1);
    copyfile('Blocked Trial List2.xlsx',Filename)
    xlswrite(Filename,FirstBlock,'Sheet1','C8');
    xlswrite(Filename,SecondBlock,'Sheet1','F8');
elseif ExpBlocks==3
    TrialConditions = vertcat(eval(strcat('BlockList',num2str(Arrangements(i,1)))),eval(strcat('BlockList',num2str(Arrangements(i,2)))),eval(strcat('BlockList',num2str(Arrangements(i,3)))));
    FirstBlock = eval(strcat('BlockList',num2str(Arrangements(i,1))));
    SecondBlock = eval(strcat('BlockList',num2str(Arrangements(i,2))));
    ThirdBlock = eval(strcat('BlockList',num2str(Arrangements(i,3))));
    [row,col] = size(BlockList1);
    for j = 1:row;
        if col==1
        elseif col==2
            FirstBlock(j,1) = strcat(FirstBlock(j,1),{' '},FirstBlock(j,2));
            SecondBlock(j,1) = strcat(SecondBlock(j,1),{' '},SecondBlock(j,2));
            ThirdBlock(j,1) = strcat(ThirdBlock(j,1),{' '},ThirdBlock(j,2));
        elseif col==3
            FirstBlock(j,1) = strcat(FirstBlock(j,1),{' '},FirstBlock(j,2),{' '},FirstBlock(j,3));
            SecondBlock(j,1) = strcat(SecondBlock(j,1),{' '},SecondBlock(j,2),{' '},SecondBlock(j,3));
            ThirdBlock(j,1) = strcat(ThirdBlock(j,1),{' '},ThirdBlock(j,2),{' '},ThirdBlock(j,3));
        end
    end
    FirstBlock = FirstBlock(:,1);
    SecondBlock = SecondBlock(:,1);
    ThirdBlock = ThirdBlock(:,1);
    copyfile('Blocked Trial List3.xlsx',Filename)
    xlswrite(Filename,FirstBlock,'Sheet1','C8');
    xlswrite(Filename,SecondBlock,'Sheet1','F8');
    xlswrite(Filename,ThirdBlock,'Sheet1','C53');
elseif ExpBlocks==4
    TrialConditions = vertcat(eval(strcat('BlockList',num2str(Arrangements(i,1)))),eval(strcat('BlockList',num2str(Arrangements(i,2)))),eval(strcat('BlockList',num2str(Arrangements(i,3)))),eval(strcat('BlockList',num2str(Arrangements(i,4)))));
    FirstBlock = eval(strcat('BlockList',num2str(Arrangements(i,1))));
    SecondBlock = eval(strcat('BlockList',num2str(Arrangements(i,2))));
    ThirdBlock = eval(strcat('BlockList',num2str(Arrangements(i,3))));
    FourthBlock = eval(strcat('BlockList',num2str(Arrangements(i,4))));
    [row,col] = size(BlockList1);
    for j = 1:row;
        if col==1
        elseif col==2
            FirstBlock(j,1) = strcat(FirstBlock(j,1),{' '},FirstBlock(j,2));
            SecondBlock(j,1) = strcat(SecondBlock(j,1),{' '},SecondBlock(j,2));
            ThirdBlock(j,1) = strcat(ThirdBlock(j,1),{' '},ThirdBlock(j,2));
            FourthBlock(j,1) = strcat(FourthBlock(j,1),{' '},FourthBlock(j,2));
        elseif col==3
            FirstBlock(j,1) = strcat(FirstBlock(j,1),{' '},FirstBlock(j,2),{' '},FirstBlock(j,3));
            SecondBlock(j,1) = strcat(SecondBlock(j,1),{' '},SecondBlock(j,2),{' '},SecondBlock(j,3));
            ThirdBlock(j,1) = strcat(ThirdBlock(j,1),{' '},ThirdBlock(j,2),{' '},ThirdBlock(j,3));
            FourthBlock(j,1) = strcat(FourthBlock(j,1),{' '},FourthBlock(j,2),{' '},FourthBlock(j,3));
        end
    end
    FirstBlock = FirstBlock(:,1);
    SecondBlock = SecondBlock(:,1);
    ThirdBlock = ThirdBlock(:,1);
    FourthBlock = FourthBlock(:,1);
    copyfile('Blocked Trial List4.xlsx',Filename)
    xlswrite(Filename,FirstBlock,'Sheet1','C8');
    xlswrite(Filename,SecondBlock,'Sheet1','F8');
    xlswrite(Filename,ThirdBlock,'Sheet1','C53');
    xlswrite(Filename,FourthBlock,'Sheet1','F53');
end

mkdir(ParticipantID);
mkdir(strcat(ParticipantID,' - EOG'));
mkdir(strcat(ParticipantID,' - LED'));
mkdir(strcat(ParticipantID,' - Kinematics'));
mkdir(strcat(ParticipantID,' - MATLAB'));
mkdir(strcat(ParticipantID,' - Figures'));

clearvars -except Arrangements Block1 Block2 Block3 Block4 BlockArrangements BlockList1 BlockList2 BlockList3 BlockList4 BlockOrder Blocks EOGSampFreq ExpBlocks ExpConditions ExpDesign ExpName Filename MoCapSampFreq NumCal NumParticipants NumTrials ParticipantID PreTrialLength TrialLength TrialsPerExpBlock TrialConditions TrialList
save('ExpInfo');

Destination = strcat(ParticipantID,' - LED');
movefile('ParticipantID.mat',Destination);
copyfile('ExpInfo.mat',Destination);
%copyfile('dummytrial.m',Destination);
% change script runner as necessary
%copyfile('Turning_Analysis.m',Destination)
%copyfile('Turning_Visualisation.m',Destination)

TF = strcmp(ExpDesign,'Blocked');

if TF==1
movefile(Filename,ParticipantID)
end

Destination = ParticipantID;
movefile(strcat(ParticipantID,' - EOG'),Destination);
movefile(strcat(ParticipantID,' - LED'),Destination);
movefile(strcat(ParticipantID,' - Kinematics'),Destination);
movefile(strcat(ParticipantID,' - MATLAB'),Destination);
movefile(strcat(ParticipantID,' - Figures'),Destination);

load('ParticipantList');

if TF==1
    ParticipantID_BlockOrder = horzcat(cellstr(ParticipantID),num2cell(BlockOrder));
    ParticipantList = vertcat(ParticipantList,ParticipantID_BlockOrder); %#ok<*NODEF>
    ParticipantList = sortrows(ParticipantList);
elseif TF==0
    ParticipantList = vertcat(ParticipantList,ParticipantID); %#ok<*NODEF>
    ParticipantList = sort(ParticipantList);
end

save('ParticipantList','ParticipantList');

display('Open the main folder where you would like your data saved');
Destination = uigetdir;
copyfile('ParticipantList.mat',Destination);
movefile(ParticipantID,Destination);

clearvars -except Arrangements Block1 Block2 Block3 Block4 BlockArrangements BlockList1 BlockList2 BlockList3 BlockList4 Blocks EOGSampFreq ExpBlocks ExpConditions ExpDesign ExpName MoCapSampFreq NumCal NumParticipants NumTrials PreTrialLength TrialLength TrialsPerExpBlock TrialList
save('ExpInfo');

clc