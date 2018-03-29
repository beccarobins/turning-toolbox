%Run through one by one to perform analysis on turning data
%Add 'MATLAB Scripts' folder to path
%Add this script to participant LED folder
%*Requires manual input

opengl('save','software')

RunStep = input('Choose analysis to run:\n(0)Move to new participant folder\n(1)Import LED\n(2)Import Kinematics\n(3)Import EOG*\n(4)Differentiate Displacement\n(5)Dependent Variables\n(6)Determine Axial Rotation Times*\n(7)Normalize Data\n(8)Process Nystagmus*\n(9)Fix Gimbal Lock*\n(10)Process Steps\n(11)Export Axial Segment Data\n(12)Export Eye Data\n(13)Export Step Data\n(14)Export Individual Fast Phases\n(15)Export Segment Positions\n ');

if RunStep == 0
    Move_to_Participant_Folder
elseif RunStep == 1
    Import_LED
    %Data moves to Kinematics folder
elseif RunStep == 2
    Import_Kinematics
    %Data moves to EOG folder
elseif RunStep == 3
    Import_EOG
    %Data moves to MATLAB folder
elseif RunStep == 4
    Differentiate_Displacement
elseif RunStep == 5
    Dependent_Variables
elseif RunStep == 6
    Determine_Axial_Rotation_Times
elseif RunStep == 7
    Normalize_Data
elseif RunStep == 8
    Process_Nystagmus
elseif RunStep == 9
    Fix_Gimbal_Lock
elseif RunStep == 10
    Process_Steps
elseif RunStep == 11
    Export_Axial_Segment_Data
elseif RunStep == 12
    Export_Eye_Data
elseif RunStep == 13
    Export_Stepping_Data
elseif RunStep == 14
    Export_Individual_Fast_Phases
elseif RunStep == 15
    Export_Segment_Positions
end