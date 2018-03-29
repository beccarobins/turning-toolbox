%Run through one by one to perform specific analysis on data
%Add 'MATLAB Scripts' folder to path
%Add this script to participant LED folder

RunStep = input('Choose analysis to run:\n(1)Stroop\n(2)Serial Subtraction\n');

if RunStep == 1
    Stroop
elseif RunStep == 2
    Serial_Subtraction
end