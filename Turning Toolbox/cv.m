function Output = cv(Input)
Mean = nanmean(Input);
SD = nanstd(Input);
Output = (SD/Mean)*100;

%gives the coeffecient of variation