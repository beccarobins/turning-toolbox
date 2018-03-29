function Output = ste(Input)
Output = nanstd(Input)/sqrt(length(Input));

%provides the standard error of the mean