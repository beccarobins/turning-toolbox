%Run through one by one to perform analysis on turning data
%Add 'MATLAB Scripts' folder to path
%Add this script to participant LED folder

opengl('save','software')

RunStep = input('Choose analysis to run:\n(1)Compile Axial Segment Data\n(2)Compile Eye Data\n(3)Compile Stepping Data\n(4)Compile Individual Fast Phases\n(5)Compile Segment Position Data\n(6)Plots Onset Latencies\n(7)Plot Bargraphs\n(8)Plot Scatterplots\n(9)Plot Boxplots\n(10)Plot Histograms\n(11)Plot Segment Position Bargraphs\n ');

if RunStep == 1
    Compile_Axial_Segment_Data
elseif RunStep == 2
    Compile_Eye_Data
elseif RunStep == 3
    Compile_Stepping_Data
elseif RunStep == 4
    Compile_Individual_Fast_Phases
elseif RunStep == 5
    Compile_Segment_Positions
elseif RunStep == 6
    Plot_Onset_Latencies
elseif RunStep == 7
    Plot_BarGraphs
elseif RunStep == 8
    Plot_Scatterplots
elseif RunStep == 9
    Plot_Boxplots
elseif RunStep == 10
    Plot_Histograms
    elseif RunStep == 11
    Plot_Segment_Position_Bargraphs
end

clear