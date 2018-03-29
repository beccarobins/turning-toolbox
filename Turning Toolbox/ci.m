function Output = ci(Input)
SE = ste(Input);
Tscore = tinv([0.025  0.975],length(Input)-1);
Output = nanmean(Input) + Tscore*SE;

%Gives the 95% confidence interval