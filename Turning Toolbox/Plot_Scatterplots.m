function Plot_Scatterplots
Exp = {'Participant'};
load('ExpInfo');
[j,k] = size(ExpConditions);
for c = 1:j
    Exp = horzcat(Exp,ExpConditions(c,1)); %#ok<*AGROW>
end
Exp = horzcat(Exp,'Trial Number');

VariableData = [];
VariableHeading = [];
Filename = sprintf(char(strcat(ExpName,{' '},'Axial Segment Data.xlsx')));
[a,b,c] = xlsread(Filename,'All Trials'); %#ok<*ASGLU>
VariableData = horzcat(VariableData,a(:,length(Exp)+1:end));
VariableHeading = horzcat(VariableHeading,b(1,length(Exp)+1:end));
Filename = sprintf(char(strcat(ExpName,{' '},'Eye Data.xlsx')));
[a,b,c] = xlsread(Filename,'All Trials');
VariableData = horzcat(VariableData,a(:,length(Exp)+1:end));
VariableHeading = horzcat(VariableHeading,b(1,length(Exp)+1:end));
Filename = sprintf(char(strcat(ExpName,{' '},'Stepping Data.xlsx')));
[a,b,c] = xlsread(Filename,'All Trials');
VariableData = horzcat(VariableData,a(:,length(Exp)+1:end));
VariableHeading = horzcat(VariableHeading,b(1,length(Exp)+1:end));

for j = 1:(length(VariableData))-1;
    for k = 2:length(VariableData);
        x = VariableData(:,j);
        y = VariableData(:,k);
        validx = ~isnan(x);
        validy = ~isnan(y);
        validdata = validx & validy;
        x1 = x(validdata);
        y1 = y(validdata);
        A = isempty(x1);
        B = isempty(y1);
        if A||B ==1;
        else
            RValue = corr(x1,y1);
            RSquared = RValue^2;
            if RSquared>=0.6
                plot(x,y,'k.');
                hold on
                %Text =
                XTitle = VariableHeading(1,j);
                YTitle = VariableHeading(1,k);
                xlabel (XTitle,'FontSize',14);
                ylabel (YTitle,'FontSize',14);
                R2 = strcat('R^2 =',{' '},num2str(RSquared));
                legend(R2,'NorthEast')
                legend('boxoff')
                pause
                close all
            end
        end
    end
    clearvars -except VariableData VariableHeading
end