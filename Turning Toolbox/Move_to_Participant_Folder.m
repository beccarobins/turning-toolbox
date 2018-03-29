clear;
display('Move to participant folder for analysis');
folder_name = uigetdir; %select participant folder
newname = strsplit(folder_name,'\');
subject = char(newname(1,end));

Question = input('Which sub-folder would you like to move to?\n(1)LED\n(2)Kinematics\n(3)EOG\n(4)MATLAB\n');

if Question==1
    sub_folder = [folder_name '\' subject ' - LED'];
elseif Question==2
    sub_folder = [folder_name '\' subject ' - Kinematics'];
elseif Question==3
    sub_folder = [folder_name '\' subject ' - EOG'];
elseif Question==4
    sub_folder = [folder_name '\' subject ' - MATLAB'];
end

cd(sub_folder)

Question = input('Would you like to analyse this data?\n(0)No\n(1)Yes\n');

if Question==1
    Turning_Analysis
else
clr
end