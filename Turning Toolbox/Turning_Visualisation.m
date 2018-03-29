%Run through one by one to perform analysis on turning data
%Add 'MATLAB Scripts' folder to path
%Add this script to participant LED folder

RunStep = input('Choose graph to create:\n(1)Axial Segment Displacements\n(2)Axial Segment Displacement & Velocity\n(3)Fast Phases\n(4)Head Stabilization\n(5)Onset Latencies\n(6)Overlayed Segment Displacements\n(7)Segment Displacement Subplots\n(8)Segment Separation\n(9)Steps\n(10)Yaw Gain\n ');

if RunStep == 1
    Plot_Axial_Segment_Displacement
elseif RunStep == 2
    Plot_Axial_Segment_Displacement_Velocity
elseif RunStep == 3
    Plot_Fast_Phases
elseif RunStep == 4
    Plot_Head_Stabilization
elseif RunStep == 5
    Plot_Trial_Latency_Bar_Graph
elseif RunStep == 6
    Plot_Overlayed_Segment_Displacement
elseif RunStep == 7
    Plot_Displacement_Subplots
elseif RunStep == 8
    Plot_Segment_Separation
elseif RunStep == 9
    Plot_Steps
elseif RunStep == 10
    Plot_Yaw_Gain
end

clear
clc